// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:food_ecommerce/data/entity/product_ecommerce.dart';

class ProductEcommerceResponse {
  List<ProductEcommerce> urunler;
  int success;

  ProductEcommerceResponse({required this.urunler, required this.success});

  factory ProductEcommerceResponse.fromJson(Map<String, dynamic> json) {
    var success = json["success"] as int;
    var jsonArray = json["urunler"] as List;

    var urunler =
        jsonArray
            .map((jsonObject) => ProductEcommerce.fromJson(jsonObject))
            .toList();
    return ProductEcommerceResponse(urunler: urunler, success: success);
  }
}
