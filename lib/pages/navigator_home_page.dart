import 'package:flutter/material.dart';
import 'package:project_v2/pages/Account_page.dart';
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
    HomePage(),
    MyAdsPage(),
    SellProductPage(),
    FavouritesPage(),
    ChatsPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(children: widgetList,index: myIndex,),
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
        fixedColor: Colors.limeAccent,
        backgroundColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.grey,
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
