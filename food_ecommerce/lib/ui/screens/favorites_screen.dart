import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/ui/cubits/favorite_cubit.dart';
import 'package:food_ecommerce/ui/cubits/main_cubit.dart';
import 'package:food_ecommerce/ui/screens/product_details.dart';
import 'package:food_ecommerce/carts/product_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Favorites")),
      body: BlocBuilder<FavoriteCubit, List<int>>(
        builder: (context, favoriteIds) {
          final allProducts = context.read<MainCubit>().allProducts;
          final favoriteProducts =
              allProducts
                  .where((product) => favoriteIds.contains(product.id))
                  .toList();

          if (favoriteProducts.isEmpty) {
            return const Center(child: Text("No favorites yet."));
          }

          return GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 2 / 2.8,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: favoriteProducts.length,
            itemBuilder: (context, index) {
              final product = favoriteProducts[index];
              final isFav = favoriteIds.contains(product.id);

              return ProductCard(
                product: product,
                isFavorite: isFav,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetails(product: product),
                    ),
                  );
                },
                onFavoriteToggle: () {
                  context.read<FavoriteCubit>().toggleFavorite(product.id);
                },
              );
            },
          );
        },
      ),
    );
  }
}
