import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteCubit extends Cubit<List<int>> {
  FavoriteCubit() : super([]);

  void toggleFavorite(int productId) {
    if (state.contains(productId)) {
      emit(state.where((id) => id != productId).toList());
    } else {
      emit([...state, productId]);
    }
  }

  bool isFavorite(int productId) => state.contains(productId);
}
