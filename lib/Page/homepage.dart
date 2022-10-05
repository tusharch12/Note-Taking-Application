import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:trans/Page/addNote.dart';
import 'package:trans/speechTotext.dart';

import '../Bucket.dart';
import '../Notcard.dart';
import 'NoteReader.dart';
  
class homa extends StatefulWidget {
  const homa({Key? key}) : super(key: key);

  @override
  State<homa> createState() => _homaState();
}

class _homaState extends State<homa> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 450) / 2;
    final double itemWidth = size.width / 2;
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              toolbarTextStyle: TextStyle(color: Colors.black),
              title: Text(
                'Second Mind',
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              bottom: TabBar(tabs: [
                Tab(
                  text: 'All notes',
                ),
                Tab(
                  text: 'Bucket',
                )
              ]),
            ),

            //
            body: TabBarView(children: [
              Column(children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection("Note")
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        if (snapshot.hasData) {
                          return ListView(
                            // gridDelegate:
                            //     SliverGridDelegateWithFixedCrossAxisCount(
                            //         crossAxisCount: 2),
                            // itemCount: snapshot.hasData
                            //     ? snapshot.data?.docs.length
                            //     : 0,
                            // itemBuilder: (BuildContext context, ind) {
                            //   return Container(
                            //     margin:EdgeInsets.all(10) ,
                            //     height: 150,
                            //     child: Column(
                            //       children: [
                            //         Text(snapshot.data?.docs[ind].data['title']),
                            //         Text(snapshot.data?.docs[ind].data['des'])
                            //       ],
                            //     ),
                            //   );
                            // },

                            children: snapshot.data!.docs
                                .map((Note) => NoteCard(() {
                                      Get.to(NoteReader(Note));
                                      // Navigator.of(context)
                                      //     .push(MaterialPageRoute(
                                      //   builder: (context) => NoteReader(Note),
                                      // ));
                                    }, Note))
                                .toList(),
                          );
                        }
                        return Center(child: Text("No notes"));
                      }),
                ),
              ]),
              Container(
                color: Colors.black,
                padding: EdgeInsets.all(10),
                child: GridView.count(
                  childAspectRatio: (itemWidth / itemHeight),
                  crossAxisCount: 2,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => bucket('Motivation'),
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            // borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(255, 255, 22, 22)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Icon(IconData(5774, fontFamily: 'MaterialIcons')),
                              Text(
                                'Motivation',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(75, 25, 0, 0),
                                child: CircleAvatar(
                                  radius: 20,
                                  backgroundImage: AssetImage(
                                      'assests/image/Motivation.png'),
                                ),
                              ),
                            ]),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => bucket('Motivation'),
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.fromLTRB(16, 16, 0, 0),
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            // borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(255, 234, 173, 87)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Motivation',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                                  height: 50,
                                  width: 50,
                                  child: Image.asset(
                                      'assests/image/Motivation.png'),
                                ),
                              ),
                            ]),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => bucket('Inspiration'),
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(255, 24, 55, 87)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              Image.asset(
                                'assests/image/belive.png',
                                alignment: Alignment.center,
                              ),
                            ]),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => bucket('Spiritual'),
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(255, 0, 74, 173)),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Spiritual',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 2,
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(70, 19, 0, 0),
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage:
                                      AssetImage("assests/image/src.png"),
                                ),
                              )
                            ]),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => bucket('Spiritual'),
                        ));
                      },
                      child: Container(
                        padding: EdgeInsets.all(16),
                        margin: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assests/image/important.png'),
                              fit: BoxFit.fill,
                            ),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(15),
                            color: Color.fromARGB(255, 0, 74, 173)),
                        // child: Image.asset('assests/image/important.png'),
                      ),
                    )
                  ],

                  // gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //     crossAxisCount: 2),
                ),
              )
            ]),
            drawer: Drawer(),
            bottomNavigationBar: BottomAppBar(
              elevation: 0.0,
              child: Row(
                children: [
                  SizedBox(width: 270),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddNote(),
                        ));
                      },
                      icon: Icon(Icons.note)),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => SpeechText(),
                        ));
                      },
                      icon: Icon(Icons.mic))
                ],
              ),
            )));
  }
}
