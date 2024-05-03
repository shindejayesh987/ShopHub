import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class LogoutScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () async {
            await _auth.signOut();
          },
          child: Text(
            'SignOut',
            style: TextStyle(
                fontSize: 20, letterSpacing: 4, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
