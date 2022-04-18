import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/management/tclub/courtmanagement/myappbar.dart';
import 'package:noviwebsite/styling.dart';

const int DAYS_FOREWARD = 8;

class CourtManagement extends StatefulWidget {
  // prjectInfo.id ist die UID von dem Apps Project und übertragen auf courts
  final DocumentSnapshot<Map<String, dynamic>> projectInfo;
  const CourtManagement(this.projectInfo, {Key? key}) : super(key: key);

  @override
  State<CourtManagement> createState() => _CourtManagementState();
}

const int NONE = -1, DELETE = 0, SET = 1;

class _CourtManagementState extends State<CourtManagement> {
  int operation = NONE, currentIndex = -1, currentDay = -1;
  @override
  Widget build(BuildContext context) {
    List<dynamic> courts = widget.projectInfo["courts"];
    return DefaultTabController(
        length: DAYS_FOREWARD,
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MyAppBar(widget.projectInfo["appname"]),
              Expanded(
                child: CourtGridCover(
                    child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        stream: FirebaseFirestore.instance
                            .collection("tclub")
                            .doc(widget.projectInfo.id)
                            .collection("courts")
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                                  
                          return TabBarView(
                              physics: const NeverScrollableScrollPhysics(),
                              children: List.generate(DAYS_FOREWARD, (day) {
                                return Column(
                                  children: [
                                    Expanded(
                                      child: GridView.builder(
                                          padding: const EdgeInsets.all(10),
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: 33 * courts.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                                  mainAxisExtent: 80,
                                                  mainAxisSpacing: 10,
                                                  crossAxisSpacing: 10,
                                                  crossAxisCount:
                                                      courts.length),
                                          itemBuilder: (context, index) {
                                            if (currentIndex == index) {}
                                            if (index < courts.length) {
                                              return MyGridItem(
                                                  text: courts[index]);
                                            } else if (index % courts.length ==
                                                0) {
                                              return MyGridItem(
                                                  text: dateToStringTime(
                                                      index, courts.length));
                                            }
                                            int option = -1;
                                            try {
                                              if (snapshot.data!.docs
                                                      .firstWhere((element) =>
                                                          element.id ==
                                                          "$index;${dateToString(DateTime.now().add(Duration(days: day)))}")
                                                      .data()["players"]
                                                      .first ==
                                                  "Admin") {
                                                option = 0;
                                                // Deine Reservierungen
                                              } else {
                                                // Andrere Reservierngen
                                                option = 1;
                                              }
                                            } catch (e) {
                                              // Keine Reservierungen
                                              option = 2;
                                            }
                                            if (DateTime.now().isAfter(
                                                    getTimeByIndex(index,
                                                        courts.length)) &&
                                                day == 0) {
                                              return MyGridItem(
                                                color: Colors.black12,
                                                onPressed: () {
                                                  setState(() {
                                                    operation = NONE;
                                                    currentIndex = -1;
                                                    currentDay = -1;
                                                  });
                                                },
                                              );
                                            }

                                            Color color = (option == 0
                                                ? Colors.green
                                                : option == 1
                                                    ? Colors.cyan
                                                    : Colors.white10);
                                            return MyGridItem(
                                              color: (currentIndex == index)
                                                  ? color.withAlpha(50)
                                                  : color,
                                              onPressed: () {
                                                (currentIndex == index)
                                                    ? setState(() {
                                                        operation = NONE;
                                                        currentIndex = -1;
                                                        currentDay = -1;
                                                      })
                                                    : setState(() {
                                                        currentIndex = index;
                                                        currentDay = day;

                                                        operation = option == 0
                                                            ? DELETE
                                                            : option == 1
                                                                ? DELETE
                                                                : SET;
                                                      });
                                              },
                                            );
                                          }),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 10, right: 10),
                                      child: SizedBox(
                                        height: 50,
                                        child: OverflowBar(
                                          alignment: MainAxisAlignment.end,
                                          spacing: 20,
                                          overflowSpacing: 20,
                                          children: [
                                            (operation == DELETE)
                                                ? MyBlueButton("Platz löschen",
                                                    onPressed: () {
                                                    String courtId =
                                                        "$currentIndex;${dateToString(DateTime.now().add(Duration(days: currentDay)))}";

                                                    // Andrere Reservierungen
                                                    // Deine Reservierungen
                                                    waitDialog(context);
                                                    FirebaseFirestore.instance
                                                        .collection("tclub")
                                                        .doc(widget
                                                            .projectInfo.id)
                                                        .collection("courts")
                                                        .doc(courtId)
                                                        .delete()
                                                        .then((value) {
                                                      closeDialog(context);
                                                      setState(() {
                                                        // operation = SET;
                                                        operation = NONE;
                                                        currentIndex = -1;
                                                        currentDay = -1;
                                                      });
                                                    }).catchError((e) {
                                                      closeDialog(context);
                                                    });
                                                  })
                                                : (operation == SET)
                                                    ? MyBlueButton(
                                                        "Platz reservieren",
                                                        onPressed: () {
                                                        String courtId =
                                                            "$currentIndex;${dateToString(DateTime.now().add(Duration(days: currentDay)))}";

                                                        // Keine Reservierungen
                                                        waitDialog(context);

                                                        FirebaseFirestore
                                                            .instance
                                                            .collection("tclub")
                                                            .doc(widget
                                                                .projectInfo.id)
                                                            .collection(
                                                                "courts")
                                                            .doc(courtId)
                                                            .set({
                                                          "index": currentIndex,
                                                          "date": dateToString(
                                                              DateTime.now()
                                                                  .add(Duration(
                                                                      days:
                                                                          currentDay))),
                                                          "players": ["Admin"]
                                                        }).then((value) {
                                                          closeDialog(context);
                                                          setState(() {
                                                            //operation = DELETE;
                                                            operation = NONE;
                                                            currentIndex = -1;
                                                            currentDay = -1;
                                                          });
                                                        }).catchError((e) {
                                                          closeDialog(context);
                                                        });
                                                      })
                                                    : const SizedBox.shrink(),
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                );
                              }, growable: false));
                        })),
              )
            ]));
  }
}

class MyGridItem extends StatelessWidget {
  final String text;
  final Color? color;
  final Function()? onPressed;
  const MyGridItem({this.text = "", this.color, this.onPressed, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        onPressed: onPressed,
        elevation: 0,
        focusElevation: 0,
        hoverElevation: 0,
        highlightElevation: 0,
        color: color,
        child: Text(text, style: const TextStyle(fontSize: 16)));
  }
}

class CourtGridCover extends StatelessWidget {
  final Widget? child;
  const CourtGridCover({this.child, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
        child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(20)),
            child: Container(color: Colors.white70, child: child)));
  }
}

String dateToStringTime(int index, int crossAxisCount) {
  DateTime d = getTimeByIndex(index, crossAxisCount);
  return "${d.hour}:${d.minute}";
}

DateTime getTimeByIndex(int index, int crossAxisCount) {
  return DateTime.now()
      .subtract(Duration(
          hours: DateTime.now().hour,
          minutes: DateTime.now().minute,
          seconds: DateTime.now().second))
      .add(Duration(hours: 6, minutes: 30 + (index ~/ crossAxisCount * 30)));
}

String dateToString(DateTime d) {
  return "${d.day}.${d.month}.${d.year}";
}
