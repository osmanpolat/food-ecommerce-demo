import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_ecommerce/data/entity/product_ecommerce.dart';
import 'package:food_ecommerce/ui/cubits/product_basket_cubit.dart';

class ProductBasketScreen extends StatelessWidget {
  final String userName;
  const ProductBasketScreen({super.key, required this.userName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("My Cart")),
      body: BlocBuilder<ProductBasketCubit, List<ProductEcommerce>>(
        builder: (context, basketItems) {
          if (basketItems.isEmpty) {
            return const Center(child: Text("Empty Card."));
          }

          double total = context.read<ProductBasketCubit>().calculateTotal();

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: basketItems.length,
                  itemBuilder: (context, index) {
                    final product = basketItems[index];
                    return ListTile(
                      leading: Image.network(
                        "http://kasimadalan.pe.hu/urunler/resimler/${product.image}",
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product.name),
                      subtitle: Text("₺${product.price} x ${product.quantity}"),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          context.read<ProductBasketCubit>().removeFromBasket(
                            product.id.toString(),
                            userName,
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Toplam: ₺$total",
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  // ödeme işlemi vs.
                },
                child: const Text("Complete Order"),
              ),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }
}
