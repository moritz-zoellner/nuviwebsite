import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/management/tclub/courtmanagement/myappbar.dart';
import 'package:noviwebsite/management/tclub/courtmanagement/mygrid.dart';

const int DAYS_FOREWARD = 8;

class CourtManagement extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>> projectInfo;
  const CourtManagement(this.projectInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<dynamic> courts = projectInfo["courts"];
    return DefaultTabController(
        length: DAYS_FOREWARD,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MyAppBar(projectInfo["appname"]),
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: Container(
                              color: Colors.white70,
                              child: StreamBuilder<
                                      QuerySnapshot<Map<String, dynamic>>>(
                                  stream: FirebaseFirestore.instance
                                      .collection("tclub")
                                      .doc(projectInfo.id)
                                      .collection("courts")
                                      .snapshots(),
                                  builder: (context, snapshot) {
                                    if (!snapshot.hasData) {
                                      return const Center(
                                          child: CircularProgressIndicator());
                                    }
                                    List<DocumentSnapshot<Map<String, dynamic>>>
                                        weeklyCourts = snapshot.data!.docs;
                                    return TabBarView(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        children:
                                            List.generate(DAYS_FOREWARD, (day) {
                                          return MyCourtGrid(
                                              weeklyCourts
                                                  .where((element) =>
                                                      element.data()![""] ==
                                                      dateToString(
                                                          DateTime.now()))
                                                  .toList(),
                                              day,
                                              courts.length + 1,
                                              courts,
                                              projectInfo);
                                        }, growable: false));
                                  })))))
            ]));
  }
}
