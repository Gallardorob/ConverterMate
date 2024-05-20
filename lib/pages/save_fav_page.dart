import 'package:flutter/material.dart';
import 'package:unit_converter_app/db/fav_database.dart';
import 'package:unit_converter_app/models/favorites.dart';

class SaveValuesPage extends StatefulWidget {
  //final Favorites fav;
  final String saveMeasure;
  final String saveFromPos;
  final String saveToPos;

  const SaveValuesPage({
    Key key,
    @required this.saveMeasure,
    @required this.saveFromPos,
    @required this.saveToPos,
  }) : super(key: key);
  @override
  _SavePageState createState() => _SavePageState();
}

class _SavePageState extends State<SaveValuesPage> {
  final myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String title;
  String navPos;
  String fromPos;
  String toPos;

  @override
  void initState() {
    super.initState();
    navPos = widget.saveMeasure;
    fromPos = widget.saveFromPos;
    toPos = widget.saveToPos;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color.fromRGBO(33, 33, 33, 1),
        appBar: AppBar(
          title: Text('Save Screen'),
          backgroundColor: Color.fromRGBO(33, 33, 33, 1),
          actions: [saveButton()],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(26.0),
              child: TextField(
                controller: myController,
                onChanged: (value) {
                  setState(() {
                    title = value;
                  });
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  filled: true,
                  fillColor: Color.fromRGBO(40, 40, 40, 1),
                  hintText: 'Please add a title to the selection.',
                  hintStyle: TextStyle(color: Colors.lightBlueAccent),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.lightBlueAccent),
              ),
            ),
            Text(
                'Current measurement: $navPos \nCurrent from unit: $fromPos \nCurrent to unit: $toPos',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.left),
          ],
        ),
      );

  Widget saveButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: null,
        ),
        onPressed: title == null ? null : addNote,
        child: Text('Save'),
      ),
    );
  }

  Future addNote() async {
    final favorite = Favorites(
      title: title,
      navPos: navPos,
      fromPos: fromPos,
      toPos: toPos,
    );
    await FavDatabase.instance.create(favorite);

    Navigator.of(context).pop();
  }
}
