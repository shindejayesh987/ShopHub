import 'package:country_state_city_picker/country_state_city_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shop_hub_store/vendor/controller/vendor_controller.dart';

class VendorRegistrationScreen extends StatefulWidget {
  @override
  State<VendorRegistrationScreen> createState() =>
      _VendorRegistrationScreenState();
}

class _VendorRegistrationScreenState extends State<VendorRegistrationScreen> {
  final VendorController _vendorController = VendorController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Uint8List? _image;

  late String countryValue;

  late String emailAddress;

  late String phoneNumber;

  late String businessName;

  late String stateValue;

  late String cityValue;

  selectGalleryImage() async {
    Uint8List im = await _vendorController.pickStoreImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  selectCameraImage() async {
    Uint8List im = await _vendorController.pickStoreImage(ImageSource.gallery);

    setState(() {
      _image = im;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            backgroundColor: Colors.pink,
            flexibleSpace: FlexibleSpaceBar(
              background: LayoutBuilder(
                builder: (context, constraints) {
                  return Center(
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: _image != null
                          ? Image.memory(_image!)
                          : IconButton(
                              onPressed: () {
                                selectGalleryImage();
                              },
                              icon: Icon(
                                CupertinoIcons.photo,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please insert Business Name';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        businessName = value;
                      },
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        labelText: 'Business Name',
                        hintText: 'Business Name',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please insert Email Address';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        emailAddress = value;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address',
                        hintText: 'Email Address',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please insert Phone Number';
                        } else {
                          return null;
                        }
                      },
                      onChanged: (value) {
                        phoneNumber = value;
                      },
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        hintText: 'Phone Number',
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SelectState(
                      onCountryChanged: (value) {
                        setState(() {
                          countryValue = value;
                        });
                      },
                      onStateChanged: (value) {
                        setState(() {
                          stateValue = value;
                        });
                      },
                      onCityChanged: (value) {
                        setState(() {
                          cityValue = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: InkWell(
          onTap: () {
            print("outside Save button");
            if (_formKey.currentState!.validate()) {
              print("Inside Save button");
              EasyLoading.show(status: 'Please wait');
              _vendorController
                  .vendorRegistrationForm(businessName, emailAddress,
                      phoneNumber, countryValue, stateValue, cityValue, _image)
                  .whenComplete(() {
                EasyLoading.dismiss();
              });
              print("After input");
            } else {
              print('false');
            }
          },
          child: Container(
            height: 50,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                color: Colors.pink, borderRadius: BorderRadius.circular(8)),
            child: Center(
              child: Text(
                'Save',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 4,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
