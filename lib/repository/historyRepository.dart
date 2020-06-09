import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:training_ecommerce/model/historyModel.dart';
import 'package:http/http.dart' as http;
import 'package:training_ecommerce/network/network.dart';

class HistoryRepository {
  Future fetchdata(
    List<HistoryModel> list,
    String idUsers,
    VoidCallback reload,
    bool cekData,
  ) async {
    reload();
    list.clear();
    final response = await http.get(NetworkUrl.getHistory(idUsers));
    if (response.statusCode == 200) {
      reload();
      if (response.contentLength == 2) {
        cekData = false;
      } else {
        final data = jsonDecode(response.body);
        for (Map i in data) {
          list.add(HistoryModel.fromJson(i));
        }
        cekData = true;
      }
    } else {
      cekData = false;
      reload();
    }
  }

  
}
