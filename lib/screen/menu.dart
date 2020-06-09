import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_ecommerce/custom/dynamicLinkCustom.dart';
import 'package:training_ecommerce/custom/prefProfile.dart';
import 'package:training_ecommerce/screen/menu/account.dart';
import 'package:training_ecommerce/screen/menu/favorite.dart';
import 'package:training_ecommerce/screen/menu/history.dart';
import 'package:training_ecommerce/screen/menu/home.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String fcmToken;
  int selectIndex = 0;
  String namaLengkap;
  bool login = false;
  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      namaLengkap = pref.getString(Pref.namaLengkap);
      login = pref.getBool(Pref.login) ?? false;
    });
    print(namaLengkap);
    print(login);
  }

  final DynamicLinkServices _dynamicLinkServices = DynamicLinkServices();
  Future handleStartupClass() async {
    await _dynamicLinkServices.handleDynamicLink(context);
  }

  generetedToken() async {
    fcmToken = await _firebaseMessaging.getToken();
    print("FCM Token : $fcmToken");
  }

  @override
  void initState() {
    super.initState();
    generetedToken();
    handleStartupClass();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Offstage(
            offstage: selectIndex != 0,
            child: TickerMode(
              enabled: selectIndex == 0,
              child: Home(),
            ),
          ),
          Offstage(
            offstage: selectIndex != 1,
            child: TickerMode(
              enabled: selectIndex == 1,
              child: Favorite(),
            ),
          ),
          Offstage(
            offstage: selectIndex != 2,
            child: TickerMode(
              enabled: selectIndex == 2,
              child: History(),
            ),
          ),
          Offstage(
            offstage: selectIndex != 3,
            child: TickerMode(
              enabled: selectIndex == 3,
              child: Account(),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blue,
        child: Container(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    selectIndex = 0;
                    print(selectIndex);
                  });
                },
                child: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selectIndex = 1;
                    print(selectIndex);
                  });
                },
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selectIndex = 2;
                    print(selectIndex);
                  });
                },
                child: Icon(
                  Icons.history,
                  color: Colors.white,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    selectIndex = 3;
                    print(selectIndex);
                  });
                },
                child: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
