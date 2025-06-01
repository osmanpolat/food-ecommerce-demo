import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:food_ecommerce/data/entity/product_ecommerce.dart';
import 'package:food_ecommerce/data/entity/product_ecommerce_response.dart';

class ProductEcommerceDaoRepository {
  //Dao: Database Access Object
  List<ProductEcommerce> parseProductEcommerce(String response) {
    return ProductEcommerceResponse.fromJson(json.decode(response)).urunler;
  }

  Future<List<ProductEcommerce>> loadProducts() async {
    var url = "http://kasimadalan.pe.hu/urunler/tumUrunleriGetir.php";
    var response = await Dio().get(url);
    return parseProductEcommerce(response.data.toString());
  }

  Future<void> productAdd({
    required String name,
    required String image,
    required String category,
    required int price,
    required String brand,
    required int quantity,
    required String username,
  }) async {
    var url = "http://kasimadalan.pe.hu/urunler/sepeteUrunEkle.php";
    var data = {
      "ad": name,
      "resim": image,
      "kategori": category,
      "fiyat": price.toString(),
      "marka": brand,
      "siparisAdeti": quantity.toString(),
      "kullaniciAdi": username,
    };
    await Dio().post(url, data: FormData.fromMap(data));
  }
Future<List<ProductEcommerce>> getBasketItems(String userName) async {
  var url = "http://kasimadalan.pe.hu/urunler/sepettekiUrunleriGetir.php";
  var data = {"username": userName};
  var response = await Dio().post(url, data: FormData.fromMap(data));
  return parseProductEcommerce(response.data.toString());
}

Future<void> removeFromBasket(String productId, String userName) async {
  var url = "http://kasimadalan.pe.hu/urunler/sepettenUrunSil.php";
  var data = {"id": productId, "username": userName};
  await Dio().post(url, data: FormData.fromMap(data));
}


}
