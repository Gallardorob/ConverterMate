import 'dart:convert';
import 'package:unit_converter_app/models/unit_measurement.dart';
import 'package:http/http.dart' as http;

class UnitsApi {
  static Future<UnitMesurements> getUnits(
      String measure, value, from, to) async {
    var uri = Uri.https('measurement-unit-converter.p.rapidapi.com',
        '/' + measure, {"value": value, "from": from, "to": to});

    final response = await http.get(uri, headers: {
      "X-RapidAPI-Key": "tokenKey",
      "X-RapidAPI-Host": "measurement-unit-converter.p.rapidapi.com",
      "useQueryString": "true"
    });
    Map data = jsonDecode(response.body);

    return UnitMesurements.fromJson(data);
  }

  static Future<List<UnitMesurements>> getAllUnits(
      String measure, value, from, List<String> entries) async {
    int size = 0;
    return Future.wait<UnitMesurements>(
      entries.map(
        (unit) => http.get(
            Uri.https('measurement-unit-converter.p.rapidapi.com',
                '/' + measure, {"value": value, "from": from, "to": unit}),
            headers: {
              "X-RapidAPI-Key": "tokenKey",
              "X-RapidAPI-Host": "measurement-unit-converter.p.rapidapi.com",
              "useQueryString": "true"
            }).then(
          (response) {
            Map data = jsonDecode(response.body);
            return UnitMesurements.fromListJson(data);
          },
        ),
      ),
    );
  }
}
