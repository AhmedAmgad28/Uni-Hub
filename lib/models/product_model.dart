class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String coverImg;
  final List<String> imgs;
  final String category;
  final String address;
  final bool closed;
  final String createAt;
  final String slug;

  ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.coverImg,
    required this.imgs,
    required this.category,
    required this.address,
    required this.closed,
    required this.createAt,
    required this.slug,
  });

  factory ProductModel.fromJson(jsonData) {
    return ProductModel(
      id: jsonData['id'],
      title: jsonData['title'],
      price: jsonData['price'],
      description: jsonData['description'],
      coverImg: jsonData['coverImg'],
      imgs: jsonData['imgs'], //might be a problem
      category: jsonData['category'],
      address: jsonData['address'],
      closed: jsonData['closed'],
      createAt: jsonData['createAt'],
      slug: jsonData['slug'],
    );
  }
}

