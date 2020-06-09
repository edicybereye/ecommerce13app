class HistoryModel {
  final String id;
  final String noInvoice;
  final String createdDate;
  final String status;
  final List<HistoryDetailModel> detail;

  HistoryModel({
    this.id,
    this.noInvoice,
    this.createdDate,
    this.status,
    this.detail,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    var list = json['detail'] as List;
    List<HistoryDetailModel> dataList =
        list.map((e) => HistoryDetailModel.fromJson(e)).toList();
    return HistoryModel(
      id: json['id'],
      noInvoice: json['noInvoice'],
      createdDate: json['createdDate'],
      status: json['status'],
      detail: dataList,
    );
  }
}

class HistoryDetailModel {
  final String id;
  final String idProduct;
  final String qty;
  final String price;
  final String discount;
  final String productName;
  final String cover;

  HistoryDetailModel(
      {this.id,
      this.idProduct,
      this.qty,
      this.price,
      this.discount,
      this.productName,
      this.cover});

  factory HistoryDetailModel.fromJson(Map<String, dynamic> json) {
    return HistoryDetailModel(
      id: json['id'],
      idProduct: json['idProduct'],
      qty: json['qty'],
      price: json['price'],
      discount: json['discount'],
      productName: json['productName'],
      cover: json['cover'],
    );
  }
}
