import 'dart:async';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';

import 'splash_screen.dart';

class guideline extends StatefulWidget {
  const guideline({Key? key}) : super(key: key);

  @override
  State<guideline> createState() => _guidelineState();
}

class _guidelineState extends State<guideline> {
  // late StreamSubscription<User?> user;
  final flutterTts = FlutterTts();
  String guide='''
  
  
  Welcome to Guide Me app..
  This app is made for people who need assistance in their day to day activities.
   
  There is a mic button everywhere in the app and it is located at the bottom of the screen.
  
  Press the mic and speak 'Help' to get help anytime''';
  Text guidelines= new Text('''                            Guidelines
  
   Welcome to Guide Me app
  This app is made for people who need assistance in their day to day activities.
  
  There is a mic button everywhere in the app and it is located at the bottom of the screen.
  
  Press the mic and speak 'Help' to get help anytime.''',maxLines: 20, style: TextStyle(fontSize: 26.0 ,fontWeight:FontWeight.bold,color: Colors.white70) , );
  @override
  void initState() {
    super.initState();
    flutterTts.speak("Here are the things you should know before using this app");
    flutterTts.speak(guide);

    Timer(const Duration(seconds: 15), () {


      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const SplashScreen()));
    });

  }

  @override

  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: const Color.fromRGBO(10, 13, 44, 1),
      body: Stack(
        children: [
          Center(
              child: guidelines  ),

        ],
      ),
    );
  }
}
