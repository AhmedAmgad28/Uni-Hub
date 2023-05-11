// ignore_for_file: prefer_collection_literals, camel_case_types

class itemsModel {
  String? status;
  String? date;
  int? results;
  Data? data;

  itemsModel({this.status, this.date, this.results, this.data});

  itemsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    date = json['date'];
    results = json['results'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['date'] = date;
    data['results'] = results;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<Items>? items;

  Data({this.items});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  Location? location;
  String? sId;
  String? title;
  int? price;
  String? description;
  String? coverImg;
  List<String>? imgs;
  String? category;
  String? city;
  bool? closed;
  User? user;
  String? createAt;

  Items(
      {this.location,
      this.sId,
      this.title,
      this.price,
      this.description,
      this.coverImg,
      this.imgs,
      this.category,
      this.city,
      this.closed,
      this.user,
      this.createAt});

  Items.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? Location.fromJson(json['location'])
        : null;
    sId = json['_id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    coverImg = json['coverImg'];
    imgs = json['imgs'] == null ? [] : json['imgs'].cast<String>();
    category = json['category'];
    city = json['city'];
    closed = json['closed'];
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    createAt = json['createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (location != null) {
      data['location'] = location!.toJson();
    }
    data['_id'] = sId;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['coverImg'] = coverImg;
    data['imgs'] = imgs;
    data['category'] = category;
    data['city'] = city;
    data['closed'] = closed;
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['createAt'] = createAt;
    return data;
  }
}

class Location {
  List<double>? coordinates;
  String? address;
  String? description;
  String? geoType;

  Location({this.coordinates, this.address, this.description, this.geoType});

  Location.fromJson(Map<String, dynamic> json) {
    coordinates = json['coordinates'].cast<double>();
    address = json['address'];
    description = json['description'];
    geoType = json['geoType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['coordinates'] = coordinates;
    data['address'] = address;
    data['description'] = description;
    data['geoType'] = geoType;
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? email;
  String? phone;
  String? photo;
  String? joinAt;

  User({this.sId, this.name, this.email, this.phone, this.photo, this.joinAt});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];
    joinAt = json['joinAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['photo'] = photo;
    data['joinAt'] = joinAt;
    return data;
  }
}