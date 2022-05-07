import 'dart:async';
import 'dart:ffi';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/services/helia_module.dart';
import 'package:test/home.dart';
import 'package:test/login.dart';
import 'package:test/welcome.dart';

class splashScreen extends StatefulWidget {
  const splashScreen({Key? key}) : super(key: key);

  @override
  State<splashScreen> createState() => _splashScreenState();
}

class _splashScreenState extends State<splashScreen>
    with SingleTickerProviderStateMixin {
  double raduis = 30.0;

  String selectedId = '';
  List<String> ids = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'];
  void setId() async {
    for (String id in ids) {
      setState(() {
        selectedId = id;
      });
      await Future.delayed(Duration(milliseconds: 100));
    }
    setId();
  }

  navigate() async {
    WidgetsFlutterBinding.ensureInitialized();

    await Firebase.initializeApp();
    await Future.delayed(Duration(seconds: 3));
    Provider.of<myProvider>(context, listen: false).signedIn
        ? Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => homeScreen()))
        : Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => welcomeScreen()));
  }

  @override
  void initState() {
    setId();
    navigate();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.PNG',
            color: Colors.green,
          ),
          Container(
            height: MediaQuery.of(context).size.height / 6,
          ),
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                dot(
                    id: 'a',
                    width: 5.0,
                    Offset: Offset(raduis * cos(pi / 4), raduis * sin(pi / 4))),
                dot(
                    id: 'b',
                    width: 7.5,
                    Offset: Offset(
                        raduis * cos(2 * pi / 4), raduis * sin(2 * pi / 4))),
                dot(
                    id: 'c',
                    width: 10.0,
                    Offset: Offset(
                        raduis * cos(3 * pi / 4), raduis * sin(3 * pi / 4))),
                dot(
                    id: 'd',
                    width: 12.0,
                    Offset: Offset(
                        raduis * cos(4 * pi / 4), raduis * sin(4 * pi / 4))),
                dot(
                    id: 'e',
                    width: 14.0,
                    Offset: Offset(
                        raduis * cos(5 * pi / 4), raduis * sin(5 * pi / 4))),
                dot(
                    id: 'f',
                    width: 16.5,
                    Offset: Offset(
                        raduis * cos(6 * pi / 4), raduis * sin(6 * pi / 4))),
                dot(
                    id: 'g',
                    width: 18.0,
                    Offset: Offset(
                        raduis * cos(7 * pi / 4), raduis * sin(7 * pi / 4))),
                dot(
                    id: 'h',
                    width: 20.0,
                    Offset: Offset(
                        raduis * cos(8 * pi / 4), raduis * sin(8 * pi / 4)))
              ],
            ),
          )
        ],
      )),
    );
  }

  Transform dot({required width, required Offset, required id}) {
    return Transform.translate(
      offset: Offset,
      child: Center(
        child: AnimatedContainer(
          duration: id == selectedId
              ? Duration(milliseconds: 100)
              : Duration(milliseconds: 700),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff25C569),
          ),
          width: id == selectedId ? 20.0 : 5.0,
          height: id == selectedId ? 20.0 : 5.0,
        ),
      ),
    );
  }
}
