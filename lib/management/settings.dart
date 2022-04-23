import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/main.dart';
import 'package:noviwebsite/management/overview.dart';
import 'package:noviwebsite/styling.dart';

class TclubCourtProjectSettings extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>> projectInfo;
  const TclubCourtProjectSettings(this.projectInfo, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController appNameCon =
        TextEditingController(text: projectInfo["appname"]);
    TextEditingController logoCon =
        TextEditingController(text: projectInfo["logo"]);
    TextEditingController courtsCon =
        TextEditingController(text: projectInfo["courts"].toString());
    TextEditingController hperweekCon =
        TextEditingController(text: projectInfo["logo"]);
    TextEditingController phoneCon =
        TextEditingController(text: projectInfo["phone"]);
    return NestedScrollView(
        headerSliverBuilder: (c, b) => [
              const SliverToBoxAdapter(child: MyAppBar("Optionen")),
            ],
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 600),
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        TextField(
                            decoration:
                                const InputDecoration(label: Text("App Name")),
                            controller: appNameCon),
                        const SizedBox(height: 20),
                        TextField(
                          maxLines: 5,
                          decoration:
                              const InputDecoration(label: Text("App Idee")),
                          controller: logoCon,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyBlueButton("Änderungen speichern", onPressed: () {
                    waitDialog(context);
                    FirebaseFirestore.instance
                        .collection("apps")
                        .doc(projectInfo.id)
                        .update({
                      "appname": appNameCon.text,
                      "description": logoCon.text
                    }).then((value) {
                      closeDialog(context);
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const MyApp(),
                          transitionsBuilder: (c, a1, a2, w) =>
                              FadeTransition(opacity: a1, child: w),
                        ),
                      );
                      myCustomError(context, "Änderungen wurden gespeichert");
                    }).catchError((e) {
                      closeDialog(context);
                      myCustomError(context, e.toString());
                    });
                  }),
                  const SizedBox(height: 20),
                  const Text(
                    "Weitere Optionen",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  MyBlueButton("Projekt löschen", onPressed: () {
                    waitDialog(context);
                    FirebaseFirestore.instance
                        .collection("apps")
                        .doc(projectInfo.id)
                        .delete()
                        .then((value) {
                      closeDialog(context);
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const MyApp(),
                          transitionsBuilder: (c, a1, a2, w) =>
                              FadeTransition(opacity: a1, child: w),
                        ),
                      );
                      myCustomError(context, "Projekt wurde gelöscht");
                    }).catchError((e) {
                      closeDialog(context);
                      myCustomError(context, e.toString());
                    });
                  })
                ]),
          ),
        ));
  }
}

class TclubMemberProjectSettings extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>> projectInfo;
  const TclubMemberProjectSettings(this.projectInfo, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController appNameCon =
        TextEditingController(text: projectInfo["appname"]);
    TextEditingController descCon =
        TextEditingController(text: projectInfo["description"]);
    return NestedScrollView(
        headerSliverBuilder: (c, b) => [
              const SliverToBoxAdapter(child: MyAppBar("Optionen")),
            ],
        body: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        TextField(
                            decoration:
                                const InputDecoration(label: Text("App Name")),
                            controller: appNameCon),
                        const SizedBox(height: 20),
                        TextField(
                          maxLines: 5,
                          decoration:
                              const InputDecoration(label: Text("App Idee")),
                          controller: descCon,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyBlueButton("Änderungen speichern", onPressed: () {
                    waitDialog(context);
                    FirebaseFirestore.instance
                        .collection("apps")
                        .doc(projectInfo.id)
                        .update({
                      "appname": appNameCon.text,
                      "description": descCon.text
                    }).then((value) {
                      closeDialog(context);
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const MyApp(),
                          transitionsBuilder: (c, a1, a2, w) =>
                              FadeTransition(opacity: a1, child: w),
                        ),
                      );
                      myCustomError(context, "Änderungen wurden gespeichert");
                    }).catchError((e) {
                      closeDialog(context);
                      myCustomError(context, e.toString());
                    });
                  }),
                  const SizedBox(height: 20),
                  const Text(
                    "Weitere Optionen",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  MyBlueButton("Projekt löschen", onPressed: () {
                    waitDialog(context);
                    FirebaseFirestore.instance
                        .collection("apps")
                        .doc(projectInfo.id)
                        .delete()
                        .then((value) {
                      closeDialog(context);
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const MyApp(),
                          transitionsBuilder: (c, a1, a2, w) =>
                              FadeTransition(opacity: a1, child: w),
                        ),
                      );
                      myCustomError(context, "Projekt wurde gelöscht");
                    }).catchError((e) {
                      closeDialog(context);
                      myCustomError(context, e.toString());
                    });
                  })
                ]),
          ),
        ));
  }
}

