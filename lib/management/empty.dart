import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/management/tclub/courtmanagement/courtmanagement.dart';
import 'package:noviwebsite/management/tclub/membershipmanagement.dart';
import 'package:noviwebsite/styling.dart';
import 'package:noviwebsite/management/overview.dart';

class EmptyProject extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> projectInfo;
  const EmptyProject(this.projectInfo, {Key? key}) : super(key: key);

  @override
  State<EmptyProject> createState() => _EmptyProjectState();
}

class _EmptyProjectState extends State<EmptyProject> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    String projectFamily = widget.projectInfo.data()!["projectfamily"];
    Widget child;
    if (projectFamily == "Tclub") {
      // Tclub Management
      String abo = widget.projectInfo.data()!["abo"];
      if (abo == "Courtmanagment") {
        child = MyScaffold(
          child: currentIndex == 0
              ? PrivateProject(
                  widget.projectInfo["appname"], widget.projectInfo.id)
              : CourtManagement(widget.projectInfo),
          bBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.message), label: "Overview"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.date_range_rounded), label: "Courts"),
            ],
          ),
        );
      } else if (abo == "Membershipmanagment") {
        child = MyScaffold(
          child: currentIndex == 0
              ? PrivateProject(
                  widget.projectInfo["appname"], widget.projectInfo.id)
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
                  icon: Icon(Icons.message), label: "Overview"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.card_membership_rounded), label: "Users"),
            ],
          ),
        );
      } else if (abo == "Bothmanagment") {
        child = MyScaffold(
          child: currentIndex == 0
              ? PrivateProject(
                  widget.projectInfo["appname"], widget.projectInfo.id)
              : (currentIndex == 1)
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
                  icon: Icon(Icons.message), label: "Overview"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.date_range_rounded), label: "Courts"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.card_membership_rounded), label: "Users"),
            ],
          ),
        );
      } else {
        child = const Center(
            child: Text("Sorry, this Project has no subscription"));
      }
    } else {
      child = PrivateProject(
          widget.projectInfo.data()!["appname"], widget.projectInfo.id);
    }
    return MyScaffold(child: child);
  }
}
