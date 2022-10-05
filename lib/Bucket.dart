import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'Notcard.dart';
import 'Page/NoteReader.dart';

class bucket extends StatefulWidget {
  bucket(this.title, {Key? key}) : super(key: key);
  String title;
  @override
  State<bucket> createState() => _bucketState();
}

class _bucketState extends State<bucket> {
  @override
  Widget build(BuildContext context) {
    String title = widget.title;
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection(title).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  return ListView(
                    // gridDelegate:
                    //     SliverGridDelegateWithFixedCrossAxisCount(
                    //         crossAxisCount: 2),
                    children: snapshot.data!.docs
                        .map((title) => NoteCard(() {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => NoteReader(title),
                              ));
                            }, title))
                        .toList(),
                  );
                }
                return Text("No notes");
              }),
        ),
      ]),
    );
  }
}
