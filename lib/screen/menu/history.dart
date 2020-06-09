import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:training_ecommerce/custom/prefProfile.dart';
import 'package:training_ecommerce/model/historyModel.dart';
import 'package:training_ecommerce/repository/historyRepository.dart';

import 'historyDetail.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool login = false;
  String idUsers;
  HistoryRepository historyRepository = HistoryRepository();
  List<HistoryModel> list = [];
  var loading = false;
  var cekData = false;
  getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      idUsers = pref.getString(Pref.id);
      login = pref.getBool(Pref.login) ?? false;
    });
    await historyRepository.fetchdata(list, idUsers, () {
      setState(() {
        loading = true;
      });
    }, cekData);
    print("List 0 : ${list[0].noInvoice}");
    print("Login : $login");
  }

  Future<void> refresh() async {
    getPref();
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
      ),
      body: Container(
          child: RefreshIndicator(
        onRefresh: refresh,
        child: ListView(
          children: [
            ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: list.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemBuilder: (context, i) {
                final a = list[i];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HistoryDetail(a)));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text("${a.noInvoice}"),
                      Text("${a.createdDate}"),
                      Text(a.status == "0" ? "PENDING" : "SUCCESS"),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 4),
                        child: Divider(
                          color: Colors.grey,
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}
