import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/main.dart';
import 'package:noviwebsite/management/overview.dart';
import 'package:noviwebsite/styling.dart';
import 'package:file_picker/file_picker.dart';

class TclubBothProjectSettings extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> projectInfo;
  const TclubBothProjectSettings(this.projectInfo, {Key? key})
      : super(key: key);

  @override
  State<TclubBothProjectSettings> createState() =>
      _TclubBothProjectSettingsState();
}

class _TclubBothProjectSettingsState extends State<TclubBothProjectSettings> {
  Uint8List? logoBytes;

  @override
  void initState() {
    super.initState();
    FirebaseStorage.instance
        .ref('uploads')
        .child(widget.projectInfo.id)
        .child('logo.png')
        .getData()
        .catchError((e) {
      //   myCustomError(context, e.toString());
    }).then((value) {
      setState(() {
        logoBytes = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController appNameCon =
        TextEditingController(text: widget.projectInfo["appname"]);

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
                            Row(
                              children: [
                                Container(
                                  child: TextButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all(
                                              const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(
                                                              20))))),
                                      child: const Text("Ändern"),
                                      onPressed: () async {
                                        FilePickerResult? result =
                                            await FilePicker.platform.pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: ["png"]);

                                        if (result != null) {
                                          Uint8List? fileBytes =
                                              result.files.first.bytes;
                                          if (result.files.first.size >
                                              5000000) {
                                            myCustomError(
                                                context, "Maximal 5MB");
                                            return;
                                          }
                                          setState(() {
                                            logoBytes = fileBytes;
                                          });
                                        }
                                      }),
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(20)),
                                      color: Colors.grey.shade200,
                                      image: logoBytes == null
                                          ? null
                                          : DecorationImage(
                                              image: MemoryImage(logoBytes!))),
                                ),
                                const SizedBox(width: 20),
                                Flexible(
                                  child: TextField(
                                      decoration: const InputDecoration(
                                          label: Text("App Name")),
                                      controller: appNameCon),
                                ),
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
                      MyBlueButton("Änderungen speichern", onPressed: () {
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
                        }).catchError((e) {
                          closeDialog(context);
                          myCustomError(context, e.toString());
                        }).then((value) {
                          FirebaseStorage.instance
                              .ref('uploads')
                              .child(widget.projectInfo.id)
                              .child('logo.png')
                              .putData(logoBytes!)
                              .catchError((e) {
                            closeDialog(context);
                            myCustomError(context, e.toString());
                          }).then((p0) {
                            closeDialog(context);
                            myCustomError(
                                context, "Änderungen wurden gespeichert");
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
                          });
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
