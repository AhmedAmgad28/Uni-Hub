import 'package:flutter/material.dart';
import '../helper/constants.dart';
import 'login_page.dart';
import 'register_page.dart';

class GuestProductDetailsPage extends StatelessWidget {
  const GuestProductDetailsPage({super.key});
  static String id = 'GuestProductDetailsPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        elevation: 10,
        centerTitle: true,
        backgroundColor: kBackgroundColor,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Uni-Hub',
              style: TextStyle(
                color: kPrimaryColor,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterPage.id);
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Text(
                  ' | ',
                  style: TextStyle(color: Colors.black),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, LoginPage.id);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
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
              const Padding(
                padding:
                    EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                child: Text(
                  'Product Name',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ),
              const Padding(
                padding:
                   EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                child: Text(
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
                      children:const  [
                        Icon(Icons.location_on_outlined),
                        Text(
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
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, LoginPage.id);
                      },
                      child: const Text("Login ",style: TextStyle(color: kPrimaryColor,fontSize: 16),)),
                    const Text("Or",style: TextStyle(fontSize: 16),),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, RegisterPage.id);
                      },
                      child: const Text(" Register ",style: TextStyle(color: kPrimaryColor,fontSize: 16),)),
                    const Text("for more information.",style: TextStyle(fontSize: 16),),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
