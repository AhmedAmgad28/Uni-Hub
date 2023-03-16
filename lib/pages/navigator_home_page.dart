import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';
import 'package:project_v2/pages/chats_page.dart';
import 'package:project_v2/pages/favourites_page.dart';
import 'package:project_v2/pages/home_page.dart';
import 'package:project_v2/pages/my_ads_page.dart';
import 'package:project_v2/pages/sell_your_product.dart';

class NavigatorHome extends StatefulWidget {
  const NavigatorHome({super.key});
  static String id = 'NavigatorHome';

  @override
  State<NavigatorHome> createState() => _HomePageState();
}

class _HomePageState extends State<NavigatorHome> {
  int myIndex = 0;
  List<Widget> widgetList = [
    const HomePage(),
    const MyAdsPage(),
    const SellProductPage(),
    const FavouritesPage(),
    const ChatsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: myIndex,children: widgetList,),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        elevation: 30,
        iconSize: 28,
        showUnselectedLabels: true,
        currentIndex: myIndex,
        fixedColor: kPrimaryColor,
        backgroundColor: kBackgroundColor,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ads_click_rounded),
            label: 'My Ads',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_rounded),
            label: 'Sell',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favourites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chats',
          ),
        ],
      ),
    );
  }
}
