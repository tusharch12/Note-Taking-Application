import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'homepage.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String date = DateTime.now().toString();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance.collection('Note').add({
            "title": _titleController.text,
            "des": _contentController.text,
          }).then((value) {
            Navigator.pop(context);
          }).catchError((error) => print("Faild to add new note $error"));
          Get.offAll(homa());
        },
        child: Icon(Icons.save),
        backgroundColor: Colors.black,
      ),
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 50, 16, 16),
        margin: EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            keyboardType: TextInputType.multiline,
            maxLength: null,
            maxLines: null,
            controller: _titleController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'title',
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          SizedBox(
            height: 7.0,
          ),
          SizedBox(height: 20),
          TextField(
            maxLines: null,
            controller: _contentController,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: 'Content',
              hintStyle: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ]),
      ),
    );
  }
}
