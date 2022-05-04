import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
        child: NestedScrollView(
            headerSliverBuilder: (c, b) => [
                  SliverToBoxAdapter(
                    child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20, left: 20, right: 20, bottom: 20),
                        child: OverflowBar(
                            alignment: MainAxisAlignment.spaceBetween,
                            overflowAlignment: OverflowBarAlignment.center,
                            spacing: 40,
                            overflowSpacing: 10,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                        onPressed: () => Navigator.pop(context),
                                        icon: const Icon(
                                            Icons.arrow_back_ios_new_rounded,
                                            color: Colors.white)),
                                    const SizedBox(width: 20),
                                    Flexible(
                                      child: Text(widget.projectInfo["appname"],
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              fontSize: 30)),
                                    ),
                                  ],
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TabBar(
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        isScrollable: true,
                                        tabs: List.generate(
                                            DAYS_FOREWARD,
                                            (index) => Tab(
                                                text: dateToString(
                                                    DateTime.now().add(Duration(
                                                        days: index)))))),
                                    IconButton(
                                        tooltip: "Help",
                                        onPressed: () {
                                          showGeneralDialog(
                                              context: context,
                                              pageBuilder: (c, a1, a2) =>
                                                  Center(
                                                      child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(20),
                                                          child: ClipRRect(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                          .all(
                                                                      Radius.circular(
                                                                          20)),
                                                              child: ConstrainedBox(
                                                                  constraints: const BoxConstraints(maxHeight: 600, maxWidth: 600),
                                                                  child: Scaffold(
                                                                      body: SingleChildScrollView(
                                                                          child: Padding(
                                                                              padding: const EdgeInsets.all(20),
                                                                              child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                                                                                Row(
                                                                                  children: [
                                                                                    IconButton(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                                                                                    const SizedBox(width: 20),
                                                                                    const Text("Hilfe", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                                                                                  ],
                                                                                ),
                                                                                const Padding(
                                                                                  padding: EdgeInsets.all(20),
                                                                                  child: Text("Legende", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                                                                ),
                                                                                SizedBox(
                                                                                  height: 100,
                                                                                  width: 280,
                                                                                  child: Column(
                                                                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                    children: [
                                                                                      Expanded(
                                                                                        child: Container(
                                                                                          padding: const EdgeInsets.only(left: 10, right: 10),
                                                                                          child: const Center(
                                                                                            child: Text("Deine Reservierungen", overflow: TextOverflow.fade, style: TextStyle(color: Colors.black)),
                                                                                          ),
                                                                                          decoration: BoxDecoration(
                                                                                              color: Colors.cyan.shade200,
                                                                                              borderRadius: const BorderRadius.only(
                                                                                                topLeft: Radius.circular(20),
                                                                                                topRight: Radius.circular(20),
                                                                                              )),
                                                                                        ),
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Container(
                                                                                            padding: const EdgeInsets.only(left: 10, right: 10),
                                                                                            child: const Center(
                                                                                              child: Text("Nicht Reservierbar", overflow: TextOverflow.fade, style: TextStyle(color: Colors.black)),
                                                                                            ),
                                                                                            decoration: BoxDecoration(color: Colors.grey.shade200)),
                                                                                      ),
                                                                                      Expanded(
                                                                                        child: Container(
                                                                                          padding: const EdgeInsets.only(left: 10, right: 10),
                                                                                          child: const Center(
                                                                                            child: Text("Stornierbar", overflow: TextOverflow.fade, style: TextStyle(color: Colors.black)),
                                                                                          ),
                                                                                          decoration: BoxDecoration(color: Colors.pink.shade100, borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ])))))))));
                                        },
                                        icon: const Icon(
                                          Icons.info_outline_rounded,
                                          color: Colors.white,
                                        )),
                                    IconButton(
                                        tooltip: "Alte Plätze löschen",
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection("apps")
                                              .doc(widget.projectInfo.id)
                                              .collection("courts")
                                              .where("date",
                                                  isLessThan: dateToString(
                                                      DateTime.now()))
                                              .get()
                                              .catchError((e) => myCustomError(
                                                  context,
                                                  "Fehler beim Löschen der Plätze"))
                                              .then((value) async {
                                                for(DocumentSnapshot doc in value.docs) {
                                                  await FirebaseFirestore.instance
                                                      .collection("apps")
                                                      .doc(widget.projectInfo.id)
                                                      .collection("courts").doc(doc.id).delete();
                                                }
                                              myCustomError(context, "Courts gelöscht");
                                          });
                                        },
                                        icon: const Icon(
                                            Icons.auto_delete_outlined, color: Colors.white)),
                                    myButton()
                                  ],
                                ),
                              )
                            ])),
                  )
                ],
            body: Padding(
                padding: const EdgeInsets.all(20),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: Container(
                      color: Colors.grey.shade50,
                      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection("apps")
                              .doc(widget.projectInfo.id)
                              .collection("courts")
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return waitWidget();
                            }

                            return TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: List.generate(DAYS_FOREWARD, (day) {
                                  return GridView.builder(
                                      padding: const EdgeInsets.all(10),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: 33 * courts.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10,
                                              crossAxisCount: courts.length),
                                      itemBuilder: (context, index) {
                                        //if (currentIndex == index) {}
                                        if (index < courts.length) {
                                          return MyGridItem(
                                              text: courts[index]);
                                        } else if (index % courts.length == 0) {
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
                                                getTimeByIndex(
                                                    index, courts.length)) &&
                                            day == 0) {
                                          return MyGridItem(
                                              color: Colors.grey.shade100,
                                              onPressed: null);
                                          //   () {
                                          //     setState(() {
                                          //       operation = NONE;
                                          //       currentIndex = -1;
                                          //       currentDay = -1;
                                          //     });
                                          //   },
                                        }

                                        Color color = (option == 0
                                            ? Colors.cyan.shade200
                                            : option == 1
                                                ? Colors.pink.shade100
                                                : Colors.cyan.shade50);
                                        return MyGridItem(
                                          color: (currentIndex == index)
                                              ? Color.alphaBlend(
                                                  Colors.black12, color)
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
                                      });
                                }, growable: false));
                          })),
                ))));
  }

  Widget myButton() => Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: (operation == DELETE)
          ? IconButton(
              tooltip: "Platz stornieren",
              icon: const Icon(Icons.cancel, color: Colors.white),
              onPressed: () {
                String courtId =
                    "$currentIndex;${dateToString(DateTime.now().add(Duration(days: currentDay)))}";

                // Andrere Reservierungen
                // Deine Reservierungen
                waitDialog(context);
                FirebaseFirestore.instance
                    .collection("apps")
                    .doc(widget.projectInfo.id)
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
              ? IconButton(
                  tooltip: "Platz reservieren",
                  icon: const Icon(Icons.post_add, color: Colors.white),
                  onPressed: () {
                    String courtId =
                        "$currentIndex;${dateToString(DateTime.now().add(Duration(days: currentDay)))}";

                    // Keine Reservierungen
                    waitDialog(context);

                    FirebaseFirestore.instance
                        .collection("apps")
                        .doc(widget.projectInfo.id)
                        .collection("courts")
                        .doc(courtId)
                        .set({
                      "index": currentIndex,
                      "date": dateToString(
                          DateTime.now().add(Duration(days: currentDay))),
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
              : const SizedBox.shrink());
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
        disabledColor: color,
        padding: const EdgeInsets.all(2),
        child: Text(text,
            overflow: TextOverflow.clip,
            maxLines: 2,
            style: const TextStyle(fontSize: 16)));
  }
}

String dateToStringTime(int index, int crossAxisCount) {
  DateTime d = getTimeByIndex(index, crossAxisCount);
  String time = "${d.hour}:${d.minute}";
  if (time.split(":").first.length == 1) {
    time = "0" + time;
  }
  if (time.split(":").last.length == 1) {
    time = time + "0";
  }
  return time;
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
