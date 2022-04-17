import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/main.dart';
import 'package:noviwebsite/styling.dart';

class BothOrder extends StatefulWidget {
  const BothOrder({Key? key}) : super(key: key);

  @override
  State<BothOrder> createState() => _BothOrderState();
}

class _BothOrderState extends State<BothOrder> {
  TextEditingController emailCon = TextEditingController();
  TextEditingController passwCon = TextEditingController();

  TextEditingController phoneCon = TextEditingController();
  TextEditingController clubNameCon = TextEditingController();
  TextEditingController clubLogoCon = TextEditingController();
  TextEditingController allCourts = TextEditingController();
  TextEditingController hoursPerWeek = TextEditingController();
  int currentState = 0;
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
                                            const Text("Court- & Membership management",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30)),
                                          ],
                                        ),
                                        currentState == 0
                                            ? infoWidget()
                                            : currentState == 1
                                                ? paymentWidget()
                                                : const Center(
                                                    child:
                                                        CircularProgressIndicator()),
                                      ],
                                    ))));
                      }),
                    )))));
  }

  Widget infoWidget() {
    bool notLoggedIn = FirebaseAuth.instance.currentUser == null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Padding(
          padding: EdgeInsets.all(20),
          child: Text("Contact information",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: const BorderRadius.all(Radius.circular(20))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              notLoggedIn
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: CupertinoTextField.borderless(
                        placeholder: "Email",
                        controller: emailCon,
                      ),
                    )
                  : const SizedBox.shrink(),
              notLoggedIn
                  ? Padding(
                      padding: const EdgeInsets.all(20),
                      child: CupertinoTextField.borderless(
                        placeholder: "Password",
                        controller: passwCon,
                      ),
                    )
                  : const SizedBox.shrink(),
              Padding(
                padding: const EdgeInsets.all(20),
                child: CupertinoTextField.borderless(
                  placeholder: "Phonenumber",
                  controller: phoneCon,
                ),
              ),
            ],
          ),
        ),
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
          child: (Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20),
                child: CupertinoTextField.borderless(
                  placeholder: "Club name",
                  controller: clubNameCon,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: CupertinoTextField.borderless(
                  placeholder: "Club logo",
                  controller: clubLogoCon,
                ),
              ),
            ],
          )),
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
                child: CupertinoTextField.borderless(
                  placeholder: "Wöchentliche Stunden pro Spieler",
                  controller: hoursPerWeek,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: CupertinoTextField.borderless(
                  placeholder: "Namen der Plätze (\"1,2,3,4,5,6,7,M\")",
                  controller: allCourts,
                ),
              ),
            ],
          ),
        ),
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
              if (clubNameCon.text.isEmpty) return;
              if (passwCon.text.isEmpty && notLoggedIn) return;
              if (emailCon.text.isEmpty && notLoggedIn) return;
              if (phoneCon.text.isEmpty) return;
              if (hoursPerWeek.text.isEmpty) return;
              if (allCourts.text.isEmpty) return;
              if (clubLogoCon.text.isEmpty) return;

              setState(() => currentState = 1);
            }),
      ],
    );
  }

  Widget paymentWidget() =>
      Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        const Padding(
            padding: EdgeInsets.all(20),
            child: Text("Zahlung",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold))),
        const Center(child: Text("PayPal will be available soon")),
        const SizedBox(height: 20),
        MaterialButton(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            child: const Text("Buy now", style: TextStyle(color: Colors.white)),
            color: Colors.blue,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            onPressed: () {
              waitDialog(context);
              bool notLoggedIn = FirebaseAuth.instance.currentUser == null;

              if (notLoggedIn) {
                FirebaseAuth.instance
                    .createUserWithEmailAndPassword(
                        email: emailCon.text, password: passwCon.text)
                    .then((value) => doneWithFuture())
                    .catchError((e, s) {
                  closeDialog(context);
                  myCustomError(context, e.toString().split("]").last.trim());
                  setState(() {
                    currentState = 1;
                  });
                });
              } else {
                doneWithFuture();
              }
            })
      ]);

  void doneWithFuture() {
    FirebaseFirestore.instance.collection("apps").add({
      "projectfamily": "Tclub",
      "appname": clubNameCon.text,
      "useremail": FirebaseAuth.instance.currentUser!.email,
      "logo": clubLogoCon.text,
      "courts": allCourts.text.split(","),
      "h/week": hoursPerWeek.text,
      "phone": phoneCon.text,
      "abo": "Bothmanagment",
      "description": "Tclub, Court- & Membership management",
    }).then((value) {
      closeDialog(context);
      myCustomError(context, "Erfolgreiche Bestellung");
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation1, animation2) => const MyApp(),
          transitionsBuilder: (c, a1, a2, w) =>
              FadeTransition(opacity: a1, child: w),
        ),
      );
    }).catchError((e, s) {
      closeDialog(context);
      myCustomError(context, e.toString().split("]").last.trim());
      setState(() {
        currentState = 1;
      });
    });
  }
}
