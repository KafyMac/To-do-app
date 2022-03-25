import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'home_screen.dart';
import './services/google_auth.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String imageUrl =
      'https://i.pinimg.com/474x/42/fd/6d/42fd6d684bb385500158664895235df4.jpg';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.fill,
        )),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Create and Manage your Notes",
                  style: TextStyle(
                    fontSize: 36,
                    fontFamily: "lato",
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    signup(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Continue with Google",
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: "lato",
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Image(
                        image: AssetImage("assets/images/google.png"),
                        height: 30.0,
                      ),
                    ],
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
                    padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 7.0),
                    ),
                  ),
                ),

                //
                SizedBox(
                  height: 12.5,
                ),
                RichText(
                    text: TextSpan(
                  text: 'Already have an account? ',
                  children: [
                    TextSpan(
                      text: 'Log in',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
