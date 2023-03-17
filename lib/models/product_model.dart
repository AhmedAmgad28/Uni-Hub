import 'dart:convert';

ProductModel welcomeFromJson(String str) => ProductModel.fromJson(json.decode(str));

String welcomeToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
    ProductModel({
        required this.status,
        required this.date,
        required this.results,
        required this.data,
    });

    String status;
    DateTime date;
    int results;
    Data data;

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        status: json["status"],
        date: DateTime.parse(json["date"]),
        results: json["results"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "date": date.toIso8601String(),
        "results": results,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.items,
    });

    List<Item> items;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class Item {
    Item({
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
        this.slug,
    });

    String id;
    String title;
    int price;
    String description;
    String coverImg;
    List<Img> imgs;
    String category;
    String address;
    bool closed;
    DateTime createAt;
    String? slug;

    factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["_id"],
        title: json["title"],
        price: json["price"],
        description: json["description"],
        coverImg: json["coverImg"],
        imgs: List<Img>.from(json["imgs"].map((x) => imgValues.map[x]!)),
        category: json["category"],
        address: json["address"],
        closed: json["closed"],
        createAt: DateTime.parse(json["createAt"]),
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "price": price,
        "description": description,
        "coverImg": coverImg,
        "imgs": List<dynamic>.from(imgs.map((x) => imgValues.reverse[x])),
        "category": category,
        "address": address,
        "closed": closed,
        "createAt": createAt.toIso8601String(),
        "slug": slug,
    };
}

enum Img { IMAGE_1_PNG, IMAGE_2_PNG, IMAGE_3_PNG }

final imgValues = EnumValues({
    "image-1.png": Img.IMAGE_1_PNG,
    "image-2.png": Img.IMAGE_2_PNG,
    "image-3.png": Img.IMAGE_3_PNG
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}