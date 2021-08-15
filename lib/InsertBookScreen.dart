import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'Book.dart';

class InsertBookScreen extends StatefulWidget {
  const InsertBookScreen({Key? key}) : super(key: key);

  @override
  _InsertBookScreenState createState() => _InsertBookScreenState();
}

class _InsertBookScreenState extends State<InsertBookScreen> {

  TextEditingController idController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController authorController = new TextEditingController();
  TextEditingController priceController = new TextEditingController();


  String buttonName = "Add";
  String appBarText = "Add Book";

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarText)
      ),
        body : Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 0, top:60, right: 0, bottom:0),
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: idController,
                      decoration: _decorate("Enter book id", "Book Id")
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                      controller: nameController,
                      decoration: _decorate("Enter book name", "Book Name")
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: TextField(
                      controller: authorController,
                      decoration: _decorate("Enter Author Name", "Author Name")
                    // ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                      controller: priceController,
                      decoration: _decorate("Enter book price", "Price")
                  ),
                ),
                Container(
                    height: 50,
                    padding: EdgeInsets.fromLTRB(10, 15, 10, 0),
                    child: RaisedButton(
                      textColor: Colors.white,
                      color: Colors.blue,
                      child: Text(buttonName),
                      onPressed: () {
                        _insertOrUpdateBook();
                      },
                    )),
              ],
            )));
      }
  InputDecoration _decorate(String hintText, String labelText) {
    return InputDecoration(
      hintText: hintText,
      labelText: labelText,
      border: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.teal)
      ),
      contentPadding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
    );
  }

  void _insertOrUpdateBook() async{
    try {
      String bookId = idController.text.toString();
      String bookName = nameController.text.toString();
      String authorName = authorController.text.toString();
      double bookPrice = double.parse(priceController.text);
      final firestoreInstance = FirebaseFirestore.instance;
      firestoreInstance.collection("Books").add(
          {
            "name" : bookName,
            "id" : bookId,
            "AutherName" : authorName,
            "BookPrice" : bookPrice
          }).then((value){
               PrintToast("Book Added Successfully...");
               print(value.id);
      });
      Navigator.pop(context,'yes');
    } catch(err) {
      print(err.toString());
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('Wrong input'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, 'Cancel'),
              child: const Text('Ok'),
            ),
          ],
        )
      );
    }
  }
  void PrintToast(String str){
    Fluttertoast.showToast(
        msg: str,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}