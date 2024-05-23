import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDeatilScreen extends StatefulWidget {
  final dynamic productData;

  const ProductDeatilScreen({super.key, required this.productData});

  @override
  State<ProductDeatilScreen> createState() => _ProductDeatilScreenState();
}

class _ProductDeatilScreenState extends State<ProductDeatilScreen> {
  int _imageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.productData['productName'],
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    child: Image.network(
                      widget.productData['productImages'][_imageIndex],
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.productData['productImages'].length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    _imageIndex = index;
                                  });
                                },
                                child: Container(
                                  height: 60,
                                  width: 60,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.blue.shade900,
                                    ),
                                  ),
                                  child: Image.network(
                                    widget.productData['productImages'][index],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ))
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productData['productName'],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 4,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    '\$' +
                        widget.productData['productPrice'].toStringAsFixed(2),
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue.shade900,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ExpansionTile(
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'product Descriptions',
                          style: TextStyle(
                            color: Colors.blue.shade900,
                          ),
                        ),
                        Text(
                          'View More',
                          style: TextStyle(
                            color: Colors.blue.shade900,
                          ),
                        ),
                      ],
                    ),
                    children: [
                      Text(
                        widget.productData['description'],
                        style: TextStyle(
                          fontSize: 16,
                          letterSpacing: 2,
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ExpansionTile(
                    title: Text(
                      'Sizes Avaliable',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    children: [
                      Container(
                        height: 50,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: widget.productData['sizeList'].length,
                            itemBuilder: (context, index) {
                              return OutlinedButton(
                                onPressed: () {},
                                child:
                                    Text(widget.productData['sizeList'][index]),
                              );
                            }),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                        widget.productData['storeImage'],
                      ),
                    ),
                    title: Text(
                      widget.productData['businessName'],
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      'See Profile',
                      style: TextStyle(
                        color: Colors.blue.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue.shade900,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(
                    CupertinoIcons.shopping_cart,
                    color: Colors.white,
                  ),
                  Text(
                    'Add to cart',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.chat_bubble,
              color: Colors.blue.shade900,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              CupertinoIcons.phone,
              color: Colors.blue.shade900,
            ),
          )
        ],
      )),
    );
  }
}
