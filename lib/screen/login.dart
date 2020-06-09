import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_ecommerce/custom/prefProfile.dart';
import 'package:training_ecommerce/screen/registrasi.dart';

import '../network/network.dart';
import 'menu.dart';
import 'menu.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String namaLengkap, id;
  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      namaLengkap = pref.getString(Pref.namaLengkap);
      id = pref.getString(Pref.id);
      id != null ? sessionLogin() : sessiongLogout();
    });
  }

  sessionLogin() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Menu()));
  }

  sessiongLogout() {}

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  void handleGoogleSign() async {
    final GoogleSignInAccount googleUsers = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUsers.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    final FirebaseUser user =
        (await _auth.signInWithCredential(credential)).user;
    if (user != null) {
      print(user.providerData[1].displayName);
      cekEmail(user.providerData[1].email);
    }
  }

  String fcmToken;
  generatedToken() async {
    fcmToken = await _firebaseMessaging.getToken();
    print(fcmToken);
  }

  void cekEmail(String email) async {
    final response = await http.post(NetworkUrl.login(), body: {
      "email": email,
      "token": fcmToken,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String id = data['id'];
    String namaLengkap = data['namaLengkap'];
    String phone = data['phone'];
    String emailUsers = data['email'];
    String createdDate = data['createdDate'];
    String level = data['level'];
    if (value == 1) {
      setState(() {
        savePref(id, emailUsers, phone, namaLengkap, createdDate, level);
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Menu()));
    } else {
      print(message);
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => Registrasi(email, fcmToken)));
    }
  }

  savePref(
    String id,
    String email,
    String phone,
    String namaLengkap,
    String createdDate,
    String level,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.setString(Pref.id, id);
      pref.setString(Pref.email, email);
      pref.setString(Pref.namaLengkap, namaLengkap);
      pref.setString(Pref.createdDate, createdDate);
      pref.setString(Pref.level, level);
      pref.setString(Pref.phone, phone);
      pref.setBool(Pref.login, true);
    });
  }

  @override
  void initState() {
    super.initState();
    generatedToken();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: InkWell(
            onTap: handleGoogleSign,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Colors.red,
                      Colors.purple[200],
                    ],
                  )),
              child: Text(
                "Google Sign In",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
