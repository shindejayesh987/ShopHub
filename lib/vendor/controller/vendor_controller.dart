import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:image_picker/image_picker.dart';

class VendorController {
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  pickStoreImage(ImageSource source) async {
    final ImagePicker _pickImage = ImagePicker();

    XFile? _file = await _pickImage.pickImage(source: source);

    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Iamge Selected');
    }
  }

  _uploadVendorStoreImage(Uint8List? image) async {
    Reference ref = _firebaseStorage
        .ref()
        .child('storeImage')
        .child(_auth.currentUser!.uid);

    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> vendorRegistrationForm(
      String businessName,
      String emailAddress,
      String phoneNumber,
      String countryValue,
      String stateValue,
      String cityValue,
      Uint8List? image) async {
    String res = 'Something went Wrong';

    try {
      String downloadUrl = await _uploadVendorStoreImage(image);

      await _firestore.collection('vendors').doc(_auth.currentUser!.uid).set({
        'businessName': businessName,
        'storeImage': downloadUrl,
        'emailAddress': emailAddress,
        'phoneNumber': phoneNumber,
        'countryValue': countryValue,
        'stateValue': stateValue,
        'cityValue': cityValue,
        'vendorId': _auth.currentUser!.uid,
        'approved': false,
      });

      res = 'success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
