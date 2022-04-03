import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'constants/colors.dart';
import 'navigator_key.dart';
import 'screens/guidelines.dart';

void main() async {
  // Load Environment variables
  await dotenv.load(fileName: ".env");

  // Run Flutter App
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Material App
    return FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return const MaterialApp(
            home: Center(
              child: Text('404'),
            )
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'Guide Me',
            theme: ThemeData.dark().copyWith(
              appBarTheme: const AppBarTheme().copyWith(
                color: primaryColor,
              ),
              primaryColor: primaryColor,
              backgroundColor: secondaryColor,
            ),
            home: const guideline(),
            navigatorKey: navigatorKey,
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return const Scaffold(
          body:Center(
            child: Icon(
              Icons.import_contacts,
            ),
          )
        );
      },
    );










  }
}
