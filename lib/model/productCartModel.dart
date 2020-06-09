class ProductCartModel {
  final String id;
  final String productName;
  final int sellingPrice;
  final String createdDate;
  final String cover;
  final String status;
  final String description;
  final String qty;

  ProductCartModel({
    this.id,
    this.productName,
    this.sellingPrice,
    this.createdDate,
    this.cover,
    this.status,
    this.description,
    this.qty,
  });

  factory ProductCartModel.fromJson(Map<String, dynamic> json) {
    return ProductCartModel(
      id: json['id'],
      productName: json['productName'],
      sellingPrice: json['sellingPrice'],
      createdDate: json['createdDate'],
      cover: json['cover'],
      status: json['status'],
      description: json['description'],
      qty: json['qty'],
    );
  }
}
