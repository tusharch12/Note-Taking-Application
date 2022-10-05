import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget NoteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          // color: Colors.blueGrey,
          gradient: LinearGradient(colors: [
            Color.fromARGB(
              255,
              34,
              193,
              195,
            ),
            Color.fromARGB(255, 253, 187, 45)
          ])),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          doc["title"],
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          doc["des"],
          // overflow: TextOverflow.ellipsis,
          style: TextStyle(
              // fontWeight: FontWeight.bold,
              ),
        ),
      ]),
    ),
  );
}
