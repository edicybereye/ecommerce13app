class ProductModel {
  final String id;
  final String productName;
  final int sellingPrice;
  final String createdDate;
  final String cover;
  final String status;
  final String description;

  ProductModel(
      {this.id,
      this.productName,
      this.sellingPrice,
      this.createdDate,
      this.cover,
      this.status,
      this.description});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      productName: json['productName'],
      sellingPrice: json['sellingPrice'],
      createdDate: json['createdDate'],
      cover: json['cover'],
      status: json['status'],
      description: json['description'],
    );
  }
}
