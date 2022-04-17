import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/styling.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: FirebaseFirestore.instance.collection("blog").get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          List<DocumentSnapshot<Map<String, dynamic>>> list =
              snapshot.data!.docs;
          return ListView.builder(
              itemCount: list.length,
              itemBuilder: (_, index) {
                Map<String, dynamic> post = list[index].data()!;
                return Center(
                    child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 800),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              Text(post["Title"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.white)),
                              const SizedBox(height: 20),
                              NoviTile(Text(post["Content"],
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 16))),
                              const SizedBox(height: 20),
                            ])));
              });
        });
  }
}
