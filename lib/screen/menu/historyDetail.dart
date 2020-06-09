import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:training_ecommerce/model/historyModel.dart';

class HistoryDetail extends StatefulWidget {
  final HistoryModel model;
  HistoryDetail(this.model);
  @override
  _HistoryDetailState createState() => _HistoryDetailState();
}

class _HistoryDetailState extends State<HistoryDetail> {
  final price = NumberFormat("#,##0", 'en_US');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: <Widget>[
          Text("${widget.model.noInvoice}"),
          Text("${widget.model.createdDate}"),
          Container(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Divider(
              color: Colors.grey,
            ),
          ),
          ListView.builder(
            itemCount: widget.model.detail.length,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              final a = widget.model.detail[i];
              var totalPrice = int.parse(a.qty) * int.parse(a.price);
              return Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Text("${a.productName}"),
                        Text("${a.qty}"),
                        Text("${price.format(int.parse(a.price))}"),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Divider(
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text("${price.format(totalPrice)}")
                ],
              );
            },
          )
        ],
      ),
    );
  }
}
