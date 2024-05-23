import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shop_hub_store/views/screens/widget/product_model.dart';

class MenProductsWidget extends StatelessWidget {
  const MenProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _productsStream = FirebaseFirestore.instance
        .collection('products')
        .where('category', isEqualTo: 'men')
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
      stream: _productsStream,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }

        if (snapshot.data!.docs.isEmpty) {
          return Center(
            child: Text('No men Products',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade700,
                  letterSpacing: 4,
                )),
          );
        }
        return Container(
          height: 100,
          child: PageView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: ((context, index) {
              final productData = snapshot.data!.docs[index];
              return ProductModel(productData: productData);
            }),
          ),
        );
      },
    );
  }
}
