import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:shop_hub_store/vendor/provider/product_provider.dart';
import 'package:shop_hub_store/vendor/views/auth/vendor_auth_screen.dart';
import 'package:shop_hub_store/views/screens/auth/login_screen.dart';
import 'package:shop_hub_store/views/screens/auth/welcome_screens/welcome_register_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: FirebaseOptions(
              apiKey: "AIzaSyDIzsB2sB0SCQKWI1VkIQpGdKweWVZMupY",
              appId: "1:258368723373:android:27f5f8e47579c9a9a92924",
              messagingSenderId: "258368723373",
              projectId: "shop-hub-store",
              storageBucket: "gs://shop-hub-store.appspot.com"))
      : await Firebase.initializeApp();

  // runApp(const MyApp());

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (
        _,
      ) {
        return ProductProvider();
      })
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //  home: LoginScreen(),
      home: WelcomeRegisterScreen(),
      builder: EasyLoading.init(),
      //  home: VendorAuthScreen(),
    );
  }
}
