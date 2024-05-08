import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class VendorOrderScreen extends StatelessWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String formatedDate(date) {
    final outputDateFormat = DateFormat("dd/MM/yyyy");

    final outPutDate = outputDateFormat.format(date);

    return outPutDate;
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
        .collection('orders')
        .where('vendorId', isEqualTo: _auth.currentUser!.uid)
        .snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text("Orders"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data =
                  document.data()! as Map<String, dynamic>;
              return Slidable(
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 14,
                          child: data['accepted'] == true
                              ? Icon(Icons.delivery_dining)
                              : Icon(Icons.access_time),
                        ),
                        title: data["accepted"] == true
                            ? Text(
                                'Accepted',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              )
                            : Text(
                                'Not Accepted',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                        trailing: Text(
                          "\$" + data['price'].toStringAsFixed(2),
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                        ),
                      ),
                      ExpansionTile(
                        title: Text(
                          'Order Details',
                          style: TextStyle(color: Colors.pink.shade900),
                        ),
                        subtitle: Text(
                          'View Order Details',
                        ),
                        children: [
                          ListTile(
                            leading: CircleAvatar(
                              child: Image.network(data['productImage'][0]),
                            ),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data['productName'],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      'Quantity',
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      data['quantity'].toString(),
                                      style: TextStyle(
                                          color: Colors.pink.shade900),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            subtitle: ListTile(
                              title: Text(
                                'Buyer Details',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.w500),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    data['fullName'],
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    data['email'],
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "order date" +
                                          " " +
                                          formatedDate(
                                            data['orderDate'].toDate(),
                                          ),
                                      style: TextStyle(
                                        color: Colors.blue,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  key: const ValueKey(0),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(onDismissed: () {}),
                    children: [
                      SlidableAction(
                        onPressed: (context) async {
                          await _firestore
                              .collection('orders')
                              .doc(data['orderId'])
                              .update({
                            'accepted': false,
                          });
                        },
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Reject',
                      ),
                      SlidableAction(
                        onPressed: (context) async {
                          await _firestore
                              .collection('orders')
                              .doc(data['orderId'])
                              .update({
                            'accepted': true,
                          });
                        },
                        backgroundColor: Color(0xFF21B7CA),
                        foregroundColor: Colors.white,
                        icon: Icons.share,
                        label: 'Accept',
                      ),
                    ],
                  ));
            }).toList(),
          );
        },
      ),
    );
  }
}
