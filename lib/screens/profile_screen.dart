
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:videosdk_flutter_example/screens/settings_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:videosdk_flutter_example/screens/start_screen.dart';
import 'package:videosdk_flutter_example/screens/startup_screen.dart';

class ProfileScreen extends StatelessWidget {
  final flutterTts = FlutterTts();
  @override
  void initState(){
  }
  @override
  Widget build(BuildContext context) {
    flutterTts.speak("You are in Profile");
    void logout() async {
      await FirebaseAuth.instance.signOut();
      Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => ProfileScreen()));
    }
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color.fromRGBO(17, 120, 248, 1),Color.fromRGBO(17, 120, 248, 1)],
                  )
              ),
              child: Container(
                width: double.infinity,
                height: 350.0,
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        backgroundImage: NetworkImage(
                          "https://media.istockphoto.com/photos/mask-for-individual-picture-picture-id517169595?b=1&k=20&m=517169595&s=170667a&w=0&h=HIUNT7Gitb0dIWs5Hrj2TY5_dfr2dXnXsMTmk3HD0jQ=",
                        ),
                        radius: 50.0,
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const Text(
                        "Alice",
                        style: TextStyle(
                          fontSize: 22.0,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Card(
                        margin: const EdgeInsets.symmetric(horizontal: 20.0,vertical: 5.0),
                        clipBehavior: Clip.antiAlias,
                        color: Colors.white,
                        elevation: 5.0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 22.0),
                          child: Row(
                            children: [

                              Expanded(
                                child: Column(

                                  children: const [
                                    Text(
                                      "Calls",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "100",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(

                                  children: const [
                                    Text(
                                      "Active",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Text(
                                      "120 hrs",
                                      style: TextStyle(
                                        fontSize: 20.0,
                                        color: Colors.black,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Info:",
                    style: TextStyle(
                        color: Colors.black,
                        fontStyle: FontStyle.normal,
                        fontSize: 28.0
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text('My name is Alice and I am  a Blind .\n'
                      'I work in blind school as a teacher',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),
          Container(
            width: 300.00,

            child: RaisedButton(
                onPressed: (){},
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80.0)
                ),
                elevation: 0.0,
                padding: const EdgeInsets.all(0.0),
                child: Ink(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                        begin: Alignment.centerRight,
                        end: Alignment.centerLeft,
                        colors: [Color.fromRGBO(17, 120, 248, 1),Color.fromRGBO(17, 120, 248, 1)]
                    ),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 300.0, minHeight: 50.0),
                    alignment: Alignment.center,
                    child: const Text("Contact me",
                      style: TextStyle(color: Colors.white, fontSize: 26.0, fontWeight:FontWeight.w300),
                    ),
                  ),
                )
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context) => StartupScreen()));
                },
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
    );
  }
}