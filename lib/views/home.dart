import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unit_converter_app/db/fav_database.dart';
import 'package:unit_converter_app/models/favorites.dart';
import 'package:unit_converter_app/models/unit_measurement.api.dart';
import 'package:unit_converter_app/models/unit_measurement.dart';
import 'package:unit_converter_app/pages/edit_fav_page.dart';
import 'package:unit_converter_app/pages/save_fav_page.dart';

import '../units/unitmeasurements.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AsyncSnapshot<dynamic> asyncSnapShot;
  var _units;
  final myController = TextEditingController();
  final List<String> _measurements = Units.getMeasurements();
  var _list;
  var favDBList;
  String userMeasure = "volume";
  String userValue = "0.0";
  String userFrom = "mm3";
  String userTo = "cm3";
  List<String> measureUnits;
  bool _isLoading = true;
  bool _isDBLoading = true;
  bool _validate = false;
  final drawerKey = GlobalKey<ScaffoldState>();
  List colors = [Color.fromRGBO(40, 40, 40, 1), Color.fromRGBO(46, 46, 46, 1)];

  @override
  void initState() {
    super.initState();
    refreshFavorites();
    measureUnits = Units.getUnits(userMeasure);
    userFrom = measureUnits.first;
    userTo = measureUnits[1];
    getApiUnits(userMeasure, userValue, userFrom, userTo);
  }

  Future refreshFavorites() async {
    setState(() => _isDBLoading = true);
    favDBList = await FavDatabase.instance.readAllNotes();
    setState(() => _isDBLoading = false);
  }

  Future<void> getApiUnits(String measure, value, from, to) async {
    _units = await UnitsApi.getUnits(measure, value, from, to);
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromRGBO(33, 33, 33, 1),
      appBar: buildAppBar(),
      body: _layoutDetails(),
      drawer: _isDBLoading
          ? Center(child: CircularProgressIndicator(color: Colors.amber))
          : buildNavDrawer(),
      floatingActionButton: buildFloatingButton(),
    );
  }

  Widget _layoutDetails() {
    Orientation orientation = MediaQuery.of(context).orientation;

    // Handles Portrait orientation
    if (orientation == Orientation.portrait) {
      return Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.amber))
                : buildFirstHalf(),
          ),
          Expanded(
            flex: 1,
            child: loadAllUnits(),
          ),
        ],
      );
    } else {
      // Handles Landscape orientation
      return Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.amber))
                : buildFirstHalf(),
          ),
          Expanded(
            flex: 1,
            child: loadAllUnits(),
          ),
        ],
      );
    }
  }

  Container buildFirstHalf() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        color: Color.fromRGBO(33, 33, 33, 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            children: [
              Text(
                'Converting ' + userValue + ' ' + _units.fromPlural + ' to:',
                style: TextStyle(
                  height: 2,
                  color: Colors.white,
                  fontSize: 14,
                ),
                textAlign: TextAlign.left,
              ),
              Text(
                _units.result,
                style: TextStyle(
                  height: 2,
                  color: Colors.lightBlueAccent,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                _units.toPlural + '\n',
                style: TextStyle(
                  height: 2,
                  color: Colors.white,
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: myController,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  filled: true,
                  fillColor: Color.fromRGBO(40, 40, 40, 1),
                  hintText: 'Convert to ' + _units.toAbbr,
                  hintStyle: TextStyle(color: Colors.lightBlueAccent),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.calculate, color: Colors.amber),
                  ),
                ),
                style: TextStyle(color: Colors.lightBlueAccent),
                textAlign: TextAlign.right,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Expanded(
                    child: InputDecorator(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 4.0),
                        labelText: 'Convert From',
                        labelStyle: TextStyle(color: Colors.amber),
                        errorText: _validate ? 'Please insert a number' : null,
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      child: leftDropDown(),
                    ),
                  ),
                  Expanded(
                    child: InputDecorator(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 4.0, vertical: 4.0),
                        labelText: 'Convert To',
                        labelStyle: TextStyle(color: Colors.amber),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      child: rightDropDown(),
                    ),
                  ),
                ],
              ),
              convertButton(),
            ],
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: Color.fromRGBO(33, 33, 33, 1),
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          _isLoading ? Text('') : appBarDropDown(),
        ],
      ),
    );
  }

  FutureBuilder loadAllUnits() {
    return FutureBuilder(
      future:
          UnitsApi.getAllUnits(userMeasure, userValue, userFrom, measureUnits),
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator(color: Colors.amber));
        } else {
          asyncSnapShot = snapshot;
          return Container(
            margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
            child: _isLoading
                ? Center(child: CircularProgressIndicator(color: Colors.amber))
                : listViewBuilder(asyncSnapShot),
          );
        }
      },
    );
  }

  DropdownButton<String> appBarDropDown() {
    return DropdownButton<String>(
      value: userMeasure,
      alignment: Alignment.bottomCenter,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.amber),
      iconSize: 24,
      style: const TextStyle(
          decorationColor: Colors.red, color: Colors.amber, fontSize: 16),
      items: _measurements.map<DropdownMenuItem<String>>(
        (String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        },
      ).toList(),
      onChanged: (String value) {
        setState(() {
          userMeasure = value;
          measureUnits = Units.getUnits(userMeasure);
          userFrom = measureUnits.first;
          userTo = measureUnits[1];
          getApiUnits(userMeasure, userValue, userFrom, userTo);
        });
      },
    );
  }

  DropdownButton<String> leftDropDown() {
    return DropdownButton<String>(
      value: userFrom,
      isExpanded: true,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.amber),
      iconSize: 24,
      style: const TextStyle(color: Colors.amber, fontSize: 16),
      onChanged: (String fromValue) {
        setState(() {
          userFrom = fromValue;
          getApiUnits(userMeasure, userValue, userFrom, userTo);
        });
      },
      items: measureUnits.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  DropdownButton<String> rightDropDown() {
    return DropdownButton<String>(
      value: userTo,
      isExpanded: true,
      icon: const Icon(Icons.arrow_drop_down, color: Colors.amber),
      iconSize: 24,
      style: const TextStyle(color: Colors.amber, fontSize: 16),
      onChanged: (String toValue) {
        setState(() {
          userTo = toValue;
          getApiUnits(userMeasure, userValue, userFrom, userTo);
        });
      },
      items: measureUnits.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  ElevatedButton convertButton() {
    return ElevatedButton.icon(
      icon: Icon(Icons.calculate),
      label: Text('Convert'),
      style: ElevatedButton.styleFrom(primary: Colors.lightBlue),
      onPressed: () {
        setState(() {
          if (myController.text.isNotEmpty) {
            _validate = false;
            userValue = myController.text;
            getApiUnits(userMeasure, userValue, userFrom, userTo);
          } else {
            _validate = true;
          }
        });
        myController.clear();
      },
    );
  }

  Drawer buildNavDrawer() {
    return Drawer(
      key: drawerKey,
      backgroundColor: Color.fromRGBO(33, 33, 33, 1),
      child: ListView.builder(
        itemCount: favDBList.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (BuildContext context, int index) {
          return favDBList == null
              ? Text('Nothing')
              : ListTile(
                  leading: CircleAvatar(
                    child: Text((index + 1).toString(),
                        style: TextStyle(color: Colors.white)),
                    backgroundColor: Colors.lightBlue,
                  ),
                  title: Text(
                    favDBList[index].title,
                    style: TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                      'Measure: ' +
                          favDBList[index].navPos +
                          '\nFrom: ' +
                          favDBList[index].fromPos +
                          ' - To: ' +
                          favDBList[index].toPos,
                      style: TextStyle(color: Colors.white)),
                  trailing: IconButton(
                    color: Colors.amber,
                    onPressed: () async {
                      await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => EditFavoritesPage(
                            editID: favDBList[index].id,
                            editTitle: favDBList[index].title,
                            editMeasure: favDBList[index].navPos,
                            editFromPos: favDBList[index].fromPos,
                            editToPos: favDBList[index].toPos),
                      ));

                      refreshFavorites();
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  onTap: () {
                    setState(() {
                      userMeasure = favDBList[index].navPos;
                      measureUnits = Units.getUnits(userMeasure);
                      userFrom = favDBList[index].fromPos;
                      userTo = favDBList[index].toPos;
                      getApiUnits(userMeasure, userValue, userFrom, userTo);
                    });
                    Navigator.pop(context);
                  },
                );
        },
      ),
    );
  }

  FloatingActionButton buildFloatingButton() {
    return FloatingActionButton.extended(
      onPressed: () async {
        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SaveValuesPage(
              saveMeasure: userMeasure,
              saveFromPos: userFrom,
              saveToPos: userTo),
        ));

        refreshFavorites();
      },
      backgroundColor: Colors.lightBlue,
      icon: Icon(Icons.star_border_outlined),
      label: Text('Favorites'),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("My title"),
      content: Text("This is my message."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  ListView listViewBuilder(AsyncSnapshot<dynamic> snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      scrollDirection: Axis.vertical,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          tileColor: colors[index % colors.length],
          leading: Text(
            snapshot.data[index].result,
            style: TextStyle(color: Colors.white),
          ),
          onTap: () {
            setState(() {
              userTo = snapshot.data[index].toAbbr;
              getApiUnits(userMeasure, userValue, userFrom, userTo);
            });
          },
        );
      },
    );
  }
}
