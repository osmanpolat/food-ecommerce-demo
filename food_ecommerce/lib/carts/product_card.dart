import 'package:flutter/material.dart';
import 'package:food_ecommerce/data/entity/product_ecommerce.dart';

class ProductCard extends StatelessWidget {
  final ProductEcommerce product;
  final VoidCallback onTap;
  final VoidCallback onFavoriteToggle;
  final bool isFavorite;

  const ProductCard({
    required this.product,
    required this.onTap,
    required this.onFavoriteToggle,
    required this.isFavorite,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: Image.network(
                      "http://kasimadalan.pe.hu/urunler/resimler/${product.image}",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: IconButton(
                      icon: Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: Colors.redAccent,
                      ),
                      onPressed: onFavoriteToggle,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "₺${product.price}",
                    style: const TextStyle(color: Colors.deepPurple),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
