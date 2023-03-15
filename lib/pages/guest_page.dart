import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';
import 'package:project_v2/pages/login_page.dart';
import 'package:project_v2/pages/register_page.dart';

import '../models/product_model.dart';
import '../services/get_all_product_service.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_guest_card.dart';
import '../widgets/custom_search.dart';

class GuestPage extends StatelessWidget {
  const GuestPage({super.key});
  static String id = 'GuestPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 10,
        centerTitle: true,
        backgroundColor: KBackgroundColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: Text(
                'Uni-Hub',
                style: TextStyle(
                  color: kPrimaryColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RegisterPage.id);
                  },
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(' | ',style: TextStyle(color: Colors.black),),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, LoginPage.id);
                  },
                  child: Text(
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
      body: ListView(children: [
        SearchTextField(hintText: 'Search for products'),
        SizedBox(height: 8,),
        CustomGuestCard(),
        SizedBox(height: 8,),
        CustomGuestCard(),
      ],),
    );
  }
}
