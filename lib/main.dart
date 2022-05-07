import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/services/helia_module.dart';
import 'package:test/splash.dart';

void main(List<String> args) async {
  runApp(ChangeNotifierProvider(
      create: (_) => myProvider(), child: const helia()));
  print(FirebaseAuth.instance.currentUser!.uid);
}

class helia extends StatelessWidget {
  const helia({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Helia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: splashScreen(),
    );
  }
}
