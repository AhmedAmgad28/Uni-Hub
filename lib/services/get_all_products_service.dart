// import '../helper/api.dart';
// import '../models/product_model.dart';

// class AllProductsService {
//   Future<List<itemsModel>> getAllProducts() async {
//     Map<String, dynamic> data =
//         await Api().get(url: 'https://utopiaapi.cyclic.app/api/v1/items');
//     print(data);
//     List<itemsModel> itemsList = [];
//     for (int i = 0; i < data.length; i++) {
//       itemsList.add(
//         itemsModel.fromJson(data['items'][i]),
//       );
//     }
//     return itemsList;
//   }
// }

// import 'dart:developer';

// import 'package:http/http.dart' as http;
// import 'package:project_v2/models/product_model.dart';

// Future<List<itemsModel>> getItems() async {
//   var url = Uri.parse('https://utopiaapi.cyclic.app/api/v1/items');
//   var response = await http.get(url);
//   log('Response body : ${response.body}');
// }

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/product_model.dart';

Future<itemsModel> getAllServices() async {
  final url = Uri.parse('https://utopiaapi.cyclic.app/api/v1/items');
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return itemsModel.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to fetch data');
  }
}