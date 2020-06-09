import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_ecommerce/custom/prefProfile.dart';
import 'package:training_ecommerce/screen/login.dart';

import '../menu.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  bool login = false;
  String namaLengkap, email, phone;
  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      login = pref.getBool(Pref.login) ?? false;
      namaLengkap = pref.getString(Pref.namaLengkap) ?? false;
      email = pref.getString(Pref.email) ?? false;
      phone = pref.getString(Pref.phone) ?? false;
    });
  }

  FirebaseAuth _auth = FirebaseAuth.instance;
  GoogleSignIn googleSignIn = GoogleSignIn();
  signOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove(Pref.namaLengkap);
    pref.remove(Pref.id);
    pref.remove(Pref.login);
    pref.remove(Pref.level);
    pref.remove(Pref.createdDate);
    pref.remove(Pref.kode);
    _auth.signOut();
    googleSignIn.signOut();
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Menu()));
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        actions: <Widget>[
          login
              ? IconButton(
                  icon: Icon(Icons.lock_open),
                  onPressed: signOut,
                )
              : SizedBox()
        ],
      ),
      body: login
          ? Container(
              child: ListView(
              children: <Widget>[
                Text("$namaLengkap"),
                Text("$email"),
                Text("$phone"),
              ],
            ))
          : Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Silahkan Login dibawah ini",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
                    },
                    child: Text(
                      "Sign In",
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
