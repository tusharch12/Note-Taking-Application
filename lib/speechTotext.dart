import 'package:avatar_glow/avatar_glow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:trans/Page/homepage.dart';
import 'package:trans/trans.dart';
import 'package:translator/translator.dart';

class SpeechText extends StatefulWidget {
  const SpeechText({
    Key? key,
  }) : super(key: key);

  @override
  State<SpeechText> createState() => _SpeechTextState();
}

class _SpeechTextState extends State<SpeechText> {
  GoogleTranslator _translator = GoogleTranslator();

  SpeechToText _stt = SpeechToText();
  String word = '';
  bool _isListen = false;
  bool _isLisning = false;
  String _lastWord = '';
  String _title1 = "";
  String _status = '';

  void check(val) {
    if (val == 'done') {
      _stopListening();
    }
  }

  void initState() {
    super.initState();
    _initSpeech();
  }

  void _initSpeech() async {
    _isLisning = await _stt.initialize(onStatus: (val) => check(val));
    setState(() {});
  }

  void _startListening() async {
    await _stt.listen(onResult: _onSpeechResult);
    setState(() {
      _isListen = true;
    });
  }

  void _stopListening() async {
    await _stt.stop();
    setState(() {
      _isListen = false;
      _title1 = _contentController.text;
    });
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWord = result.recognizedWords;
      _contentController =
          TextEditingController(text: _title1 + ' ' + _lastWord);

      // if (_titleController.text == null) {
      //   _titleController =
      //       TextEditingController(text: _contentController.text[10]);
      // }
    });
  }

  String bucket_name = '';

  void save(String) {
    FirebaseFirestore.instance.collection(bucket_name).add({
      "title": _titleController.text,
      "des": _contentController.text,
      // "date": date,
    }).then((value) {
      Navigator.pop(context);
    }).catchError((error) => print("Faild to add new note $error"));

    Get.offAll(homa());
  }

  TextEditingController _titleController = TextEditingController();

  TextEditingController _contentController = TextEditingController();

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Speech Note'),
        actions: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                showAlertDialog(context);
                setState(() {
                  word = _contentController.text;
                });
              });
            },
            child: Icon(
              Icons.translate,
              size: 26.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                Get.defaultDialog(
                    title: 'Bucket',
                    middleText: ' choose any one of these',
                    actions: [
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              bucket_name = 'Inspiration';
                              save(bucket_name);
                            },
                            child: Text(
                              'Inspiration',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: () {
                                bucket_name = "Motivation";
                                save(bucket_name);
                              },
                              child: Text(
                                'Motivation',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              bucket_name = 'Note';
                              save(bucket_name);
                            },
                            child: Text(
                              'Note',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ]);
              },
              child: Icon(
                Icons.category,
                size: 26.0,
              ),
            ),
          )
        ],
      ),
      floatingActionButton: AvatarGlow(
        animate: _isListen,
        endRadius: 75,
        glowColor: Colors.green,
        child: FloatingActionButton(
          onPressed: _stt.isNotListening ? _startListening : _stopListening,
          child: Icon(Icons.mic),
          tooltip: 'Tap to start mic',
          backgroundColor: Colors.black,
        ),
      ),

// Body of the page
      body: Container(
        padding: EdgeInsets.fromLTRB(16, 10, 16, 16),
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
          // Text(
          //   "Hello",
          //   textAlign: TextAlign.start,
          // ),
          SizedBox(height: 20),
          TextField(
            maxLength: null,
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

  void Translator(String value) {
    switch (value) {
      case 'English':
        _translator.translate(word, to: 'en').then((output) {
          setState(() {
            word = output.toString();
            _contentController = TextEditingController(text: word);
          });
        });
        break;
      case 'hindi':
        _translator.translate(word, to: 'hi').then((output) {
          setState(() {
            word = output.toString();
            _contentController = TextEditingController(text: word);
          });
        });
        break;

      case 'French':
        _translator.translate(word, to: 'fr').then((output) {
          setState(() {
            word = output.toString();
            _contentController = TextEditingController(text: word);
          });
        });
        break;

      case 'German':
        _translator.translate(word, to: 'de').then((output) {
          setState(() {
            word = output.toString();
            _contentController = TextEditingController(text: word);
          });
        });
        break;

      case 'Gujrati':
        _translator.translate(word, to: 'gu').then((output) {
          setState(() {
            word = output.toString();
            _contentController = TextEditingController(text: word);
          });
        });
        break;
    }
    _translator.translate(word, to: 'hi').then((output) {
      setState(() {
        word = output.toString();
        _contentController = TextEditingController(text: word);
      });
    });
  }

  showAlertDialog(BuildContext context) {
    // set up the list options
    Widget optionOne = SimpleDialogOption(
      child: Text(
        'English',
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        Translator('English');
      },
    );
    Widget optionTwo = SimpleDialogOption(
      child: const Text(
        'Hindi',
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        Translator('hindi');
      },
    );
    Widget optionThree = SimpleDialogOption(
      child: const Text(
        'French',
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        Translator('French');
      },
    );

    Widget optionFour = SimpleDialogOption(
      child: Text(
        'German',
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        Translator('German');
      },
    );

    Widget optionFive = SimpleDialogOption(
      child: const Text(
        'Gujarati',
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        Translator('Gujarati');
      },
    );

    // set up the SimpleDialog
    SimpleDialog dialog = SimpleDialog(
      title: const Text(
        'Choose Language',
        textAlign: TextAlign.center,
      ),
      children: <Widget>[
        optionOne,
        optionTwo,
        optionThree,
        optionFour,
        optionFive,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }
}
