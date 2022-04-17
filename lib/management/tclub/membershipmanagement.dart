import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MembershipManagement extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>> projectInfo;

  const MembershipManagement(this.projectInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 40),
              child: Row(children: [
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white)),
                const SizedBox(width: 20),
                Text(projectInfo["appname"],
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30)),
              ])),
          const Expanded(child: Text("Users will be available soon"))
        ]);
  }
}
