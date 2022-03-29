import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import '../utils/toast.dart';
import 'startup_screen.dart';
import 'register_screen.dart';

// Startup Screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
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
            TextButton(
              onPressed: (){
                //TODO FORGOT PASSWORD SCREEN GOES HERE
              },
              child: const Text(
                'Forgot Password',
                style: TextStyle(color: Colors.blue, fontSize: 15),
              ),
            ),
            Container(
              height: 50,
              width: 250,
              decoration: BoxDecoration(
                  color: Colors.blue, borderRadius: BorderRadius.circular(20)),
              child: TextButton(
                style: _buttonStyle,
                onPressed: () {
                  if(_emailController.text!="" && _passwordController.text!="") {
                    loginUser(_emailController.text, _passwordController.text);
                  }
                  else{
                    toastMsg("Please Fill the required fields");
                  }
                },
                child: const Text(
                  'Login',
                ),
              ),
            ),
            const SizedBox(
              height: 130,
            ),
            RichText(
              text: TextSpan(children: [
                const TextSpan(
                  text: 'new user? ',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
                TextSpan(
                    text: 'Register',
                    style: const TextStyle(
                      color: Colors.blue,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) => RegisterScreen()));
                      }),
              ]),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> loginUser(userEmail,userPassword) async {
    final _auth = FirebaseAuth.instance;

    String email=userEmail, password=userPassword;

    try {
      final newUser = await _auth.signInWithEmailAndPassword(
          email: email, password: password);



      if (newUser != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (_) => StartupScreen()));
      }
    } catch (e) {
      toastMsg(e.toString());
    }
  }
}