class ProductEcommerce {
  int id;
  String name;
  String image;
  String category;
  double price;
  String brand;
  int quantity;

  ProductEcommerce({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.price,
    required this.brand,
    this.quantity = 1,
  });

  factory ProductEcommerce.fromJson(Map<String, dynamic> json) {
    return ProductEcommerce(
      id: int.parse(json["id"].toString()),
      name: json["ad"],
      image: json["resim"],
      category: json["kategori"],
      price: double.parse(json["fiyat"].toString()),
      brand: json["marka"],
      quantity:
          json["siparisAdeti"] != null ? int.parse(json["siparisAdeti"]) : 1,
    );
  }
}
