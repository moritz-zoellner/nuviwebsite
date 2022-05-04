import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/main.dart';
import 'package:noviwebsite/styling.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:typed_data';

class CourtOrder extends StatefulWidget {
  const CourtOrder({Key? key}) : super(key: key);

  @override
  State<CourtOrder> createState() => _CourtOrderState();
}

class _CourtOrderState extends State<CourtOrder> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwCon = TextEditingController();
  TextEditingController webLink = TextEditingController();

  TextEditingController clubNameCon = TextEditingController();
  TextEditingController hoursPerWeek = TextEditingController();
  int currentState = 0;

  Uint8List? logoBytes;

  List<TextEditingController> courtControllers = [];

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: ScaffoldMessenger(
                      child: Builder(builder: (context) {
                        return Scaffold(
                            body: SingleChildScrollView(
                                child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Row(
                                          children: [
                                            IconButton(
                                                onPressed: () => currentState ==
                                                        0
                                                    ? Navigator.pop(context)
                                                    : setState(
                                                        () => currentState = 0),
                                                icon: Icon(currentState == 0
                                                    ? Icons.close
                                                    : Icons
                                                        .arrow_back_ios_new_rounded)),
                                            const SizedBox(width: 20),
                                            const Flexible(
                                              child: Text("Courtmanagement",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 30)),
                                            ),
                                          ],
                                        ),
                                        paymentWidget(context)
                                       /* currentState == 0
                                            ? infoWidget(context)
                                            : currentState == 1
                                                ? paymentWidget(context)
                                                : waitWidget(),*/
                                      ],
                                    ))));
                      }),
                    )))));
  }

  Widget infoWidget(context) {
    bool notLoggedIn = FirebaseAuth.instance.currentUser == null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text("Contact information",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        notLoggedIn
            ? Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: const BorderRadius.all(Radius.circular(20))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.all(20),
                        child: TextField(
                          decoration:
                              const InputDecoration(label: Text("Email")),
                          controller: emailCon,
                        )),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: TextField(
                        decoration:
                            const InputDecoration(label: Text("Password")),
                        controller: passwCon,
                      ),
                    )
                  ],
                ),
              )
            : const SizedBox.shrink(),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
              "Um sie bezüglich ihrer Bestellung auf dem Laufenden halten zu können brauchen wir Ihre Kontaktinformationen. Achten sie deswegen auf Korrektheit der Angaben"),
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text("Club information",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              )),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    child: TextButton(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20))))),
                        child: const Text("Ändern"),
                        onPressed: () async {
                          FilePickerResult? result = await FilePicker.platform
                              .pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ["png"]);

                          if (result != null) {
                            Uint8List? fileBytes = result.files.first.bytes;
                            if (result.files.first.size > 5000000) {
                              myCustomError(context, "Maximal 5MB");
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        color: Colors.grey.shade200,
                        image: logoBytes == null
                            ? null
                            : DecorationImage(image: MemoryImage(logoBytes!))),
                  ),
                  const SizedBox(width: 20),
                  Flexible(
                    child: TextField(
                        decoration:
                            const InputDecoration(label: Text("Club name")),
                        controller: clubNameCon),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  decoration: const InputDecoration(
                      label: Text("Link zur Vereinswebsite")),
                  controller: webLink,
                ),
              )
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text(
              "Um die App einzurichten und auf Ihren Verein anzupassen benötigen wir die Angabe Ihres Vereinsnamens und ein Logo, welches wir hinterlegen sollen"),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: TextField(
                  decoration: const InputDecoration(
                      label: Text("Wöchentliche Stunden pro Spieler")),
                  controller: hoursPerWeek,
                ),
              ),
            ],
          ),
        ),
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
            decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: const BorderRadius.all(Radius.circular(20))),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                courtControllers.length + 1,
                (index) => (index == courtControllers.length)
                    ? IconButton(
                        tooltip: "Platz hinzufügen",
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          setState(() {
                            courtControllers.add(TextEditingController());
                          });
                        },
                      )
                    : Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              tooltip: "Platz entfernen",
                              icon: const Icon(Icons.remove_circle_outline,
                                  color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  courtControllers.removeAt(index);
                                });
                              },
                            ),
                            const SizedBox(width: 20),
                            Flexible(
                              child: TextField(
                                  decoration: InputDecoration(
                                      label: Text(
                                          "Platz " + (index + 1).toString())),
                                  controller: courtControllers[index]),
                            ),
                            const SizedBox(width: 20),
                          ],
                        ),
                      ),
              ),
            )),
        const Padding(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 20),
          child: Text(
              "Die Platzbuchung- und Verwaltung kann von Ihnen individuell Angepasst werden. Hier können Sie angeben, wie viele Plätze auf Ihrem Tennisgelände vorhanden sind, und wie diese Bezeichnet werden. Außerdem können Sie darüber entscheiden, wie viele Stunden pro Woche jeder Spiele zur Verfügung haben soll"),
        ),
        MaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: const Text("Proceed to payment",
                style: TextStyle(color: Colors.white)),
            color: Colors.blue,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onPressed: () {
              String validInput;

              validInput = inputControl(
                  clubName: clubNameCon.text,
                  email: (notLoggedIn) ? emailCon.text : null,
                  passw: (notLoggedIn) ? passwCon.text : null,
                  hoursPerWeek: hoursPerWeek.text,
                  allCourts: courtControllers);

              if (validInput == "valid") {
                setState(() => currentState = 1);
              } else {
                myCustomError(context, validInput);
              }
            }),
      ],
    );
  }

  Widget paymentWidget(context) {
    TextEditingController name =  TextEditingController();
    TextEditingController adresse =  TextEditingController();
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Text("Zahlung",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 20),
        TextField(
            controller: name,
            decoration:
                const InputDecoration(label: Text("Name bzw. Firma des Kunden"))),
        const SizedBox(height: 20),

        TextField(
            controller: adresse,
            decoration: const InputDecoration(label: Text("Adresse des Kunden"))),
        const SizedBox(height: 20),

        const Center(child: Text("PayPal will be available soon")),
        const SizedBox(height: 20),
        MaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: const Text("Kostenpflichtig kaufen", style: TextStyle(color: Colors.white)),
            color: Colors.blue,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onPressed: () async {
              waitDialog(context);
              bool notLoggedIn = FirebaseAuth.instance.currentUser == null;

              if (notLoggedIn) {
                //try signIn
                FirebaseAuth.instance
                    .signInWithEmailAndPassword(
                        email: emailCon.text, password: passwCon.text)
                    .catchError((e) {
                  FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: emailCon.text, password: passwCon.text)
                      .catchError((err) {
                    closeDialog(context);
                    myCustomError(context, e.toString().split("]").last.trim());
                    setState(() {
                      currentState = 1;
                    });
                  }).then((value) => doneWithFuture());
                }).then((value) async {
                  if ((await FirebaseFirestore.instance
                              .collection("apps")
                              .where("useremail",
                                  isEqualTo:
                                      FirebaseAuth.instance.currentUser!.email!)
                              .get())
                          .docs
                          .length <
                      5) {
                    doneWithFuture();
                  } else {
                    myCustomError(context, "Zu viele Projekte");
                    closeDialog(context);
                  }
                });
              } else {
                if ((await FirebaseFirestore.instance
                            .collection("apps")
                            .where("useremail",
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.email!)
                            .get())
                        .docs
                        .length <
                    5) {
                  doneWithFuture();
                } else {
                  myCustomError(context, "Zu viele Projekte");
                  closeDialog(context);
                }
              }
            })
      ]),
    );
  }

  void doneWithFuture() {
    List<String> courts = [];

    for (TextEditingController cons in courtControllers) {
      courts.add(cons.text);
    }

    courts.insert(0, "");

    FirebaseFirestore.instance.collection("apps").add({
      "projectfamily": "Tclub",
      "appname": clubNameCon.text,
      "useremail": FirebaseAuth.instance.currentUser!.email,
      "courts": courts,
      "h_per_week": hoursPerWeek.text,
      "abo": "Courtmanagment",
      "description": "Tclub, Courtmanagement",
      "website": webLink.text,
    }).catchError((e, s) {
      closeDialog(context);
      myCustomError(context, e.toString().split("]").last.trim());
      setState(() {
        currentState = 1;
      });
    }).then((value) {
      if (logoBytes == null) {
        closeDialog(context);
        myCustomError(context, "Erfolgreiche Bestellung");
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const MyApp(),
              transitionsBuilder: (c, a1, a2, w) =>
                  FadeTransition(opacity: a1, child: w),
            ));
        return;
      }
      FirebaseStorage.instance
          .ref('uploads')
          .child(value.id)
          .child('logo.png')
          .putData(logoBytes!)
          .catchError((error) {
        closeDialog(context);
        myCustomError(context, "Fehler beim Hochladen des Logos");
      }).then((p0) {
        closeDialog(context);
        myCustomError(context, "Erfolgreiche Bestellung");
        Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) => const MyApp(),
              transitionsBuilder: (c, a1, a2, w) =>
                  FadeTransition(opacity: a1, child: w),
            ));
      });
    });
  }
}
