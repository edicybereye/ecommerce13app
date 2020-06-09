import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_ecommerce/custom/prefProfile.dart';

import '../network/network.dart';
import 'menu.dart';

class Registrasi extends StatefulWidget {
  final String email;
  final String token;
  Registrasi(this.email, this.token);
  @override
  _RegistrasiState createState() => _RegistrasiState();
}

class _RegistrasiState extends State<Registrasi> {
  TextEditingController namaLengkap = TextEditingController();
  TextEditingController phone = TextEditingController();

  final _key = GlobalKey<FormState>();
  cek() {
    if (_key.currentState.validate()) {
      simpan();
    }
  }

  simpan() async {
    final response = await http.post(NetworkUrl.daftar(), body: {
      "email": widget.email,
      "token": widget.token,
      "namaLengkap": namaLengkap.text,
      "phone": phone.text,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    String id = data['id'];
    String nama = data['namaLengkap'];
    String hp = data['phone'];
    String emailUsers = data['email'];
    String createdDate = data['createdDate'];
    String level = data['level'];
    if (value == 1) {
      setState(() {
        savePref(id, emailUsers, hp, nama, createdDate, level);
      });
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Menu()));
    } else {
      print(message);
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
      pref.setBool(Pref.login, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _key,
          child: ListView(
            padding: EdgeInsets.all(16),
            children: <Widget>[
              TextFormField(
                controller: namaLengkap,
                validator: (e) {
                  if (e.isEmpty)
                    return "Silahkan input nama lengkap anda";
                  else
                    null;
                },
                decoration: InputDecoration(hintText: "Nama Lengkap"),
              ),
              TextFormField(
                keyboardType: TextInputType.phone,
                controller: phone,
                validator: (e) {
                  if (e.isEmpty)
                    return "Silahkan input nomor ponsel anda";
                  else
                    null;
                },
                decoration: InputDecoration(hintText: "Nomor Ponsel"),
              ),
              SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: cek,
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
                    "Submit",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
