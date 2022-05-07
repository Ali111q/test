import 'package:flutter/material.dart';
import 'package:test/login.dart';

class welcomeScreen extends StatelessWidget {
  const welcomeScreen({Key? key}) : super(key: key);
  gtLogin({context}) async {
    await Future.delayed(Duration(seconds: 5));
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => loginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    gtLogin(context: context);
    return Stack(
      children: [
        Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Image.asset(
              'assets/images/welcome.png',
              fit: BoxFit.fill,
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome to',
                  style: TextStyle(color: Colors.white, fontSize: 30),
                ),
                Container(
                  height: 10,
                ),
                Text(
                  'Helia',
                  style: TextStyle(
                      color: Colors.green,
                      fontSize: 46,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 10,
                ),
                Text(
                  'the best hotel booking in the centry \n the accumpany your vacation',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
