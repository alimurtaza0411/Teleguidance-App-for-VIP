import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:videosdk_flutter_example/screens/login_screen.dart';

import '../utils/toast.dart';
import 'login_screen.dart';

// Startup Screen
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    _cpasswordController.dispose();
  }

  @override
  void initState() {
    super.initState();
  }


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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60.0),
              child: Center(
                child: Container(
                    width: 200,
                    height: 150,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/logo.jpg')),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter valid email id as abc@gmail.com'),
              ),
            ),
           Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, top: 15, bottom: 0),
              //padding: EdgeInsets.symmetric(horizontal: 15),
              child: TextField(
                controller: _cpasswordController,
                obscureText: true,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password',
                    hintText: 'Enter secure password'),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              margin: const EdgeInsets. symmetric(vertical: 10.0, horizontal: 0),
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                style: _buttonStyle,
                onPressed: () {
                  if(_passwordController.text == _cpasswordController.text) {
                    registerUser(_emailController.text, _passwordController.text);
                  }
                  else{
                    toastMsg("Paswords does not match");
                  }
                },
                child: const Text(
                  'Register',
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            RichText(
              text: TextSpan(children: [
                const TextSpan(
                  text: 'Already have account? ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                    text: 'Login',
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                      }),
              ]),
            ),
          ],
        ),
      ),
    );

  }

  Future<void> registerUser(userEmail, userPassword) async {
    final _auth = FirebaseAuth.instance;
    String email=userEmail, password=userPassword;
    try {
      final newUser = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // print(newUser);
      if (newUser != null) {
        Navigator.push(context,
          MaterialPageRoute(
              builder: (context) => const LoginScreen()),
        );
      }
    }
    catch (e)
    {
      toastMsg(e.toString());
      // print(e);
    }


    // Navigator.push(
    //     context, MaterialPageRoute(builder: (_) => StartupScreen()));
  }
}