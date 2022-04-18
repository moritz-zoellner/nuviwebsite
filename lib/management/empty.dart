import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/management/tclub/both.dart';
import 'package:noviwebsite/management/tclub/courtmanagement/courtmanagement.dart';
import 'package:noviwebsite/management/tclub/membershipmanagement.dart';
import 'package:noviwebsite/styling.dart';
import 'package:noviwebsite/management/overview.dart';

class EmptyProject extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>> projectInfo;
  const EmptyProject(this.projectInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String projectFamily = projectInfo.data()!["projectfamily"];
    Widget child;
    if (projectFamily == "Tclub") {
      // Tclub Management
      String abo = projectInfo.data()!["abo"];
      if (abo == "Courtmanagment") {
        child = CourtManagement(projectInfo);
      } else if (abo == "Membershipmanagment") {
        child = MembershipManagement(projectInfo);
      } else if (abo == "Bothmanagment") {
        child = BothManagement(projectInfo);
      } else {
        child = const Center(
            child: Text("Sorry, this Project has no subscription"));
      }
    } else {
      child = PrivateProject(projectInfo.data()!["appname"], projectInfo.id);
    }
    return MyScaffold(child: child);
  }
}
