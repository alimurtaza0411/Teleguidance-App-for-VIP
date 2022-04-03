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
  
  
  
  This app is made for people who need assistance during calling.
  
  You will need to signup or login to use this app.
  
  Tap and speak connect to start the calling. Once done and connected, a volunteer will connect you.
  
  You can also access settings and profile through voice from the previous step.''';
  Text guidelines= new Text('''                            Guidelines
  
  
  
  This app is made for people who need assistance during calling.
 
  You will need to signup or login to use this app.
 
  Tap and speak connect to start the calling. Once done and connected, a volunteer will connect you.
 
  You can also access settings and profile through voice from the previous step.''',maxLines: 20, style: TextStyle(fontSize: 26.0 ,fontWeight:FontWeight.bold,color: Colors.white70) , );
  @override
  void initState() {
    super.initState();
    flutterTts.speak("Here are the things you should know before using this app");
    flutterTts.speak(guide);

    Timer(const Duration(seconds: 20), () {


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
