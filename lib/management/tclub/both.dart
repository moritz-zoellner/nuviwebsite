import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/management/tclub/courtmanagement.dart';
import 'package:noviwebsite/management/tclub/membershipmanagement.dart';
import 'package:noviwebsite/styling.dart';

class BothManagement extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> projectInfo;

  const BothManagement(this.projectInfo, {Key? key}) : super(key: key);

  @override
  State<BothManagement> createState() => _BothManagementState();
}

class _BothManagementState extends State<BothManagement> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      child: currentIndex == 0
          ? CourtManagement(widget.projectInfo)
          : MembershipManagement(widget.projectInfo),
      bBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.date_range_rounded), label: "Courts"),
          BottomNavigationBarItem(
              icon: Icon(Icons.card_membership_rounded), label: "Users"),
        ],
      ),
    );
  }
}
