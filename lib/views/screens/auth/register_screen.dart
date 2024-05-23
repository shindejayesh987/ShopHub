import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_hub_store/controllers/auth_controller.dart';
import 'package:shop_hub_store/views/screens/auth/login_screen.dart';

class CustomerRegisterScreen extends StatefulWidget {
  @override
  State<CustomerRegisterScreen> createState() => _CustomerRegisterScreenState();
}

class _CustomerRegisterScreenState extends State<CustomerRegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final AuthController _authController = AuthController();
  bool _isLoading = false;

  late String email;

  late String fullName;

  late String password;

  Uint8List? _image;

  selectGalleryImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  captureImage() async {
    Uint8List im = await _authController.pickProfileImage(ImageSource.camera);

    setState(() {
      _image = im;
    });
  }

  registerUser() async {
    if (_image != null) {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });
        String res = await _authController.createNewUser(
            email, fullName, password, _image);
        setState(() {
          _isLoading = false;
        });

        if (res == 'success') {
          setState(() {
            _isLoading = false;
          });
          Get.to(CustomerLoginScreen());
          Get.snackbar(
            'Success',
            'Account has been created successfully',
            backgroundColor: Color.fromARGB(255, 12, 101, 173),
            colorText: Colors.white,
            margin: EdgeInsets.all(
              15,
            ),
            icon: Icon(
              Icons.message,
              color: Colors.white,
            ),
          );
        } else {
          Get.snackbar(
            'Error1',
            res.toString(),
            backgroundColor: Color.fromARGB(255, 12, 101, 173),
            colorText: Colors.white,
            snackPosition: SnackPosition.BOTTOM,
            margin: EdgeInsets.all(
              15,
            ),
            icon: Icon(
              Icons.message,
              color: Colors.white,
            ),
          );
        }
      } else {
        Get.snackbar(
          'Form',
          'Form Field is not valid',
          backgroundColor: Color.fromARGB(255, 12, 101, 173),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(
            15,
          ),
          icon: Icon(
            Icons.message,
            color: Colors.white,
          ),
        );
      }
    } else {
      Get.snackbar('No Image', 'Please upload your image',
          backgroundColor: Color.fromARGB(255, 12, 101, 173),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          margin: EdgeInsets.all(
            15,
          ),
          icon: Icon(
            Icons.message,
            color: Colors.white,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Register on ShopHub Store",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Stack(
                  children: [
                    _image == null
                        ? CircleAvatar(
                            radius: 65,
                            child: Icon(
                              Icons.person_3,
                              size: 70,
                            ),
                          )
                        : CircleAvatar(
                            radius: 65,
                            backgroundImage: MemoryImage(_image!),
                          ),
                    Positioned(
                      right: 0,
                      top: 15,
                      child: IconButton(
                        onPressed: () {
                          selectGalleryImage();
                        },
                        icon: Icon(
                          CupertinoIcons.photo,
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                // Image.asset(
                //   'assets/images/abc.png',
                //   width: 100,
                //   height: 100,
                // ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (value) {
                    email = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Email address must not be empty";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Email Address",
                    hintText: "Enter Email Address",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Color(0xFF103DE5),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (value) {
                    fullName = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please Full name must not be empty";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Full Name",
                    hintText: "Enter Full Name",
                    prefixIcon: Icon(
                      Icons.person_2,
                      color: Color(0xFF103DE5),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please password must not be empty";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter Password",
                    prefixIcon: Icon(
                      Icons.lock,
                      color: Color(0xFF103DE5),
                    ),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                InkWell(
                  onTap: () {
                    registerUser();
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 40,
                    decoration: BoxDecoration(
                        color: Color(0xFF103DE5),
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: _isLoading
                          ? CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : Text(
                              "Register",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                letterSpacing: 2,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
                // SizedBox(
                //   height: 15,
                // ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CustomerLoginScreen();
                    }));
                  },
                  child: Text(
                    'Already have an account?',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
