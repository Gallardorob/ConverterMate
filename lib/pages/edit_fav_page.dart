import 'package:flutter/material.dart';
import 'package:unit_converter_app/db/fav_database.dart';
import 'package:unit_converter_app/models/favorites.dart';

class EditFavoritesPage extends StatefulWidget {
  //final Favorites fav;
  final int editID;
  final String editTitle;
  final String editMeasure;
  final String editFromPos;
  final String editToPos;

  const EditFavoritesPage({
    Key key,
    @required this.editID,
    @required this.editTitle,
    @required this.editMeasure,
    @required this.editFromPos,
    @required this.editToPos,
  }) : super(key: key);
  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditFavoritesPage> {
  final myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  int id;
  String title;
  String navPos;
  String fromPos;
  String toPos;

  @override
  void initState() {
    super.initState();
    id = widget.editID;
    title = widget.editTitle;
    navPos = widget.editMeasure;
    fromPos = widget.editFromPos;
    toPos = widget.editToPos;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: Color.fromRGBO(33, 33, 33, 1),
        appBar: AppBar(
          title: Text('Edit Screen'),
          backgroundColor: Color.fromRGBO(33, 33, 33, 1),
          actions: [saveButton(), deleteButton()],
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
                  hintText: 'Rename title: "$title"?',
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
          primary: null, //isFormValid ? null : Colors.grey.shade700,
        ),
        onPressed: title == null ? null : updateNote,
        child: Text('Save edit'),
      ),
    );
  }

  Widget deleteButton() => IconButton(
        icon: Icon(Icons.delete, color: Colors.amber),
        onPressed: () async {
          await FavDatabase.instance.delete(widget.editID);

          Navigator.of(context).pop();
        },
      );

  Future updateNote() async {
    final favorite = Favorites(
      id: id,
      title: title,
      navPos: navPos,
      fromPos: fromPos,
      toPos: toPos,
    );

    await FavDatabase.instance.update(favorite);
    Navigator.of(context).pop();
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
