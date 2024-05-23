import 'package:flutter/material.dart';
import 'package:shop_hub_store/views/screens/widget/banner_widget.dart';
import 'package:shop_hub_store/views/screens/widget/category_text_widget.dart';
import 'package:shop_hub_store/views/screens/widget/home_products.dart';
import 'package:shop_hub_store/views/screens/widget/location_widget.dart';
import 'package:shop_hub_store/views/screens/widget/men_products.dart';
import 'package:shop_hub_store/views/screens/widget/reuseText.dart';
import 'package:shop_hub_store/views/screens/widget/women_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LocationWidget(),
          SizedBox(
            height: 10,
          ),
          BannerWidget(),
          SizedBox(
            height: 10,
          ),
          CategoryTextWidget(),
          SizedBox(
            height: 10,
          ),
          HomeProductWidget(),
          SizedBox(
            height: 10,
          ),
          ReuseTextWidget(title: 'Mens products'),
          SizedBox(
            height: 10,
          ),
          MenProductsWidget(),
          SizedBox(
            height: 10,
          ),
          ReuseTextWidget(title: 'Womens products'),
          WomenWidgetProducts(),
        ],
      ),
    );
  }
}
