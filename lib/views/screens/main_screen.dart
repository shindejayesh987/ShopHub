import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_hub_store/vendor/views/screens/logout_screen.dart';
import 'package:shop_hub_store/views/screens/account_screen.dart';
import 'package:shop_hub_store/views/screens/cart_screen.dart';
import 'package:shop_hub_store/views/screens/category_screen.dart';
import 'package:shop_hub_store/views/screens/favorite_screen.dart';
import 'package:shop_hub_store/views/screens/home_scren.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int pageIndex = 0;

  List<Widget> _pages = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    FavoriteScreen(),
    AccountScreen(),
    LogoutScreen()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        unselectedItemColor: Colors.black,
        selectedItemColor: Color(0xFF103DE5),
        currentIndex: pageIndex,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/images/store-1.png',
              width: 20,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/explore.svg'),
            label: 'Catergories',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/cart.svg'),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/favorite.svg'),
            label: 'Favorite',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/images/account.svg'),
            label: 'account',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.logout,
            ),
            label: 'Logout',
          ),
        ],
      ),
      body: _pages[pageIndex],
    );
  }
}
