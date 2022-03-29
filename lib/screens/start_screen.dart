import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:videosdk_flutter_example/screens/login_screen.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  @override
  Widget build(BuildContext context) {
    final ButtonStyle _buttonStyle = TextButton.styleFrom(
      primary: Colors.white,
      backgroundColor: Theme
          .of(context)
          .primaryColor,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Guide Me"),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:  <Widget>[
          const Image(image: AssetImage('assets/images.png')),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                child: const Text("I need visual assistance"),
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
                },
                style: _buttonStyle,
              ),
              TextButton(
                child: const Text("i'd like to volunteer"),
                onPressed: (){
                  Navigator.push(context,
                      MaterialPageRoute(
                      builder: (context) => const LoginScreen()));
                },
                style: _buttonStyle,
              ),
            ],
          )

        ],
      )

    );
  }
}
