import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/main.dart';
import 'package:noviwebsite/management/overview.dart';
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
  Uint8List? logoBytes;
  Uint8List? beitragsOrdnung;
  List<TextEditingController> courtControllers = [];
  List<dynamic> courtsList = [];
  @override
  void initState() {
    courtsList = widget.projectInfo["courts"];
    courtsList.removeAt(0);
    for (int i = 0; i < courtsList.length; i++) {
      var courts = courtsList[i];
      courtControllers.add(TextEditingController());
      courtControllers[i].text = courts;
    }
    super.initState();
    FirebaseStorage.instance
        .ref('uploads')
        .child(widget.projectInfo.id)
        .child('logo.png')
        .getData()
        .catchError((e) {
      //myCustomError(context, e.toString());
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
    TextEditingController hperweekCon =
        TextEditingController(text: widget.projectInfo["h_per_week"]);
    return NestedScrollView(
        headerSliverBuilder: (c, b) =>
            [const SliverToBoxAdapter(child: MyAppBar("Optionen"))],
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
                              child: Text("Plätze",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  )),
                            ),
                            Container(
                                padding: const EdgeInsets.all(20),
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(20))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: List.generate(
                                    courtControllers.length + 1,
                                    (index) => (index ==
                                            courtControllers.length)
                                        ? IconButton(
                                            tooltip: "Platz hinzufügen",
                                            icon: const Icon(
                                                Icons.add_circle_outline),
                                            onPressed: () {
                                              setState(() {
                                                courtControllers.add(
                                                    TextEditingController());
                                                courtsList.add("");
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
                                                  tooltip: "Platz entfernen",
                                                  icon: const Icon(
                                                      Icons
                                                          .remove_circle_outline,
                                                      color: Colors.red),
                                                  onPressed: () {
                                                    setState(() {
                                                      courtControllers
                                                          .removeAt(index);
                                                    });
                                                  },
                                                ),
                                                const SizedBox(width: 20),
                                                Flexible(
                                                  child: TextField(
                                                      decoration: InputDecoration(
                                                          label: Text("Platz " +
                                                              (index + 1)
                                                                  .toString())),
                                                      controller:
                                                          courtControllers[
                                                              index]),
                                                ),
                                                const SizedBox(width: 20),
                                              ],
                                            ),
                                          ),
                                  ),
                                )),
                            const SizedBox(height: 20),
                            TextField(
                              decoration: const InputDecoration(
                                  label: Text("Stunden Pro Woche")),
                              controller: hperweekCon,
                            ),
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
                      MyBlueButton(
                        "Änderungen speichern",
                        onPressed: () {
                          String validInput = inputControl(
                              clubName: appNameCon.text,
                              hoursPerWeek: hperweekCon.text,
                              allCourts: courtControllers,
                              beitragsOrdnung: beitragsOrdnung != null);
                          if (validInput == "valid") {
                            waitDialog(context);
                            List<String> courts = [];

                            for (TextEditingController cons
                                in courtControllers) {
                              courts.add(cons.text);
                            }
                            courts.insert(0, "");
                            FirebaseFirestore.instance
                                .collection("apps")
                                .doc(widget.projectInfo.id)
                                .update({
                              "appname": appNameCon.text,
                              "courts": courts,
                              "h_per_week": hperweekCon.text,
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
                                            FadeTransition(
                                                opacity: a1, child: w),
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
