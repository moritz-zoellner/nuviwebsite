import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/main.dart';
import 'package:noviwebsite/noviwebsite/management/overview.dart';
import 'package:noviwebsite/styling.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

class TclubCourtProjectSettings extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> projectInfo;
  const TclubCourtProjectSettings(this.projectInfo, {Key? key})
      : super(key: key);

  @override
  State<TclubCourtProjectSettings> createState() =>
      _TclubCourtProjectSettingsState();
}

class _TclubCourtProjectSettingsState extends State<TclubCourtProjectSettings> {
  bool logoDownloaded = true;

  @override
  Widget build(BuildContext context) {
    Uint8List? logoBytes;
    String? filename;
    TextEditingController appNameCon =
        TextEditingController(text: widget.projectInfo["appname"]);
    TextEditingController logoCon =
        TextEditingController(text: widget.projectInfo["logo"]);

    if (logoCon.text == "") {
      logoDownloaded = false;
    }

    List<dynamic> courtsList = widget.projectInfo["courts"];
    courtsList.removeAt(0);
    String courts = courtsList.toString();
    TextEditingController courtsCon = TextEditingController(
        text:
            courts.replaceAll('[', '').replaceAll(']', '').replaceAll(' ', ''));
    TextEditingController hperweekCon =
        TextEditingController(text: widget.projectInfo["h_per_week"]);
    TextEditingController phoneCon =
        TextEditingController(text: widget.projectInfo["phone"]);
    return NestedScrollView(
        headerSliverBuilder: (c, b) => [
              const SliverToBoxAdapter(child: MyAppBar("Optionen")),
            ],
        body: Center(
          child: SingleChildScrollView(
            child: Center(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            TextField(
                                decoration: const InputDecoration(
                                    label: Text("App Name")),
                                controller: appNameCon),
                            const SizedBox(height: 20),
                            Row(
                              children: [
                                Flexible(
                                  child: TextField(
                                    decoration: const InputDecoration(
                                        label: Text("Logo")),
                                    controller: logoCon,
                                  ),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                (logoDownloaded == true)
                                    ? MaterialButton(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 32, vertical: 24),
                                        child: const Text("Logo löschen",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        color: Colors.pink,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        onPressed: () async {
                                          logoBytes = null;
                                          filename = null;
                                          FirebaseFirestore.instance
                                              .collection("apps")
                                              .doc(widget.projectInfo.id)
                                              .update({"logo": ""});
                                          setState(
                                              () => logoDownloaded = false);
                                        })
                                    : MaterialButton(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 32, vertical: 24),
                                        child: const Text("Logo Hochladen",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        color: Colors.pink,
                                        shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        onPressed: () async {
                                          FilePickerResult? result =
                                              await FilePicker.platform
                                                  .pickFiles(
                                                      type: FileType.custom,
                                                      allowedExtensions: [
                                                "pdf",
                                                "jpg",
                                                "png",
                                                "jpeg"
                                              ]);

                                          if (result != null) {
                                            String fileName =
                                                result.files.first.name;
                                            Uint8List? fileBytes =
                                                result.files.first.bytes;
                                            if (result.files.first.size >
                                                5000000) {
                                              myCustomError(
                                                  context, "Maximal 5MB");
                                              return;
                                            }
                                            logoBytes = fileBytes;
                                            filename = fileName;
                                            setState(
                                                () => logoDownloaded = true);
                                          }
                                        }),
                              ],
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              decoration:
                                  const InputDecoration(label: Text("Courts")),
                              controller: courtsCon,
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              decoration: const InputDecoration(
                                  label: Text("Stunden Pro Woche")),
                              controller: hperweekCon,
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              decoration: const InputDecoration(
                                  label: Text("Kontaktnummer")),
                              controller: phoneCon,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      MyBlueButton(
                        "Änderungen speichern",
                        onPressed: () {
                          waitDialog(context);
                          List<String> list = courtsCon.text.split(",");
                          list.insert(0, "");
                          FirebaseFirestore.instance
                              .collection("apps")
                              .doc(widget.projectInfo.id)
                              .update({
                            "appname": appNameCon.text,
                            "courts": list,
                            "h_per_week": hperweekCon.text,
                            "phone": phoneCon.text,
                          }).then((value) {
                            closeDialog(context);
                            FirebaseStorage.instance
                                .ref(
                                    'uploads/${widget.projectInfo.id}/$filename')
                                .putData(logoBytes!)
                                .catchError((error) {
                              closeDialog(context);

                              myCustomError(
                                  context, "Fehler beim Hochladen des Logos");
                            }).then((p0) {
                              closeDialog(context);
                              p0.ref.getDownloadURL().catchError((e) {
                                myCustomError(
                                    context, "Kann das Logo nicht finden");
                              }).then((logoRef) {
                                FirebaseFirestore.instance
                                    .collection("apps")
                                    .doc(widget.projectInfo.id)
                                    .update({"logo": logoRef}).catchError((e) {
                                  myCustomError(context,
                                      "Update von Firestore hat nicht funktioniert");
                                }).then((value) {
                                  myCustomError(
                                      context, "Erfolgreiche Bestellung");

                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              const MyApp(),
                                      transitionsBuilder: (c, a1, a2, w) =>
                                          FadeTransition(opacity: a1, child: w),
                                    ),
                                  );
                                  myCustomError(
                                      context, "Änderungen wurden gespeichert");
                                }).catchError((e) {
                                  closeDialog(context);
                                  myCustomError(context, e.toString());
                                });
                              });
                            });
                          });
                        },
                      ),
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
                            .doc(widget.projectInfo.id)
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
            ),
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
    TextEditingController logoCon =
        TextEditingController(text: projectInfo["logo"]);
    TextEditingController phoneCon =
        TextEditingController(text: projectInfo["phone"]);
    return NestedScrollView(
        headerSliverBuilder: (c, b) => [
              const SliverToBoxAdapter(child: MyAppBar("Optionen")),
            ],
        body: Center(
          child: SingleChildScrollView(
            child: Center(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            TextField(
                                decoration: const InputDecoration(
                                    label: Text("App Name")),
                                controller: appNameCon),
                            const SizedBox(height: 20),
                            TextField(
                              decoration:
                                  const InputDecoration(label: Text("Logo")),
                              controller: logoCon,
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              decoration: const InputDecoration(
                                  label: Text("Kontaktnummer")),
                              controller: phoneCon,
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
                          "logo": logoCon.text,
                          "phone": phoneCon.text,
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
                          myCustomError(
                              context, "Änderungen wurden gespeichert");
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
            ),
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
    TextEditingController logoCon =
        TextEditingController(text: projectInfo["logo"]);

    List<dynamic> courtsList = projectInfo["courts"];
    courtsList.removeAt(0);
    String courts = courtsList.toString();
    TextEditingController courtsCon = TextEditingController(
        text:
            courts.replaceAll('[', '').replaceAll(']', '').replaceAll(' ', ''));
    TextEditingController hperweekCon =
        TextEditingController(text: projectInfo["h_per_week"]);
    TextEditingController phoneCon =
        TextEditingController(text: projectInfo["phone"]);
    return NestedScrollView(
        headerSliverBuilder: (c, b) => [
              const SliverToBoxAdapter(child: MyAppBar("Optionen")),
            ],
        body: Center(
          child: SingleChildScrollView(
            child: Center(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            TextField(
                                decoration: const InputDecoration(
                                    label: Text("App Name")),
                                controller: appNameCon),
                            const SizedBox(height: 20),
                            TextField(
                              decoration:
                                  const InputDecoration(label: Text("Logo")),
                              controller: logoCon,
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              decoration:
                                  const InputDecoration(label: Text("Courts")),
                              controller: courtsCon,
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              decoration: const InputDecoration(
                                  label: Text("Stunden Pro Woche")),
                              controller: hperweekCon,
                            ),
                            const SizedBox(height: 20),
                            TextField(
                              decoration: const InputDecoration(
                                  label: Text("Kontaktnummer")),
                              controller: phoneCon,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      MyBlueButton("Änderungen speichern", onPressed: () {
                        waitDialog(context);
                        List<String> list = courtsCon.text.split(",");
                        list.insert(0, "");
                        FirebaseFirestore.instance
                            .collection("apps")
                            .doc(projectInfo.id)
                            .update({
                          "appname": appNameCon.text,
                          "logo": logoCon.text,
                          "courts": list,
                          "h_per_week": hperweekCon.text,
                          "phone": phoneCon.text,
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
                          myCustomError(
                              context, "Änderungen wurden gespeichert");
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
            ),
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
          child: SingleChildScrollView(
            child: Center(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        child: Column(
                          children: [
                            TextField(
                                decoration: const InputDecoration(
                                    label: Text("App Name")),
                                controller: appNameCon),
                            const SizedBox(height: 20),
                            TextField(
                              maxLines: 5,
                              decoration: const InputDecoration(
                                  label: Text("App Idee")),
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
                          myCustomError(
                              context, "Änderungen wurden gespeichert");
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
            ),
          ),
        ));
  }
}
