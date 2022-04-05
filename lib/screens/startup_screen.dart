// ignore_for_file: non_constant_identifier_names, dead_code

import 'dart:convert';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
// import 'package:videosdk_flutter_example/api/speech_api.dart';
import 'package:videosdk_flutter_example/screens/profile_screen.dart';
import 'package:videosdk_flutter_example/screens/settings_screen.dart';
import 'package:videosdk_flutter_example/screens/start_screen.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../utils/spacer.dart';
import '../utils/toast.dart';
import 'meeting_screen.dart';
import 'start_screen.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/cupertino.dart';
import 'package:speech_to_text/speech_to_text.dart';


// Startup Screen
class StartupScreen extends StatefulWidget {
  const StartupScreen({Key? key}) : super(key: key);

  @override
  State<StartupScreen> createState() => _StartupScreenState();
}

class _StartupScreenState extends State<StartupScreen> {
  String _token = "";
  String _meetingID = "";
  final flutterTts = FlutterTts();
  String text = "speak the command";
  bool islistening = false;
  var _speech;
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const StartScreen()));
  }

  @override
  void initState(){
    super.initState();
    fetchToken().then((token) => setState(() => _token = token));
    flutterTts.speak("There are 20 registered volunteers available to assist you. If you need help, tap on mic and say help anytime");
    _speech = SpeechToText();
    // _initSpeech();
  }
  Future<bool> toggleRecording({
    required Function(String text) onResult,
    required ValueChanged<bool> onListening,
  }) async {
    if (_speech.isListening) {
      _speech.stop();
      return true;
    }

    final isAvailable = await _speech.initialize(
      onStatus: (status) => onListening(_speech.isListening),
      onError: (e) => print('Error: $e'),
    );

    if (isAvailable) {
      _speech.listen(onResult: (value) => onResult(value.recognizedWords));
    }

    return isAvailable;
  }

  /// This has to happen only once per app


  void startCall() async {
    _meetingID = await createMeeting();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MeetingScreen(
          token: _token,
          meetingId: _meetingID,
          displayName: "Shiv Dube",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Future _speak() async{
    //     await flutterTts.speak("Welcome to Guide Me App");
    // }
    final ButtonStyle _buttonStyle = TextButton.styleFrom(
      primary: Colors.white,
      backgroundColor: Theme.of(context).primaryColor,
      textStyle: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("Guide Me"),
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: _token.isEmpty
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const CircularProgressIndicator(),
                    verticalSpacer(12),
                    const Text("Initialization"),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: TextButton(
                      style: _buttonStyle,
                      onPressed: ()  {
                        startCall();
                      },
                      child: const Text("Connect Volunteer"),
                    ),
                  ),
                  verticalSpacer(20),
                  // const Text(
                  //   "OR",
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.white,
                  //     fontSize: 24,
                  //   ),
                  // ),
                  // verticalSpacer(20),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  //   child: TextField(
                  //     onChanged: (meetingID) => _meetingID = meetingID,
                  //     decoration: InputDecoration(
                  //       border: const OutlineInputBorder(),
                  //       fillColor: Theme.of(context).primaryColor,
                  //       labelText: "Enter Meeting ID",
                  //       hintText: "Meeting ID",
                  //       prefixIcon: const Icon(
                  //         Icons.keyboard,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  // verticalSpacer(20),
                  // TextButton(
                  //   onPressed: () async {
                  //     if (_meetingID.isEmpty) {
                  //       toastMsg("Please, Enter Valid Meeting ID");
                  //       return;
                  //     }
                  //     if (await validateMeeting(_meetingID)) {
                  //       Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => JoinScreen(
                  //             meetingId: _meetingID,
                  //             token: _token,
                  //           ),
                  //         ),
                  //       );
                  //     } else {
                  //       toastMsg("Invalid Meeting ID");
                  //     }
                  //   },
                  //   style: _buttonStyle,
                  //   child: const Text("JOIN MEETING"),
                  // ),
                  // Text(text),
                  Container(
                    color: Colors.blueAccent,
                    child: IconButton(
                      onPressed: () async{
                        islistening = true;
                        await toggle();
                        islistening = false;
                      },
                      tooltip: 'Listen',
                      icon: Icon(islistening
                          ? Icons.mic
                          : Icons.mic_off),
                      padding: EdgeInsets.all(100.0),

                    ),
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      IconButton(
                        onPressed: () {},
                        icon: new Icon(Icons.home),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(
                                  builder: (context) => const SettingScreen()));
                        },
                        icon: const Icon(Icons.settings),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.push(context,
                          MaterialPageRoute(
                          builder: (context) => ProfileScreen()));
                          },
                        icon: const Icon(Icons.person),
                      ),
                      IconButton(
                        onPressed: () {
                          logout();
                        },
                        icon: const Icon(Icons.logout),
                      ),
                    ],
                  ),
                ],
              ),
      ),
    );
  }
  Future toggle() => toggleRecording(
          onResult: (text) async{
            setState(() => this.text = text);
            if(text==""){

            }
            else if(text=="connect"){
              text = "";
              startCall();
            }
            else if(text=="settings") {
              text = "";
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => const SettingScreen()));
            }
            else if(text=="profile"){
              text = "";
              // flutterTts.speak("You are in Profile");
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen()));
            }
            else if(text=="logout"){
              text = "";
              logout();
            }
            else if(text=="help"){
              text = "";
              flutterTts.speak("You are currently on home page... You can connect to registered volunteer by using the mic button located at the bottom and saying the word connect or you can click on connect button on top of the screen... you can go to settings by settings command and on profile page using profile command.");
            }
            else
            {
              text = "";
              flutterTts.speak("Invalid command Please try again.");
            }
            text = "";
          },
          onListening: (listening) {
            // setState(() => islistening = listening);
            // if(!listening){
            //   if(text==""){
            //
            //   }
            //   else if(text=="connect"){
            //     text = "";
            //     startCall();
            //   }
            //   else if(text=="settings") {
            //     text = "";
            //     Navigator.push(context,
            //         MaterialPageRoute(
            //             builder: (context) => const SettingScreen()));
            //   }
            //   else if(text=="profile"){
            //     text = "";
            //     // flutterTts.speak("You are in Profile");
            //     Navigator.push(context,
            //         MaterialPageRoute(
            //             builder: (context) => ProfileScreen()));
            //   }
            //   else if(text=="logout"){
            //     text = "";
            //     logout();
            //   }
            //   else
            //     {
            //       flutterTts.speak("Invalid command Please try again.");
            //     }
            // }
            // text = "";
          }
  );

  Future<String> fetchToken() async {
    final String? _AUTH_URL = dotenv.env['AUTH_URL'];
    String? _AUTH_TOKEN = dotenv.env['AUTH_TOKEN'];

    if ((_AUTH_TOKEN?.isEmpty ?? true) && (_AUTH_URL?.isEmpty ?? true)) {
      toastMsg("Please set the environment variables");
      throw Exception("Either AUTH_TOKEN or AUTH_URL is not set in .env file");
      return "";
    }

    if ((_AUTH_TOKEN?.isNotEmpty ?? false) &&
        (_AUTH_URL?.isNotEmpty ?? false)) {
      toastMsg("Please set only one environment variable");
      throw Exception("Either AUTH_TOKEN or AUTH_URL can be set in .env file");
      return "";
    }

    if (_AUTH_URL?.isNotEmpty ?? false) {
      final Uri getTokenUrl = Uri.parse('$_AUTH_URL/get-token');
      final http.Response tokenResponse = await http.get(getTokenUrl);
      _AUTH_TOKEN = json.decode(tokenResponse.body)['token'];
    }

    log("Auth Token: $_AUTH_TOKEN");

    return _AUTH_TOKEN ?? "";
  }

  Future<String> createMeeting() async {
    final String? _VIDEOSDK_API_ENDPOINT = dotenv.env['VIDEOSDK_API_ENDPOINT'];

    final Uri getMeetingIdUrl = Uri.parse('$_VIDEOSDK_API_ENDPOINT/meetings');
    final http.Response meetingIdResponse =
        await http.post(getMeetingIdUrl, headers: {
      "Authorization": _token,
    });

    final meetingId = json.decode(meetingIdResponse.body)['meetingId'];

    log("Meeting ID: $meetingId");

    return meetingId;
  }

  Future<bool> validateMeeting(String _meetingId) async {
    final String? _VIDEOSDK_API_ENDPOINT = dotenv.env['VIDEOSDK_API_ENDPOINT'];

    final Uri validateMeetingUrl =
        Uri.parse('$_VIDEOSDK_API_ENDPOINT/meetings/$_meetingId');
    final http.Response validateMeetingResponse =
        await http.post(validateMeetingUrl, headers: {
      "Authorization": _token,
    });

    return validateMeetingResponse.statusCode == 200;
  }
}
