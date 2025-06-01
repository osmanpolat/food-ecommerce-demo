import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/carts/product_card.dart';
import 'package:food_ecommerce/data/entity/product_ecommerce.dart';
import 'package:food_ecommerce/ui/cubits/favorite_cubit.dart';
import 'package:food_ecommerce/ui/cubits/main_cubit.dart';
import 'package:food_ecommerce/ui/screens/favorites_screen.dart';
import 'package:food_ecommerce/ui/screens/product_basket.dart';
import 'package:food_ecommerce/ui/screens/product_details.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MainCubit>().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) =>
                          const ProductBasketScreen(userName: "osman_polat"),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (query) {
                context.read<MainCubit>().search(query);
              },
              decoration: InputDecoration(
                hintText: "Search",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: BlocBuilder<MainCubit, List<ProductEcommerce>>(
              builder: (context, productList) {
                if (productList.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return BlocBuilder<FavoriteCubit, List<int>>(
                  builder: (context, favorites) {
                    return GridView.builder(
                      padding: const EdgeInsets.all(8),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 2 / 2.8,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                          ),
                      itemCount: productList.length,
                      itemBuilder: (context, index) {
                        final product = productList[index];
                        final isFav = favorites.contains(product.id);

                        return ProductCard(
                          product: product,
                          isFavorite: isFav,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => ProductDetails(product: product),
                              ),
                            );
                          },
                          onFavoriteToggle: () {
                            context.read<FavoriteCubit>().toggleFavorite(
                              product.id,
                            );
                          },
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
