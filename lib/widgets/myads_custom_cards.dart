import 'package:flutter/material.dart';

class MyAdsCustomCard extends StatelessWidget {
  const MyAdsCustomCard({
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
            padding: const EdgeInsets.only(top: 10,left: 8,right: 8),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 0,
                    offset: const Offset(10, 10)),
              ],
            ),
            child: Card(
              elevation: 16,
              child: Padding(
                padding:
                    const EdgeInsets.only(right: 14, bottom: 12, top: 12, left: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Product Name',
                            style: TextStyle(
                                color: Colors.grey, fontSize: 20),
                          ),
                          Icon(
                            Icons.delete,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 70),
                      child: Text(
                            'Price',
                            //r'$' '${product.price.toString()}',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 22),
                          ),
                    ),
                    const SizedBox(height: 8,),
                    Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            'Date',
                            style: TextStyle(
                                color: Colors.blueGrey, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 24,
            top: 12,
            child: Image.asset(
              'assets/images/book.png',
              height: 110,
              width: 90,
            ),
          ),
        ],
      ),
    );
  }
}
