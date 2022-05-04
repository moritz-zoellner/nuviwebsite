import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/main.dart';
import 'package:noviwebsite/management/overview.dart';
import 'package:noviwebsite/styling.dart';

class TclubMemberProjectSettings extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> projectInfo;
  const TclubMemberProjectSettings(this.projectInfo, {Key? key})
      : super(key: key);

  @override
  State<TclubMemberProjectSettings> createState() =>
      _TclubMemberProjectSettingsState();
}

class _TclubMemberProjectSettingsState
    extends State<TclubMemberProjectSettings> {
  Uint8List? logoBytes;
  Uint8List? beitragsOrdnung;
  List<List<TextEditingController>> aboControllers = [];
  Map<dynamic, dynamic> aboList = {};
  @override
  void initState() {
    int copyIndex = 0;
    aboList = widget.projectInfo["abos"];
    aboList.forEach((key, value) {
      aboControllers.add([TextEditingController(), TextEditingController()]);
      aboControllers[copyIndex][0].text = key;
      aboControllers[copyIndex][1].text = value;
      copyIndex++;
    });
    super.initState();
    FirebaseStorage.instance
        .ref('uploads')
        .child(widget.projectInfo.id)
        .child('logo.png')
        .getData()
        .catchError((e) {
      // myCustomError(context, e.toString());
    }).then((value) {
      setState(() {
        logoBytes = value;
      });
    });
    FirebaseStorage.instance
        .ref('uploads')
        .child(widget.projectInfo.id)
        .child('beitragsordnung.pdf')
        .getData()
        .catchError((e) {
      //   myCustomError(context, e.toString());
    }).then((value) {
      setState(() {
        beitragsOrdnung = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController appNameCon =
        TextEditingController(text: widget.projectInfo["appname"]);
    TextEditingController webLinkCon =
        TextEditingController(text: widget.projectInfo["website"]);
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
                          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                      child: logoBytes == null
                                          ? const Text("Ändern")
                                          : const SizedBox.shrink(),
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
                              decoration: const InputDecoration(
                                  label: Text("Link zur Vereinswebsite")),
                              controller: webLinkCon,
                            ),
                            const SizedBox(height: 20),
                            const Padding(
                              padding: EdgeInsets.all(20),
                              child: Text("Abos und Preise",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    aboControllers.length + 1,
                                    (index) => (index == aboControllers.length)
                                        ? IconButton(
                                            tooltip: "Abo hinzufügen",
                                            icon: const Icon(
                                                Icons.add_circle_outline),
                                            onPressed: () {
                                              setState(() {
                                                aboControllers.add([
                                                  TextEditingController(),
                                                  TextEditingController()
                                                ]);
                                              });
                                            },
                                          )
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20),
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                IconButton(
                                                  tooltip: "Abo entfernen",
                                                  icon: const Icon(
                                                      Icons
                                                          .remove_circle_outline,
                                                      color: Colors.red),
                                                  onPressed: () {
                                                    setState(() {
                                                      aboControllers
                                                          .removeAt(index);
                                                    });
                                                  },
                                                ),
                                                const SizedBox(width: 20),
                                                Flexible(
                                                  child: TextField(
                                                      decoration:
                                                          const InputDecoration(
                                                              label:
                                                                  Text("Abo")),
                                                      controller:
                                                          aboControllers[index]
                                                              [0]),
                                                ),
                                                const SizedBox(width: 20),
                                                Flexible(
                                                  child: TextField(
                                                      decoration:
                                                          const InputDecoration(
                                                              suffixIcon: Icon(
                                                                  Icons.euro),
                                                              label: Text(
                                                                  "Preis")),
                                                      controller:
                                                          aboControllers[index]
                                                              [1]),
                                                ),
                                                const SizedBox(width: 20),
                                              ],
                                            ),
                                          ),
                                  ),
                                )),
                            const Padding(
                              padding: EdgeInsets.all(20),
                              child: Text("Beitragsordnung",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Container(
                              child: TextButton(
                                  style: ButtonStyle(
                                      shape: MaterialStateProperty.all(
                                          const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20))))),
                                  child: beitragsOrdnung == null
                                      ? const Text("Hochladen")
                                      : const Text(
                                          "Datei hochgeladen. Zum ändern erneut klicken"),
                                  onPressed: () async {
                                    FilePickerResult? result =
                                        await FilePicker.platform.pickFiles(
                                            type: FileType.custom,
                                            allowedExtensions: ["pdf"]);

                                    if (result != null) {
                                      Uint8List? fileBytes =
                                          result.files.first.bytes;
                                      if (result.files.first.size > 5000000) {
                                        myCustomError(context, "Maximal 5MB");
                                        return;
                                      }
                                      setState(() {
                                        beitragsOrdnung = fileBytes;
                                      });
                                    }
                                  }),
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(20)),
                                color: Colors.grey.shade200,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      MyBlueButton("Änderungen speichern", onPressed: () {
                        String validInput = inputControl(
                            clubName: appNameCon.text,
                            aboList: aboControllers,
                            beitragsOrdnung: beitragsOrdnung != null);
                        if (validInput == "valid") {
                          waitDialog(context);
                          Map<String, String> aboMap = {};
                          for (List<TextEditingController> cons
                              in aboControllers) {
                            aboMap.putIfAbsent(
                                cons[0].text, () => cons[1].text);
                          }
                          FirebaseFirestore.instance
                              .collection("apps")
                              .doc(widget.projectInfo.id)
                              .update({
                            "appname": appNameCon.text,
                            "website": webLinkCon.text,
                            "abos": aboMap,
                          }).catchError((e) {
                            closeDialog(context);
                            myCustomError(context, e.toString());
                          }).then((value) {
                            FirebaseStorage.instance
                                .ref('uploads')
                                .child(widget.projectInfo.id)
                                .child('beitragsordnung.pdf')
                                .putData(beitragsOrdnung!)
                                .catchError((e) {
                              closeDialog(context);
                              myCustomError(context, e.toString());
                            }).then((p0) {
                              if (logoBytes == null) {
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
                                    ));
                                return;
                              }
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
                          });
                        } else {
                          myCustomError(context, validInput);
                        }
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
                          FirebaseStorage.instance
                              .ref('uploads')
                              .child(widget.projectInfo.id)
                              .child('beitragsordnung.pdf')
                              .delete()
                              .catchError((error) {
                            closeDialog(context);
                            myCustomError(context,
                                "Fehler beim Löschen der Beitragsordnung");
                          }).then((p0) {
                            if (logoBytes == null) {
                              closeDialog(context);
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
                              myCustomError(context, "Projekt wurde gelöscht");
                              return;
                            }
                            FirebaseStorage.instance
                                .ref('uploads')
                                .child(widget.projectInfo.id)
                                .child('logo.png')
                                .delete()
                                .whenComplete(() {
                              closeDialog(context);
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
                              myCustomError(context, "Projekt wurde gelöscht");
                            });
                          });
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
