import 'package:flutter/material.dart';
import 'package:project_v2/widgets/custom_button.dart';
import '../helper/constants.dart';
import '../models/product_model.dart';
import '../services/single_product_details.dart';
import 'account_page.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({Key? key, required this.itemId})
      : super(key: key);
  static String id = 'ProductDetailsPage';
  final String itemId;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  late Future<Items> _futureItem;

  @override
  void initState() {
    super.initState();
    _futureItem = getItemById(widget.itemId);
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder<Items>(
    //   future: _futureItem,
    //   builder: (context, snapshot) {
    //     print(snapshot);
    //     if (snapshot.hasData) {
    //       final item = snapshot.data!;
    //       print(item.title);
    //       if (item.sId != null) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AccountPage.id);
            },
            icon: const Icon(Icons.account_circle_rounded,
                color: kBackgroundColor),
          )
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 8,
          ),
          Image.asset(
            'assets/images/book.png',
            height: 220,
          ),
          const SizedBox(
            height: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      // item.title ?? 'Title',
                      'Product Name',
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w700,
                          color: Colors.black),
                    ),
                    Icon(
                            Icons.favorite_border,
                            color: Colors.red,
                          ),
                  ],
                ),
              ),
              const Padding(
                padding:
                     EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Text(
                  // item.price.toString(),
                  'Price',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.location_on_outlined),
                        Text(
                          // item.city ?? 'city',
                          ' city',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        Icon(Icons.date_range_outlined),
                        Text(
                          // item.createAt.toString().substring(0, 10),
                          ' date',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black54),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Product Details',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Category',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                        Text(
                          'Books',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    const Divider(
                      indent: 5,
                      endIndent: 5,
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Department',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                        Text(
                          'Computer Science',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    const Divider(
                      indent: 5,
                      endIndent: 5,
                      thickness: 2,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Condition',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                        Text(
                          'Used',
                          style: TextStyle(fontSize: 18, color: Colors.black54),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 2,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 2, horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Description',
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 6,
                    ),
                    Text(
                      // item.description ?? 'Decription UnKnown',
                      'This is a description for this product.',
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              const Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Text(
                  'Published by: ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/book.png',
                      height: 80,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'User name',
                            style: TextStyle(
                                fontWeight: FontWeight.w700, fontSize: 18),
                          ),
                          const Text(
                            'Member since jan 2022',
                            style: TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 14),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'See Profile',
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  color: kPrimaryColor,
                                  fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                thickness: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 4),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("For Your Safety :",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500),),
                    const SizedBox(height: 4,),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_right),
                          Expanded(child: Text("Only meet in public / crowded places for example metro stations and malls.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_right),
                          Expanded(child: Text("Never go alone to meet a buyer / seller, always take someone with you.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_right),
                          Expanded(child: Text("Check and inspect the product properly before purchasing it..",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3),
                      child: Row(
                        children: const [
                          Icon(Icons.arrow_right),
                          Expanded(child: Text("Never pay anything in advance or transfer money before inspecting the product.",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,),)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomButton(buttonText: 'Chat'),
          ),
        ],
      ),
    );
      //         } else {
  //           return Scaffold(
  //             body: Center(
  //               child: Text('Null '),
  //             ),
  //           );
  //         }
  //       } else if (snapshot.hasError) {
  //         return Center(
  //           child: Text('${snapshot.error}'),
  //         );
  //       } else {
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     },
  //   );
  }
}
