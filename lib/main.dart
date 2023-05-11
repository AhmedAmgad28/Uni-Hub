import 'dart:io';

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

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  HttpOverrides.global = PostHttpOverrides();
  runApp(const UniHub());
}

class UniHub extends StatelessWidget {
  const UniHub({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uni-Hub',
      debugShowCheckedModeBanner: false,
      //routes = pages (This make it easier to navigate through them)
      //First page
      initialRoute: GuestPage.id,
      routes: {
        GuestPage.id: (context) =>
            const GuestPage(), //first page display item and navigate to register and login pages
        RegisterPage.id: (context) =>
            const RegisterPage(), //after submiting your info, you will be navigated to NavigateHome page
        LoginPage.id: (context) =>
            const LoginPage(), //after submiting your info, you will be navigated to NavigateHome page
        NavigatorHome.id: (context) => const NavigatorHome(), //have botton menu
        HomePage.id: (context) => const HomePage(),
        FavouritesPage.id: (context) => const FavouritesPage(),
        MyAdsPage.id: (context) => const MyAdsPage(),
        ChatsPage.id: (context) => const ChatsPage(),
        SellProductPage.id: (context) => const SellProductPage(),
        AccountPage.id: (context) => const AccountPage(),
        //GuestProductDetailsPage.id: (context) => GuestProductDetailsPage(itemId: ,),
        //ProductDetailsPage.id: (context) => const ProductDetailsPage(),
      },
    );
  }
}
