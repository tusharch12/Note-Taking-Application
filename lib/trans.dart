import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

class Homapage extends StatefulWidget {
  const Homapage({Key? key}) : super(key: key);

  @override
  State<Homapage> createState() => _HomapageState();
}

class _HomapageState extends State<Homapage> {
  GoogleTranslator _translator = GoogleTranslator();
  String word =
      'Hey Myself Tushar Chaturvedi. I am study in Jaipur Engeering collage. i am working on a project second mind';

  TextEditingController _desController = TextEditingController();

  void Translator(String value) {
    switch (value) {
      case 'English':
        _translator.translate(word, to: 'en').then((output) {
          setState(() {
            word = output.toString();
            _desController = TextEditingController(text: word);
          });
        });
        break;
      case 'hindi':
        _translator.translate(word, to: 'hi').then((output) {
          setState(() {
            word = output.toString();
            _desController = TextEditingController(text: word);
          });
        });
        break;

      case 'French':
        _translator.translate(word, to: 'fr').then((output) {
          setState(() {
            word = output.toString();
            _desController = TextEditingController(text: word);
          });
        });
        break;

      case 'German':
        _translator.translate(word, to: 'de').then((output) {
          setState(() {
            word = output.toString();
            _desController = TextEditingController(text: word);
          });
        });
        break;

      case 'Gujrati':
        _translator.translate(word, to: 'gu').then((output) {
          setState(() {
            word = output.toString();
            _desController = TextEditingController(text: word);
          });
        });
        break;
    }
    _translator.translate(word, to: 'hi').then((output) {
      setState(() {
        word = output.toString();
        _desController = TextEditingController(text: word);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Translator'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: GestureDetector(
              onTap: () {
                showAlertDialog(context);
                setState(() {
                  word = _desController.text;
                });
              },
              child: Icon(Icons.translate),
            ),
          )
        ],
      ),
      body: Container(
          padding: EdgeInsets.all(16.0),
          child: TextField(
              controller: _desController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'title',
                hintStyle: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ))),
    );
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
