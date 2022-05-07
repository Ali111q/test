// ignore_for_file: invalid_required_positional_param

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../home.dart';

class hotel {
  final hotelId;
  final hotelName;
  final nightPrice;
  final place;
  final photos;
  final details;
  final description;
  final facilites;
  final review;

  hotel({
    @required this.hotelId,
    @required this.hotelName,
    @required this.nightPrice,
    @required this.place,
    @required this.photos,
    @required this.details,
    @required this.description,
    @required this.facilites,
    @required this.review,
  });
  factory hotel.fromJson(Map<String, dynamic> json) {
    return hotel(
        hotelId: json['hotelId'],
        hotelName: json['hotelName'],
        nightPrice: json['nightPrice'],
        place: json['place'],
        photos: json['photos'],
        details: null,
        description: json['description'],
        facilites: null,
        review: json['review']);
  }
}

class myProvider with ChangeNotifier {
  bool signedIn = FirebaseAuth.instance.currentUser != null;

  Future<void> signInWithEmail({
    required email,
    required password,
    context,
  }) async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((e) {
      print(e.message);
      if (e.message ==
          'We have blocked all requests from this device due to unusual activity. Try again later.') {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('too many requests'),
              );
            });
      } else if (e.message ==
          'There is no user record corresponding to this identifier. The user may have been deleted.') {
        FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        ;
      } else if (e.message ==
          ' The password is invalid or the user does not have a password') {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('wrong password'),
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content: Text('error has occurred'),
              );
            });
        print(e.message);
      }
    }).then((value) => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => homeScreen())));
  }

  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;
  Future signInWithGoogle() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    final cardential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(cardential).then((value) {
      return value.runtimeType;
    });
  }

  var hotels = FirebaseFirestore.instance.collection('hotels').snapshots();
  Future signInWithFacebook() async {
    final res = await FacebookLogin().logIn(permissions: [
      FacebookPermission.publicProfile,
      FacebookPermission.email
    ]);
    switch (res.status) {
      case FacebookLoginStatus.success:
        print('done');
        final FacebookAccessToken? fbToken = res.accessToken;
        final AuthCredential cardintial =
            FacebookAuthProvider.credential(fbToken!.token);
        final result =
            await FirebaseAuth.instance.signInWithCredential(cardintial);
        return 'done';

      case FacebookLoginStatus.cancel:
        return 'cancel';

      case FacebookLoginStatus.error:
        print('error');
        break;
      default:
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    await googleSignIn.signOut();
  }
}

class hotelsModel {
  List<hotel> _hotels = [];
  List<hotel> getHotels() {
    return _hotels;
  }

  Future<void> getHotelsCollection() async {
    CollectionReference hotels =
        FirebaseFirestore.instance.collection('hotels');
    DocumentSnapshot snapshot = await hotels.doc().get();
    var data = snapshot.data() as Map;
    var hotelId = data['hotelId'];
    var description = data['description'];
    var hotelName = data['hotelName'];
    var nightPrice = data['nightPrice'];
    var photos = data['photos'];
    var place = data['place'];
  }
}
