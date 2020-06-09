import 'package:training_ecommerce/model/productModel.dart';

class CategoryProductModel {
  final String id;
  final String categoryName;
  final String status;
  final String createdDate;
  final List<ProductModel> product;

  CategoryProductModel(
      {this.id,
      this.categoryName,
      this.status,
      this.createdDate,
      this.product});

  factory CategoryProductModel.fromJson(Map<String, dynamic> json) {
    var list = json['product'] as List;
    List<ProductModel> productList =
        list.map((i) => ProductModel.fromJson(i)).toList();

    return CategoryProductModel(
      product: productList,
      id: json['id'],
      categoryName: json['categoryName'],
      status: json['status'],
      createdDate: json['createdDate'],
    );
  }
}
