import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor_app_only/vendor/provider/product_provider.dart';
import 'package:vendor_app_only/vendor/views/screens/tab_bar_screen/attributes_screen.dart';
import 'package:vendor_app_only/vendor/views/screens/tab_bar_screen/general_screen.dart';
import 'package:vendor_app_only/vendor/views/screens/tab_bar_screen/images_screen.dart';
import 'package:vendor_app_only/vendor/views/screens/tab_bar_screen/shipping_screen.dart';

class UploadScreen extends StatelessWidget {
  const UploadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductProvider _productProvider =
        Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(tabs: [
            Tab(
              child: Text('General'),
            ),
            Tab(
              child: Text('Shipping'),
            ),
            Tab(
              child: Text('Attributes'),
            ),
            Tab(
              child: Text('Images'),
            ),
          ]),
        ),
        body: TabBarView(children: [
          GeneralScreen(),
          ShippingScreen(),
          AttributesScreen(),
          ImagesScreen(),
        ]),
        bottomSheet: Padding(
          padding: const EdgeInsets.all(15.0),
          child: InkWell(
            onTap: () {
              print(_productProvider.productData['productName']);
              print(_productProvider.productData['category']);
              print(_productProvider.productData['chargeShipping']);
              print(_productProvider.productData['sizeList']);
            },
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: Colors.pink,
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
              child: Center(
                child: Text(
                  'Upload Product',
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 5,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
