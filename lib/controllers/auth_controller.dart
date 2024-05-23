import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthController {
  final FirebaseStorage storage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //select img from gallery
  pickProfileImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();

    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    } else {
      print('No Image selected');
    }
  }

  ///Function to Upload Image
  _uploadImageToStorage(Uint8List? image) async {
    Reference ref =
        storage.ref().child('ProfileImages').child(_auth.currentUser!.uid);
    UploadTask uploadTask = ref.putData(image!);

    TaskSnapshot snapshot = await uploadTask;

    String downloadUrl = await snapshot.ref.getDownloadURL();

    return downloadUrl;
  }

  Future<String> createNewUser(
      String email, String fullName, String password, Uint8List? image) async {
    String res = "something went wrong";
    try {
      //we want to create the user first in the authenticationt tab and later in firestore
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);

      String downloadUrl = await _uploadImageToStorage(image);

      await _firestore.collection("buyers").doc(userCredential.user!.uid).set({
        'fullName': fullName,
        'ProfileImage': downloadUrl,
        'email': email,
        'buyerId': userCredential.user!.uid,
      });
      res = 'success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  //login the created user
  Future<String> loginUser(String email, String password) async {
    String res = "Some error occured";
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);

      res = 'success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
