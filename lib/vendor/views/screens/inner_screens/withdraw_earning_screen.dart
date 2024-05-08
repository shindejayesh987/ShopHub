import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:uuid/uuid.dart';

class WithdrawEarningScreen extends StatefulWidget {
  @override
  State<WithdrawEarningScreen> createState() => _WithdrawEarningScreenState();
}

class _WithdrawEarningScreenState extends State<WithdrawEarningScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  late String bankName;

  late String accountName;

  late String accountNumber;

  late String amount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Withdraw Earning'),
        iconTheme: IconThemeData(color: Colors.pink),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextFormField(
                onChanged: (value) {
                  bankName = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Fill this Field !';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Bank Name',
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, letterSpacing: 5),
                  hintText: 'Enter Bank Name',
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) {
                  accountName = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Fill this Field !';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Account Name',
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, letterSpacing: 5),
                  hintText: 'Enter Account Name',
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) {
                  accountNumber = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Fill this Field !';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Bank Account Number',
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, letterSpacing: 5),
                  hintText: 'Enter Bank Account Name',
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onChanged: (value) {
                  amount = value;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please Fill this Field !';
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle:
                      TextStyle(fontWeight: FontWeight.bold, letterSpacing: 5),
                  hintText: 'Enter Amount',
                  hintStyle:
                      TextStyle(fontWeight: FontWeight.bold, letterSpacing: 2),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              InkWell(
                onTap: () async {
                  DocumentSnapshot userDoc = await _firestore
                      .collection('vendors')
                      .doc(_auth.currentUser!.uid)
                      .get();

                  if (_formKey.currentState!.validate()) {
                    final withDrawId = Uuid().v4();
                    EasyLoading.show();
                    await _firestore
                        .collection('withdrawl')
                        .doc(withDrawId)
                        .set({
                      'businessName': (userDoc.data()
                          as Map<String, dynamic>)['businessName'],
                      'bankName': bankName,
                      'accountName': accountName,
                      'accountNumber': accountNumber,
                      'amount': amount,
                    }).whenComplete(() {
                      EasyLoading.dismiss();
                    });
                  } else {
                    print('bad');
                  }
                },
                child: Container(
                  height: 40,
                  width: MediaQuery.of(context).size.width - 40,
                  decoration: BoxDecoration(
                      color: Colors.pink,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      'Transfer',
                      style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 2,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
