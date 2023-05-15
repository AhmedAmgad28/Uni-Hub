// ignore_for_file: prefer_collection_literals

class Users {
  String? status;
  String? date;
  String? token;
  Data? data;

  Users({this.status, this.date, this.token, this.data});

  Users.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    date = json['date'];
    token = json['token'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['date'] = date;
    data['token'] = token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  Account? account;

  Data({this.account});

  Data.fromJson(Map<String, dynamic> json) {
    account =
        json['account'] != null ? Account.fromJson(json['account']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (account != null) {
      data['account'] = account!.toJson();
    }
    return data;
  }
}

class Account {
  String? sId;
  String? name;
  String? email;
  String? phone;
  String? photo;
  String? passwordChangeAt;
  List<Items>? items;

  Account(
      {this.sId,
      this.name,
      this.email,
      this.phone,
      this.photo,
      this.passwordChangeAt,
      this.items});

  Account.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    photo = json['photo'];
    passwordChangeAt = json['passwordChangeAt'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['photo'] = photo;
    data['passwordChangeAt'] = passwordChangeAt;
    if (items != null) {
      data['items'] = items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? sId;
  String? title;
  int? price;
  String? description;
  String? category;
  String? city;

  Items(
      {this.sId,
      this.title,
      this.price,
      this.description,
      this.category,
      this.city});

  Items.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    category = json['category'];
    city = json['city'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['_id'] = sId;
    data['title'] = title;
    data['price'] = price;
    data['description'] = description;
    data['category'] = category;
    data['city'] = city;
    return data;
  }
}