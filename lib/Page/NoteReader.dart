import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NoteReader extends StatefulWidget {
  NoteReader(this.docs, {Key? key}) : super(key: key);
  QueryDocumentSnapshot docs;

  @override
  State<NoteReader> createState() => _NoteReaderState();
}

class _NoteReaderState extends State<NoteReader> {
  TextEditingController _editTitle = TextEditingController();
  TextEditingController _editContent = TextEditingController();
  CollectionReference ref = FirebaseFirestore.instance.collection("Note");
  void word() {
    setState(() {
      _editTitle = TextEditingController(text: 'hello ji');
    });
  }

  void initState() {
    _editTitle = TextEditingController();
    _editContent = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    String _title = widget.docs["title"];
    if (_title == Null) {
      _title = widget.docs['des'];
    }
    String _des = widget.docs["des"];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              _title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Text(
              _des,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            ref.doc('2').update({
              'title': _editTitle,
              'des': _editContent,
            });
          },
          child: Icon(Icons.update)),
    );
  }
}
