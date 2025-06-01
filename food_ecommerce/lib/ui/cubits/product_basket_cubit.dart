import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/data/entity/product_ecommerce.dart';

class ProductBasketCubit extends Cubit<List<ProductEcommerce>> {
  ProductBasketCubit() : super([]);

  void loadBasket(List<ProductEcommerce> items) {
    emit(items);
  }

  void addToBasket(ProductEcommerce newProduct) {
    final existingIndex = state.indexWhere((item) => item.id == newProduct.id);

    if (existingIndex != -1) {
      final updatedItem = state[existingIndex];
      updatedItem.quantity += newProduct.quantity;

      final updatedList = List<ProductEcommerce>.from(state);
      updatedList[existingIndex] = updatedItem;
      emit(updatedList);
    } else {
      emit([...state, newProduct]);
    }
  }

  void removeFromBasket(String id, String userName) {
    final updatedList =
        state.where((item) => item.id.toString() != id).toList();
    emit(updatedList);
  }

  double calculateTotal() {
    return state.fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }
}
