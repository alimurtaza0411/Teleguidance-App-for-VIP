import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:videosdk_flutter_example/screens/login_screen.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:videosdk_flutter_example/screens/profile_screen.dart';
import 'package:videosdk_flutter_example/screens/startup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool lockInBackground = true;
  bool notificationsEnabled = true;
  bool isSwitched = false;
  bool islistening = false;
  var _speech;
  String settingtext ="";
  final flutterTts = FlutterTts();
  @override
  void initState(){
    super.initState();
    flutterTts.speak("You are in settings");
    _speech = SpeechToText();
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
  void logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context) => ProfileScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Settings')),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Common'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.format_color_text ),
                title: Text('Language'),
                value: Text('English'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: true,
                leading: Icon(Icons.format_paint),
                title: Text('Enable custom theme'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('GuideMe '),
                value: Text('V2.1'),
              ),
              SettingsTile.switchTile(
                onToggle: (value) {},
                initialValue: true,
                leading: Icon(Icons.mode_night ),
                title: Text('Enable Night Mode'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.arrow_drop_down),
                title: Text('Change Voice Actor'),
                value: Text('Kiara'),
              ),
              SettingsTile.navigation(
                leading: Icon(Icons.language),
                title: Text('Call Guideme Helpline'),
                value: Text('Toll-free'),
              ),
            ],
          ),
        ],
      ),
    );
  }
  Future toggle() => toggleRecording(
      onResult: (text) async{
        setState(() => this.settingtext = text);
        if(text==""){

        }
        else if(text=="settings") {
          text = "";
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => const SettingScreen()));
        }
        else if(text=="home"){
          text = "";
          // flutterTts.speak("You are in Profile");
          Navigator.push(context,
              MaterialPageRoute(
                  builder: (context) => StartupScreen()));
        }
        else if(text=="logout"){
          text = "";
          logout();
        }
        else
        {
          text = "";
          flutterTts.speak("Invalid command Please try again.");
        }
        text = "";
      },
      onListening: (listening) {

      }
  );
}
