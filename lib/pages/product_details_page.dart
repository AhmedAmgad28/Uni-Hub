import 'package:flutter/material.dart';
import 'package:project_v2/widgets/custom_button.dart';
import '../helper/constants.dart';
import 'account_page.dart';
import 'login_page.dart';
import 'register_page.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});
  static String id = 'ProductDetailsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBackgroundColor,
      appBar: AppBar(
        elevation: 10,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AccountPage.id);
            },
            icon: const Icon(Icons.account_circle_rounded, color: Colors.black),
          )
        ],
        title: const Text(
          'My Ads',
          style: TextStyle(
            color: Colors.limeAccent,
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: ListView(
        children: [
          SizedBox(
            height: 6,
          ),
          Image.asset(
            'assets/images/book.png',
            height: 220,
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product Name',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: kPrimaryColor),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  'Price',
                  style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      color: kPrimaryColor),
                ),
                SizedBox(
                  height: 8,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined),
                        Text(
                          ' city',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: kPrimaryColor),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.date_range_outlined),
                        Text(
                          ' date',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: kPrimaryColor),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Product Details',
                        style: TextStyle(
                          fontSize: 22,
                          color: kPrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Category',
                            style:
                                TextStyle(fontSize: 20, color: kPrimaryColor),
                          ),
                          Text(
                            'Books',
                            style:
                                TextStyle(fontSize: 20, color: kPrimaryColor),
                          ),
                        ],
                      ),
                      Divider(
                        indent: 5,
                        endIndent: 5,
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Department',
                            style:
                                TextStyle(fontSize: 20, color: kPrimaryColor),
                          ),
                          Text(
                            'Computer Science',
                            style:
                                TextStyle(fontSize: 20, color: kPrimaryColor),
                          ),
                        ],
                      ),
                      Divider(
                        indent: 5,
                        endIndent: 5,
                        thickness: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Condition',
                            style:
                                TextStyle(fontSize: 20, color: kPrimaryColor),
                          ),
                          Text(
                            'Used',
                            style:
                                TextStyle(fontSize: 20, color: kPrimaryColor),
                          ),
                        ],
                      ),
                      Divider(
                        thickness: 2,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 12,
                ),
                Text(
                  'Description',
                  style: TextStyle(
                      fontSize: 24,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 6,
                ),
                Text(
                  'This is a description for this product.',
                  style: TextStyle(
                      fontSize: 20,
                      color: kPrimaryColor,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: CustomButton(buttonText: 'Chat'),
          ),
        ],
      ),
    );
  }
}
