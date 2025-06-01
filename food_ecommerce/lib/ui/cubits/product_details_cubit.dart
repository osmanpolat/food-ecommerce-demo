import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/data/entity/product_ecommerce.dart';

import 'package:food_ecommerce/data/repo/product_ecommerce_dao_repository.dart';

class ProductDetailsCubit extends Cubit<int> {
  ProductDetailsCubit() : super(1);
  final productDaoRepository = ProductEcommerceDaoRepository();

  void increase() => emit(state + 1);

  void decrease() {
    if (state > 1) emit(state - 1);
  }

  Future<void> addToCart({
    required ProductEcommerce product,
    required int quantity,
    required String userName,
  }) async {
    await productDaoRepository.productAdd(
      name: product.name,
      image: product.image,
      category: product.category,
      price: product.price,
      brand: product.brand,
      quantity: quantity,
      username: userName,
    );
  }
}
