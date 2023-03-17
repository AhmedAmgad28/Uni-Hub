// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:project_v2/helper/constants.dart';

class ChatCards extends StatelessWidget {
  const ChatCards({
    super.key,
    //required this.product,
  });

  //ProductModel product;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.pushNamed(
        //   context,
        //   DisplayProductDetails.id,
        // );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 80,
            child: Card(
              elevation: 6,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    'UserName1',
                    style: TextStyle(fontSize: 24, color: kPrimaryColor),
                  ),
                  Text('hi, i want to negotiate about the...'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
