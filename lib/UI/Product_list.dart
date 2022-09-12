import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shoppingcart/Controller/ProductController.dart';
import 'package:shoppingcart/Model/cart_model.dart';
import 'package:shoppingcart/Provider/CartProvider.dart';
import 'package:shoppingcart/DB/DBHelper.dart';
import 'package:shoppingcart/UI/CartScreen.dart';

class ProductList extends StatefulWidget {
  const ProductList({Key? key}) : super(key: key);

  @override
  State<ProductList> createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  DBHelper dbHelper = DBHelper();
  final ProductController _getXController = Get.put(ProductController());

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  //List<bool> clicked = List.generate(10, (index) => false, growable: true);
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    void saveData(int index) {
      dbHelper
          .insert(
        Cart(
          id: index,
          productId: index.toString(),
          productName: _getXController.productList[index].title,
          initialPrice: _getXController.productList[index].price,
          productPrice: _getXController.productList[index].price,
          quantity: ValueNotifier(1),
          unitTag: "",
          image: _getXController.productList[index].featuredImage,
        ),
      )
          .then((value) {
        cart.addTotalPrice(_getXController.productList[index].price.toDouble());
        cart.addCounter();
        print('Product Added to cart');
      }).onError((error, stackTrace) {
        print(error.toString());
      });
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Product List'),
          actions: [
            Badge(
              badgeContent: Consumer<CartProvider>(
                builder: (context, value, child) {
                  return Text(
                    value.getCounter().toString(),
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  );
                },
              ),
              position: const BadgePosition(start: 30, bottom: 30),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CartScreen()));
                },
                icon: const Icon(Icons.shopping_cart),
              ),
            ),
            const SizedBox(
              width: 20.0,
            ),
          ],
        ),
        body: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20),
              topLeft: Radius.circular(20),
            ),
            border: Border.all(
              width: 1,
              color: Colors.white,
              style: BorderStyle.solid,
            ),
          ),
          padding: const EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: _getXController.productList.length == 0
              ? Container(
                  child: Text("No Data Available"),
                )
              : GridView.builder(
                  // gridDelegate:
                  // SliverGridDelegateWithFixedCrossAxisCount(
                  //   crossAxisCount: 2,
                  //   childAspectRatio: 1.0,
                  //   crossAxisSpacing: 5.0,
                  //   mainAxisSpacing: 5,
                  //   mainAxisExtent: 120,
                  //
                  // ),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  physics: ScrollPhysics(),
                  itemCount: _getXController.productList.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      color: Colors.black12,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // Image(
                                //   height: 80,
                                //   width: 80,
                                //   image: AssetImage(_getXController.productList[index].image.toString()),
                                // ),
                                Image.network(
                                  _getXController
                                      .productList[index].featuredImage
                                      .toString(),
                                  height: 80,
                                  width: 80,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 21.0,
                            ),
                            Card(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10.0, left: 1.5),
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          text: TextSpan(
                                              text:
                                                  '${_getXController.productList[index].title.toString()}\n',
                                              style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      saveData(index);
                                    },
                                    icon: const Icon(Icons.shopping_cart),
                                  ),

                                  // RichText(
                                  //   maxLines: 1,
                                  //   text: TextSpan(
                                  //       text: 'Unit: ',
                                  //       style: TextStyle(
                                  //           color: Colors.blueGrey.shade800,
                                  //           fontSize: 16.0),
                                  //       children: [
                                  //         TextSpan(
                                  //             text:
                                  //             '${products[index].unit.toString()}\n',
                                  //             style: const TextStyle(
                                  //                 fontWeight: FontWeight.bold)),
                                  //       ]),
                                  // ),
                                  // RichText(
                                  //   maxLines: 1,
                                  //   text: TextSpan(
                                  //       text: 'Price: ' r"$",
                                  //       style: TextStyle(
                                  //           color: Colors.blueGrey.shade800,
                                  //           fontSize: 16.0),
                                  //       children: [
                                  //         TextSpan(
                                  //             text:
                                  //             '${products[index].price.toString()}\n',
                                  //             style: const TextStyle(
                                  //                 fontWeight: FontWeight.bold)),
                                  //       ]),
                                  // ),
                                ],
                              ),
                            ),

                            // ElevatedButton(
                            //     style: ElevatedButton.styleFrom(
                            //         primary: Colors.blueGrey.shade900),
                            //     onPressed: () {
                            //
                            //     },
                            //     child: const Text('Add to Cart')),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        )
        // ListView.builder(
        //     padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
        //     shrinkWrap: true,
        //     itemCount: products.length,
        //     itemBuilder: (context, index) {
        //       return
        //         Card(
        //
        //         elevation: 5.0,
        //         child: Padding(
        //           padding: const EdgeInsets.all(4.0),
        //           child:
        //
        //           Column(
        //             mainAxisAlignment: MainAxisAlignment.start,
        //           crossAxisAlignment: CrossAxisAlignment.start,
        //             children: [
        //               Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 crossAxisAlignment: CrossAxisAlignment.center,
        //                 children: [
        //                   Image(
        //                     height: 80,
        //                     width: 80,
        //                     image: AssetImage(products[index].image.toString()),
        //                   ),
        //                 ],
        //               ),
        //               SizedBox(
        //                 width: 130,
        //                 child: Column(
        //                   crossAxisAlignment: CrossAxisAlignment.start,
        //                   children: [
        //                     const SizedBox(
        //                       height: 5.0,
        //                     ),
        //                     RichText(
        //                       overflow: TextOverflow.ellipsis,
        //                       maxLines: 1,
        //                       text: TextSpan(
        //                           text: 'Name: ',
        //                           style: TextStyle(
        //                               color: Colors.blueGrey.shade800,
        //                               fontSize: 16.0),
        //                           children: [
        //                             TextSpan(
        //                                 text:
        //                                 '${products[index].name.toString()}\n',
        //                                 style: const TextStyle(
        //                                     fontWeight: FontWeight.bold)),
        //                           ]),
        //                     ),
        //                     RichText(
        //                       maxLines: 1,
        //                       text: TextSpan(
        //                           text: 'Unit: ',
        //                           style: TextStyle(
        //                               color: Colors.blueGrey.shade800,
        //                               fontSize: 16.0),
        //                           children: [
        //                             TextSpan(
        //                                 text:
        //                                 '${products[index].unit.toString()}\n',
        //                                 style: const TextStyle(
        //                                     fontWeight: FontWeight.bold)),
        //                           ]),
        //                     ),
        //                     RichText(
        //                       maxLines: 1,
        //                       text: TextSpan(
        //                           text: 'Price: ' r"$",
        //                           style: TextStyle(
        //                               color: Colors.blueGrey.shade800,
        //                               fontSize: 16.0),
        //                           children: [
        //                             TextSpan(
        //                                 text:
        //                                 '${products[index].price.toString()}\n',
        //                                 style: const TextStyle(
        //                                     fontWeight: FontWeight.bold)),
        //                           ]),
        //                     ),
        //                   ],
        //                 ),
        //               ),
        //               ElevatedButton(
        //                   style: ElevatedButton.styleFrom(
        //                       primary: Colors.blueGrey.shade900),
        //                   onPressed: () {
        //                     saveData(index);
        //                   },
        //                   child: const Text('Add to Cart')),
        //             ],
        //           ),
        //         ),
        //       );
        //
        //
        //
        //     }),
        );
  }
}
