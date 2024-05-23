import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shop_hub_store/views/screens/category_screen.dart';

class CategoryTextWidget extends StatefulWidget {
  const CategoryTextWidget({Key? key});

  @override
  State<CategoryTextWidget> createState() => _CategoryTextWidgetState();
}

class _CategoryTextWidgetState extends State<CategoryTextWidget> {
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> _categoryStream =
        FirebaseFirestore.instance.collection('categories').snapshots();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categories',
            style: TextStyle(
                fontWeight: FontWeight.bold, letterSpacing: 2, fontSize: 20),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _categoryStream,
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Loading categories");
              }

              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var categoryData in snapshot.data!.docs)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: ActionChip(
                          onPressed: () {},
                          backgroundColor: Color.fromARGB(255, 32, 108, 183),
                          label: Text(
                            categoryData['categoryName'].toUpperCase(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    IconButton(
                      onPressed: () {
                        Get.to(CategoryScreen());
                      },
                      icon: Icon(
                        Icons.arrow_forward_ios,
                      ),
                    ),
                  ],
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
