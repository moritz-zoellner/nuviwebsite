import 'package:flutter/material.dart';
import 'package:noviwebsite/management/tclub/courtmanagement/courtmanagement.dart';

class MyAppBar extends StatelessWidget {
  final String name;
  const MyAppBar(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 40),
        child: OverflowBar(
            alignment: MainAxisAlignment.spaceBetween,
            spacing: 40,
            overflowSpacing: 20,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
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
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: TabBar(
                        physics: const NeverScrollableScrollPhysics(),
                        isScrollable: true,
                        tabs: List.generate(
                            DAYS_FOREWARD,
                            (index) => Tab(
                                text: dateToString(DateTime.now()
                                    .add(Duration(days: index)))))),
                  ),
                  IconButton(
                      tooltip: "Help",
                      onPressed: () {
                        showGeneralDialog(
                            context: context,
                            pageBuilder: (c, a1, a2) => Center(
                                child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(20)),
                                        child: ConstrainedBox(
                                            constraints: const BoxConstraints(
                                                maxWidth: 600),
                                            child: Scaffold(
                                                body: SingleChildScrollView(
                                                    child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(20),
                                                        child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .stretch,
                                                            children: [
                                                              Row(
                                                                children: [
                                                                  IconButton(
                                                                      onPressed: () =>
                                                                          Navigator.pop(
                                                                              context),
                                                                      icon: const Icon(
                                                                          Icons
                                                                              .close)),
                                                                  const SizedBox(
                                                                      width:
                                                                          20),
                                                                  const Text(
                                                                      "How to use",
                                                                      style: TextStyle(
                                                                          fontWeight: FontWeight
                                                                              .bold,
                                                                          fontSize:
                                                                              30)),
                                                                ],
                                                              ),
                                                              const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            20),
                                                                child: Text(
                                                                    "Labeling",
                                                                    style: TextStyle(
                                                                        fontSize:
                                                                            16,
                                                                        fontWeight:
                                                                            FontWeight.bold)),
                                                              ),
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(20),
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            20),
                                                                child: const Center(
                                                                    child: Text(
                                                                        "Reservations made by administrator",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white))),
                                                                decoration: const BoxDecoration(
                                                                    color: Colors
                                                                        .green,
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(20))),
                                                              ),
                                                              Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(20),
                                                                margin:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        bottom:
                                                                            20),
                                                                child: const Center(
                                                                    child: Text(
                                                                        "Reservations made by clubmember",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white))),
                                                                decoration: const BoxDecoration(
                                                                    color: Colors
                                                                        .cyan,
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(20))),
                                                              )
                                                            ])))))))));
                      },
                      icon: const Icon(
                        Icons.info_outline_rounded,
                        color: Colors.white,
                      ))
                ],
              ),
            ]));
  }
}
