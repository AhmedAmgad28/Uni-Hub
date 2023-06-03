// import 'package:flutter/material.dart';

// class SortButton extends StatefulWidget {
//   final void Function(Map<String, dynamic>) onSort;

//   const SortButton({super.key, required this.onSort});

//   @override
//   // ignore: library_private_types_in_public_api
//   _SortButtonState createState() => _SortButtonState();
// }

// class _SortButtonState extends State<SortButton> {
//   String? _selectedOption;
//   final TextEditingController _minPriceController =
//       TextEditingController();
//   final TextEditingController _maxPriceController =
//       TextEditingController();

//   void _openSortModal(BuildContext context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext context) {
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               DropdownButton<String>(
//                 value: _selectedOption,
//                 hint: const Text('Sort by'),
//                 items: const [
//                   DropdownMenuItem(value: 'price', child: Text('Price')),
//                   DropdownMenuItem(value: 'title', child: Text('Title')),
//                   DropdownMenuItem(value: 'city', child: Text('City')),
//                 ],
//                 onChanged: (String? value) {
//                   setState(() {
//                     _selectedOption = value;
//                   });
//                 },
//               ),
//               TextFormField(
//                 controller: _minPriceController,
//                 decoration: const InputDecoration(labelText: 'Min price'),
//               ),
//               TextFormField(
//                 controller: _maxPriceController,
//                 decoration: const InputDecoration(labelText: 'Max price'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   double minPrice = double.tryParse(_minPriceController.text) ?? 0;
//                   double maxPrice = double.tryParse(_maxPriceController.text) ?? 99999999;
//                   Map<String, dynamic> params = {'option': _selectedOption, 'minPrice': minPrice, 'maxPrice': maxPrice};
//                   widget.onSort(params);
//                   Navigator.pop(context);
//                 },
//                 child: const Text('Sort'),
//               ),
//             ],
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: () {
//         _openSortModal(context);
//       },
//       child: Text('Sort'),
//     );
//   }
// }