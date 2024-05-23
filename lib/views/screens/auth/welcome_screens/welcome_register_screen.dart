import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_hub_store/vendor/views/auth/vendor_auth_screen.dart';
import 'package:shop_hub_store/vendor/views/auth/vendor_registration_screen.dart';
import 'package:shop_hub_store/vendor/views/screens/landing_screen.dart';
import 'package:shop_hub_store/views/screens/auth/register_screen.dart';
import 'package:shop_hub_store/views/screens/auth/welcome_screens/welcome_login_screen.dart';

class WelcomeRegisterScreen extends StatefulWidget {
  const WelcomeRegisterScreen({super.key});

  @override
  State<WelcomeRegisterScreen> createState() => _WelcomeRegisterScreenState();
}

class _WelcomeRegisterScreenState extends State<WelcomeRegisterScreen> {
  @override
  Widget build(BuildContext context) {
    final double screensWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: screensWidth,
        height: screenHeight,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.blue.shade900,
        ),
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            Positioned(
              top: 0,
              left: -40,
              child: Image.asset(
                'assets/images/doorpng2.png',
                width: screensWidth + 80,
                height: screenHeight + 100,
              ),
            ),
            Positioned(
              child: Image.asset(
                'assets/images/Welcome.jpg',
              ),
            ),
            Positioned(
              top: screenHeight * 0.641,
              left: screensWidth * 0.07,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return CustomerRegisterScreen();
                  }));
                },
                child: Container(
                  width: screensWidth * 0.85,
                  height: screenHeight * 0.085,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      'Register as Customer',
                      style: TextStyle(
                        fontSize: screenHeight * 0.022,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.77,
              left: screensWidth * 0.07,
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return VendorAuthScreen();
                  }));
                },
                child: Container(
                  width: screensWidth * 0.85,
                  height: screenHeight * 0.085,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: Text(
                      'Register as Vendor',
                      style: TextStyle(
                        fontSize: screenHeight * 0.022,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.88,
              left: screensWidth * 0.065,
              child: Row(
                children: [
                  Text(
                    'Already have an Account?',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    width: screensWidth * 0.022,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return WelcomeLoginScreen();
                          },
                        ),
                      );
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.blue.shade300,
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
    );
  }
}
