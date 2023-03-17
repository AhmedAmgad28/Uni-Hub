import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';
import 'package:project_v2/pages/Account_page.dart';
import '../widgets/favourie_card.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});
  static String id = 'Favourites';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 10,
        backgroundColor: kPrimaryColor,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AccountPage.id);
            },
            icon: const Icon(Icons.account_circle_rounded, color: kBackgroundColor),
          )
        ],
        title: const Padding(
          padding:  EdgeInsets.all(8.0),
          child: Text(
            'Favourites',
            style: TextStyle(
              color: kBackgroundColor,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
                child: ListView.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return const FavouriteCard();
                  },
                ),
              ),
        ],
      ),
    );    
  }
}
