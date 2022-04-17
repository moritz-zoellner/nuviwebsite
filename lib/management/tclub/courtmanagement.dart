import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/styling.dart';

const int DAYS_FOREWARD = 8;

class MyAppBar extends StatelessWidget {
  final String name;
  const MyAppBar(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 40),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white)),
              const SizedBox(width: 20),
              Text(name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30)),
            ],
          ),
          const SizedBox(width: 40),
          Flexible(
            child: TabBar(
                isScrollable: true,
                tabs: List.generate(
                    DAYS_FOREWARD,
                    (index) => Tab(
                        text: dateToString(
                            DateTime.now().add(Duration(days: index)))))),
          )
        ]));
  }
}

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
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: Container(
                  color: Colors.white70,
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: FirebaseFirestore.instance
                        .collection("tclub")
                        .doc(projectInfo.id)
                        .collection("courts")
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      List<DocumentSnapshot<Map<String, dynamic>>>
                          weeklyCourts = snapshot.data!.docs;
                      return TabBarView(
                          physics: const NeverScrollableScrollPhysics(),
                          children: List.generate(DAYS_FOREWARD, (day) {
                            List<DocumentSnapshot<Map<String, dynamic>>>
                                dailyCourts = weeklyCourts
                                    .where((element) =>
                                        element.data()![""] ==
                                        dateToString(DateTime.now()))
                                    .toList();
                            return GridView.builder(
                                padding: const EdgeInsets.only(
                                    bottom: 10, right: 10, left: 10),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: 33 * (courts.length + 1),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        mainAxisSpacing: 10,
                                        crossAxisSpacing: 10,
                                        crossAxisCount: courts.length + 1),
                                itemBuilder: (context, index) {
                                  if (index == 0) {
                                    return const CourtTextGridItem("");
                                  }
                                  index -= 1;
                                  if (index < courts.length) {
                                    return CourtTextGridItem(courts[index]);
                                  } else if ((index + 1) %
                                          (courts.length + 1) ==
                                      0) {
                                    String time = dateToStringTime(
                                        DateTime.now()
                                            .subtract(Duration(
                                                hours: DateTime.now().hour,
                                                minutes: DateTime.now().minute,
                                                seconds: DateTime.now().second))
                                            .add(Duration(
                                                hours: 6,
                                                minutes: 30 +
                                                    ((index + 1) ~/
                                                        (courts.length + 1) *
                                                        30))));
                                    return TimeTextGridItem(time);
                                  }
                                  try {
                                    DocumentSnapshot<
                                        Map<String,
                                            dynamic>> court = dailyCourts
                                        .where((element) =>
                                            element.id ==
                                            "{$index|${dateToString(DateTime.now().add(Duration(days: day)))}")
                                        .toList()
                                        .first;

                                    return ReservedGridItem(
                                        projectInfo.id,
                                        index,
                                        dateToString(DateTime.now()
                                            .add(Duration(days: day))));
                                  } on StateError {
                                    return EmptyGridItem(
                                        projectInfo.id,
                                        index,
                                        dateToString(DateTime.now()
                                            .add(Duration(days: day))));
                                  }
                                });
                          }, growable: false));
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ReservedGridItem extends StatelessWidget {
  final String uid;
  final int index;
  final String date;
  const ReservedGridItem(this.uid, this.index, this.date, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        FirebaseFirestore.instance
            .collection("tclub_courts")
            .doc(uid)
            .collection("courts")
            .doc("$index|$date")
            .delete();
      },
      color: Colors.grey.shade400,
    );
  }
}

class EmptyGridItem extends StatelessWidget {
  final String uid;
  final int index;
  final String date;
  const EmptyGridItem(this.uid, this.index, this.date, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      onPressed: () {
        FirebaseFirestore.instance
            .collection("tclub_courts")
            .doc(uid)
            .collection("courts")
            .doc("$index|$date")
            .set({
          "index": index,
          "date": date,
          "players": ["Admin"]
        });
      },
      elevation: 0,
      focusElevation: 0,
      hoverElevation: 0,
      highlightElevation: 0,
      color: Colors.white10,
    );
  }
}

class TimeTextGridItem extends StatelessWidget {
  final String text;
  const TimeTextGridItem(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Center(child: Text(text, style: const TextStyle(fontSize: 16)));
}

class CourtTextGridItem extends StatelessWidget {
  final String text;
  const CourtTextGridItem(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Center(child: Text(text, style: const TextStyle(fontSize: 20)));
}

String dateToString(DateTime d) {
  return "${d.day}.${d.month}.${d.year}";
}

String dateToStringTime(DateTime d) {
  return "${d.hour}:${d.minute}";
}
