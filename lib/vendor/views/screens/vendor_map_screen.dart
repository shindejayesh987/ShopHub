import 'package:flutter/material.dart';

class VendorMapScreen extends StatefulWidget {
  const VendorMapScreen({super.key});

  @override
  State<VendorMapScreen> createState() => VendorMapScreenState();
}

class VendorMapScreenState extends State<VendorMapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Map Screen',
        ),
      ),
    );
  }
}
