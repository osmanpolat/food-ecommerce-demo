import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/data/entity/product_ecommerce.dart';
import 'package:food_ecommerce/data/repo/product_ecommerce_dao_repository.dart';

class MainCubit extends Cubit<List<ProductEcommerce>> {
  MainCubit() : super(<ProductEcommerce>[]);
  var productDaoRepository = ProductEcommerceDaoRepository();
  List<ProductEcommerce> allProducts = [];

  Future<void> loadProducts() async {
    var list = await productDaoRepository.loadProducts();
    allProducts = list;
    emit(list);
  }

  Future<void> addProductToCart(ProductEcommerce product) async {
    await productDaoRepository.productAdd(
      name: product.name,
      image: product.image,
      category: product.category,
      price: product.price,
      brand: product.brand,
      quantity: 1,
      username: "osman_polat",
    );
  }

  void search(String query) {
    if (query.isEmpty) {
      emit(allProducts);
    } else {
      final filtered =
          allProducts
              .where(
                (product) =>
                    product.name.toLowerCase().contains(query.toLowerCase()),
              )
              .toList();
      emit(filtered);
    }
  }
}
