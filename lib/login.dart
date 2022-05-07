import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/services/helia_module.dart';

import 'home.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({Key? key}) : super(key: key);

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  String email = 'a';
  String password = 'a';
  bool visible = false;
  bool? rememberMe = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login to your \nAccount',
                textAlign: TextAlign.start,
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 15,
              ),
              Center(
                child: Container(
                    width: MediaQuery.of(context).size.width - 80,
                    height: 50,
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: 'Email',
                        filled: true,
                        fillColor: Color(0xffFAFAFA),
                        border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.transparent),
                            borderRadius:
                                BorderRadius.all(Radius.circular(24))),
                      ),
                    )),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 25,
              ),
              Center(
                child: Container(
                    width: MediaQuery.of(context).size.width - 80,
                    height: 50,
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !visible,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          hintText: 'Password',
                          filled: true,
                          fillColor: Color(0xffFAFAFA),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.transparent),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24))),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  visible = !visible;
                                });
                              },
                              icon: Icon(visible
                                  ? Icons.visibility_off
                                  : Icons.visibility))),
                    )),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 25,
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: rememberMe,
                      onChanged: (v) {
                        setState(() {
                          rememberMe = v;
                        });
                      },
                    ),
                    Text(
                      'Remember Me',
                      style:
                          TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    signIn(
                      email: email,
                      password: password,
                    );
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: Center(
                        child: Text(
                      'sign in',
                      style: TextStyle(fontSize: 20),
                    )),
                  ),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                ),
              ),
              Center(
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'forgot the passwprd?',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 25,
              ),
              Center(
                child: Text(
                  'or continue with',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Provider.of<myProvider>(context, listen: false)
                          .signInWithFacebook()
                          .then((value) {
                        if (value == 'done') {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                            return homeScreen();
                          }));
                        } else if (value == 'cancel') {
                          print('cancel');
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text('error has been occurred'),
                                );
                              });
                        }
                      });
                    },
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset('assets/images/facebook.png'),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      await Provider.of<myProvider>(context, listen: false)
                          .signInWithGoogle();

                      FirebaseAuth.instance.currentUser != null
                          ? Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) {
                              return homeScreen();
                            }))
                          : null;
                    },
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Image.asset('assets/images/google.png'),
                    ),
                  ),
                  if (Theme.of(context).platform == TargetPlatform.iOS)
                    InkWell(
                      onTap: () {},
                      child: SizedBox(
                        height: 40,
                        width: 40,
                        child: Image.asset('assets/images/apple.png'),
                      ),
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  signIn({required email, required password}) async {
    if (email != 'a' && password != 'a') {
      Provider.of<myProvider>(context, listen: false)
          .signInWithEmail(email: email, password: email, context: context);
    }
  }
}
