import 'package:flutter/material.dart';
import 'package:project_v2/pages/guest_page.dart';
import 'package:project_v2/pages/login_page.dart';
import 'package:project_v2/pages/navigator_home_page.dart';
import 'package:project_v2/pages/register_page.dart';
import 'pages/chats_page.dart';
import 'pages/favourites_page.dart';
import 'pages/guest_product_details.dart';
import 'pages/my_ads_page.dart';
import 'pages/product_details_page.dart';
import 'pages/sell_your_product.dart';
import 'pages/account_page.dart';
import 'pages/home_page.dart';

void main() {
  runApp(const UniHub());
}

class UniHub extends StatelessWidget {
  const UniHub({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //routes = pages (This make it easier to navigate through them)
      routes: {
        GuestPage.id: (context) => GuestPage(), //first page display item and navigate to register and login pages
        RegisterPage.id: (context) => RegisterPage(), //after submiting your info, you will be navigated to NavigateHome page
        LoginPage.id: (context) => LoginPage(), //after submiting your info, you will be navigated to NavigateHome page
        NavigatorHome.id: (context) => NavigatorHome(), //have botton menu
        HomePage.id: (context) => HomePage(),
        FavouritesPage.id: (context) => FavouritesPage(),
        MyAdsPage.id: (context) => MyAdsPage(),
        ChatsPage.id: (context) => ChatsPage(),
        SellProductPage.id: (context) => SellProductPage(),
        AccountPage.id: (context) => AccountPage(),
        GuestProductDetailsPage.id: (context) => GuestProductDetailsPage(),
        ProductDetailsPage.id: (context) => ProductDetailsPage(),
        

      },
      //First page
      initialRoute: GuestPage.id,
    );
  }
}
