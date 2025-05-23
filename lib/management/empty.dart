import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/management/settings/private_settings.dart';
import 'package:noviwebsite/management/settings/tclub_both_settings.dart';
import 'package:noviwebsite/management/settings/tclub_court_settings.dart';
import 'package:noviwebsite/management/settings/tclub_member_settings.dart';
import 'package:noviwebsite/management/tclub/courtmanagement/courtmanagement.dart';
import 'package:noviwebsite/management/tclub/membershipmanagement/membershipmanagement.dart';
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
        int businessplan;
        if (widget.projectInfo.data()!.containsKey('businessplan')) {
          businessplan = widget.projectInfo["businessplan"];
        } else {
          businessplan = -1;
        }

        child = MyScaffold(
          child: currentIndex == 0
              ? PrivateProject(widget.projectInfo["appname"],
                  widget.projectInfo.id, businessplan)
              : currentIndex == 1
                  ? CourtManagement(widget.projectInfo)
                  : TclubCourtProjectSettings(widget.projectInfo),
          bBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.message), label: "Überblick"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.date_range_rounded), label: "Plätze"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Einstellungen"),
            ],
          ),
        );
      } else if (abo == "Membershipmanagment") {
        int businessplan;
        if (widget.projectInfo.data()!.containsKey('businessplan')) {
          businessplan = widget.projectInfo["businessplan"];
        } else {
          businessplan = -1;
        }

        child = MyScaffold(
          child: currentIndex == 0
              ? PrivateProject(widget.projectInfo["appname"],
                  widget.projectInfo.id, businessplan)
              : currentIndex == 1
                  ? MembershipManagement(widget.projectInfo)
                  : TclubMemberProjectSettings(widget.projectInfo),
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
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
            ],
          ),
        );
      } else if (abo == "Bothmanagment") {
        int businessplan;
        if (widget.projectInfo.data()!.containsKey('businessplan')) {
          businessplan = widget.projectInfo["businessplan"];
        } else {
          businessplan = -1;
        }

        child = MyScaffold(
          child: currentIndex == 0
              ? PrivateProject(widget.projectInfo["appname"],
                  widget.projectInfo.id, businessplan)
              : (currentIndex == 1)
                  ? CourtManagement(widget.projectInfo)
                  : (currentIndex == 2)
                      ? MembershipManagement(widget.projectInfo)
                      : TclubBothProjectSettings(widget.projectInfo),
          bBar: BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.message), label: "Überblick"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.date_range_rounded), label: "Plätze"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.card_membership_rounded), label: "Nutzer"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Einstellungen"),
            ],
          ),
        );
      } else {
        child = const Center(
            child: Text("Sorry, this Project has no subscription"));
      }
    } else {
      int businessplan;
      if (widget.projectInfo.data()!.containsKey('businessplan')) {
        businessplan = widget.projectInfo["businessplan"];
      } else {
        businessplan = 0;
      }

      child = MyScaffold(
        bBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.message), label: "Überblick"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Einstellungen"),
          ],
        ),
        child: currentIndex == 0
            ? PrivateProject(widget.projectInfo.data()!["appname"],
                widget.projectInfo.id, businessplan)
            : PrivateProjectSettings(widget.projectInfo),
      );
    }
    return child;
  }
}
