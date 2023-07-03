import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:project_v2/pages/guest/guest_page.dart';
import 'package:project_v2/pages/guest/login_page.dart';
import 'package:project_v2/pages/home/navigator_home_page.dart';
import 'package:project_v2/pages/guest/register_page.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'pages/category/accessories_page.dart';
import 'pages/category/books_page.dart';
import 'pages/chat/chats_page.dart';
import 'pages/category/elctronics_page.dart';
import 'pages/home/favourites_page.dart';
import 'pages/home/my_ads_page.dart';
import 'pages/category/other_page.dart';
import 'pages/home/sell_your_product.dart';
import 'pages/account/account_page.dart';
import 'pages/home/home_page.dart';
import 'pages/category/services_page.dart';
import 'pages/category/tools_page.dart';
import 'pages/home/sell_your_product2.dart';
import 'pages/home/view_profile_page.dart';

class PostHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = PostHttpOverrides();
  await GeolocatorPlatform.instance.isLocationServiceEnabled();
  runApp(const UniHub());
}

class UniHub extends StatelessWidget {
  const UniHub({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
                S.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
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
            LoginPage(), //after submiting your info, you will be navigated to NavigateHome page
        NavigatorHome.id: (context) =>  const NavigatorHome( userId: ''), //have botton menu
        HomePage.id: (context) => const HomePage(),
        BooksPage.id: (context) => const BooksPage(),
        ToolsPage.id: (context) => const ToolsPage(),
        ElectronicsPage.id: (context) => const ElectronicsPage(),
        ServicesPage.id: (context) => const ServicesPage(),
        AccessoriesPage.id: (context) => const AccessoriesPage(),
        OthersPage.id: (context) => const OthersPage(),
        FavouritesPage.id: (context) => const FavouritesPage(),
        MyAdsPage.id: (context) => const MyAdsPage(),
        ChatsPage.id: (context) => const ChatsPage(userId: ''),
        SellProductPage.id: (context) => const SellProductPage(),
        SellProductPage2.id: (context) => const SellProductPage2(itemId: '',),
        AccountPage.id: (context) => const AccountPage(),
        ViewProfilePage.id: (context) => const ViewProfilePage(joinedAt: '', userId: '', userName: '', userPhoto: '',),
        //ProductDetailsPage.id: (context) => const ProductDetailsPage(),
      },
    );
  }
}
