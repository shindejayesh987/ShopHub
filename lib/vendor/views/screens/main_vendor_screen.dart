import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shop_hub_store/vendor/views/screens/earnings_screen.dart';
import 'package:shop_hub_store/vendor/views/screens/logout_screen.dart';
import 'package:shop_hub_store/vendor/views/screens/upload_screen.dart';
import 'package:shop_hub_store/vendor/views/screens/vendor_orders_screen.dart';

class MainVendorScreen extends StatefulWidget {
  const MainVendorScreen({super.key});

  @override
  State<MainVendorScreen> createState() => _MainVendorScreenState();
}

class _MainVendorScreenState extends State<MainVendorScreen> {
  int _pageIndex = 0;

  List<Widget> _pages = [
    EarningsScreen(),
    //EditProductScreen(),
    VendorOrderScreen(),
    UploadScreen(),
    LogoutScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageIndex,
        onTap: (value) {
          setState(() {
            _pageIndex = value;
          });
        },
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: Colors.black,
        selectedItemColor: Colors.pink,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              CupertinoIcons.money_dollar,
            ),
            label: 'Earnings',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(
          //     Icons.edit,
          //   ),
          //   label: 'Edit',
          // ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shop,
            ),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.upload,
            ),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.logout,
            ),
            label: 'Logout',
          ),
        ],
      ),
      body: _pages[_pageIndex],
    );
  }
}