class TclubBothProjectSettings extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>> projectInfo;
  const TclubBothProjectSettings(this.projectInfo, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController appNameCon =
        TextEditingController(text: projectInfo["appname"]);
    TextEditingController descCon =
        TextEditingController(text: projectInfo["description"]);
    return NestedScrollView(
        headerSliverBuilder: (c, b) => [
              const SliverToBoxAdapter(child: MyAppBar("Optionen")),
            ],
        body: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        TextField(
                            decoration:
                                const InputDecoration(label: Text("App Name")),
                            controller: appNameCon),
                        const SizedBox(height: 20),
                        TextField(
                          maxLines: 5,
                          decoration:
                              const InputDecoration(label: Text("App Idee")),
                          controller: descCon,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyBlueButton("Änderungen speichern", onPressed: () {
                    waitDialog(context);
                    FirebaseFirestore.instance
                        .collection("apps")
                        .doc(projectInfo.id)
                        .update({
                      "appname": appNameCon.text,
                      "description": descCon.text
                    }).then((value) {
                      closeDialog(context);
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const MyApp(),
                          transitionsBuilder: (c, a1, a2, w) =>
                              FadeTransition(opacity: a1, child: w),
                        ),
                      );
                      myCustomError(context, "Änderungen wurden gespeichert");
                    }).catchError((e) {
                      closeDialog(context);
                      myCustomError(context, e.toString());
                    });
                  }),
                  const SizedBox(height: 20),
                  const Text(
                    "Weitere Optionen",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  MyBlueButton("Projekt löschen", onPressed: () {
                    waitDialog(context);
                    FirebaseFirestore.instance
                        .collection("apps")
                        .doc(projectInfo.id)
                        .delete()
                        .then((value) {
                      closeDialog(context);
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const MyApp(),
                          transitionsBuilder: (c, a1, a2, w) =>
                              FadeTransition(opacity: a1, child: w),
                        ),
                      );
                      myCustomError(context, "Projekt wurde gelöscht");
                    }).catchError((e) {
                      closeDialog(context);
                      myCustomError(context, e.toString());
                    });
                  })
                ]),
          ),
        ));
  }
}

class PrivateProjectSettings extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>> projectInfo;
  const PrivateProjectSettings(this.projectInfo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController appNameCon =
        TextEditingController(text: projectInfo["appname"]);
    TextEditingController descCon =
        TextEditingController(text: projectInfo["description"]);
    return NestedScrollView(
        headerSliverBuilder: (c, b) => [
              const SliverToBoxAdapter(child: MyAppBar("Optionen")),
            ],
        body: Center(
          child: Container(
            constraints: const BoxConstraints(
              maxWidth: 600,
            ),
            padding: const EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Column(
                      children: [
                        TextField(
                            decoration:
                                const InputDecoration(label: Text("App Name")),
                            controller: appNameCon),
                        const SizedBox(height: 20),
                        TextField(
                          maxLines: 5,
                          decoration:
                              const InputDecoration(label: Text("App Idee")),
                          controller: descCon,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  MyBlueButton("Änderungen speichern", onPressed: () {
                    waitDialog(context);
                    FirebaseFirestore.instance
                        .collection("apps")
                        .doc(projectInfo.id)
                        .update({
                      "appname": appNameCon.text,
                      "description": descCon.text
                    }).then((value) {
                      closeDialog(context);
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const MyApp(),
                          transitionsBuilder: (c, a1, a2, w) =>
                              FadeTransition(opacity: a1, child: w),
                        ),
                      );
                      myCustomError(context, "Änderungen wurden gespeichert");
                    }).catchError((e) {
                      closeDialog(context);
                      myCustomError(context, e.toString());
                    });
                  }),
                  const SizedBox(height: 20),
                  const Text(
                    "Weitere Optionen",
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  MyBlueButton("Projekt löschen", onPressed: () {
                    waitDialog(context);
                    FirebaseFirestore.instance
                        .collection("apps")
                        .doc(projectInfo.id)
                        .delete()
                        .then((value) {
                      closeDialog(context);
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const MyApp(),
                          transitionsBuilder: (c, a1, a2, w) =>
                              FadeTransition(opacity: a1, child: w),
                        ),
                      );
                      myCustomError(context, "Projekt wurde gelöscht");
                    }).catchError((e) {
                      closeDialog(context);
                      myCustomError(context, e.toString());
                    });
                  })
                ]),
          ),
        ));
  }
}
