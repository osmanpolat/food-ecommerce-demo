import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/data/entity/product_ecommerce.dart';
import 'package:food_ecommerce/ui/cubits/favorite_cubit.dart';
import 'package:food_ecommerce/ui/cubits/product_basket_cubit.dart';
import 'package:food_ecommerce/ui/cubits/product_details_cubit.dart';

class ProductDetails extends StatelessWidget {
  final ProductEcommerce product;

  const ProductDetails({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductDetailsCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          title: const Text("Product Detail"),
          actions: [
            BlocBuilder<FavoriteCubit, List<int>>(
              builder: (context, favorites) {
                final isFav = favorites.contains(product.id);
                return IconButton(
                  icon: Icon(
                    isFav ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    context.read<FavoriteCubit>().toggleFavorite(product.id);
                  },
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<ProductDetailsCubit, int>(
          builder: (context, count) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.network(
                      "http://kasimadalan.pe.hu/urunler/resimler/${product.image}",
                      height: 160,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "₺${product.price}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed:
                              () =>
                                  context
                                      .read<ProductDetailsCubit>()
                                      .decrease(),
                        ),
                        Text(
                          '$count',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.add),
                          onPressed:
                              () =>
                                  context
                                      .read<ProductDetailsCubit>()
                                      .increase(),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      onPressed: () {
                        context.read<ProductBasketCubit>().addToBasket(
                          ProductEcommerce(
                            id: product.id,
                            name: product.name,
                            price: product.price,
                            quantity: count,
                            image: product.image,
                            category: product.category,
                            brand: product.brand,
                          ),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Basket Added")),
                        );
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Sepete Ekle",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
