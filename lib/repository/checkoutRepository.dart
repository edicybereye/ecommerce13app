import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:training_ecommerce/network/network.dart';
import 'package:http/http.dart' as http;

class CheckoutRepository {
  checkout(
    String idUsers,
    String unikID,
    VoidCallback method,
    BuildContext context,
  ) async {
    final response = await http.post(NetworkUrl.checkout(), body: {
      "idUsers": idUsers,
      "unikID": unikID,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      method();
      showDialog(
          context: context,
          builder: (context) {
            return Platform.isAndroid
                ? AlertDialog(
                    title: Text("Information"),
                    content: Text("$message"),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text("Ok"))
                    ],
                  )
                : CupertinoAlertDialog(
                    title: Text("Information"),
                    content: Text("$message"),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                          },
                          child: Text("Ok"))
                    ],
                  );
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return Platform.isAndroid
                ? AlertDialog(
                    title: Text("Warning"),
                    content: Text("$message"),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Ok"))
                    ],
                  )
                : CupertinoAlertDialog(
                    title: Text("Warning"),
                    content: Text("$message"),
                    actions: <Widget>[
                      FlatButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("Ok"))
                    ],
                  );
          });
    }
  }
}
