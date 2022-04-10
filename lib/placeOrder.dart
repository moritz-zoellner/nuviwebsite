import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:noviwebsite/main.dart';
import 'package:noviwebsite/signIn.dart';

class CourtOrder extends StatefulWidget {
  const CourtOrder({Key? key}) : super(key: key);

  @override
  State<CourtOrder> createState() => _CourtOrderState();
}

class _CourtOrderState extends State<CourtOrder> {
  TextEditingController clubName = TextEditingController();
  TextEditingController numberCourts = TextEditingController();
  TextEditingController allCourts = TextEditingController();
  TextEditingController logo = TextEditingController();
  TextEditingController hoursPerWeek = TextEditingController();

  TextEditingController contactMail = TextEditingController();
  TextEditingController contactNumber = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(
      slivers: [
        const CupertinoSliverNavigationBar(
          largeTitle: Text("Plätzeverwaltung - Bestellung"),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Kontaktinformationen",
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .navLargeTitleTextStyle),
                    CupertinoButton(
                        child: const Icon(CupertinoIcons.info_circle),
                        onPressed: () => showMyCupDialog(
                            context,
                            "Um sie bezüglich ihrer Bestellung auf dem Laufenden halten zu können brauchen wir Ihre Kontaktinformationen. Achten sie deswegen auf Korrektheit der Angaben",
                            "Kontakinformationen"))
                  ],
                ),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 32, left: 32, right: 32),
                    child: NoviTile(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: CupertinoTextField.borderless(
                              placeholder: "Email",
                              controller: contactMail,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: CupertinoTextField.borderless(
                              placeholder: "Telefonnummer",
                              controller: contactNumber,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Vereinsdaten",
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .navLargeTitleTextStyle),
                    CupertinoButton(
                        child: const Icon(CupertinoIcons.info_circle),
                        onPressed: () => showMyCupDialog(
                            context,
                            "Um die App einzurichten und auf Ihren Verein anzupassen benötigen wir die Angabe Ihres Vereinsnamens und ein Logo, welches wir hinterlegen sollen",
                            "Vereinsdaten"))
                  ],
                ),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 32, left: 32, right: 32),
                    child: NoviTile(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: CupertinoTextField.borderless(
                              placeholder: "Vereinsname",
                              controller: clubName,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: CupertinoTextField.borderless(
                              placeholder: "Vereinslogo",
                              controller: logo,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 32),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Individualisierung der Platzbuchung",
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .navLargeTitleTextStyle),
                    CupertinoButton(
                        child: Icon(CupertinoIcons.info_circle),
                        onPressed: () => showMyCupDialog(
                            context,
                            "Die Platzbuchung- und Verwaltung kann von Ihnen individuell Angepasst werden. Hier können Sie angeben, wie viele Plätze auf Ihrem Tennisgelände vorhanden sind, und wie diese Bezeichnet werden. Außerdem können Sie darüber entscheiden, wie viele Stunden pro Woche jeder Spiele zur Verfügung haben soll",
                            "Individualisierung der Platzbuchung"))
                  ],
                ),
              ),
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 32, left: 32, right: 32),
                    child: NoviTile(
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: CupertinoTextField.borderless(
                              placeholder: "Anzahl an Plätzen",
                              controller: numberCourts,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: CupertinoTextField.borderless(
                              placeholder: "Wöchentliche Stunden pro Spieler",
                              controller: hoursPerWeek,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: CupertinoTextField.borderless(
                              placeholder:
                                  "Namen der Plätze (\"1,2,3,4,5,6,7,M\")",
                              controller: allCourts,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 84, bottom: 64),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 740),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CupertinoButton.filled(
                            child: const Text("Weitere Informationen"),
                            onPressed: () => {}),
                        CupertinoButton.filled(
                            child: const Text("Weiter zur Zahlung "),
                            onPressed: () {
                              if (clubName.text.isEmpty) {
                                return;
                              }
                              Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                      builder: (context) => paymentScreen(
                                          50,
                                          allCourts.text,
                                          clubName.text,
                                          hoursPerWeek.text,
                                          logo.text,
                                          contactMail.text,
                                          contactNumber.text,
                                          "Plätzeverwaltung")));
                            })
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
}

class MemberOrder extends StatefulWidget {
  const MemberOrder({Key? key}) : super(key: key);

  @override
  State<MemberOrder> createState() => _MemberOrderState();
}

class _MemberOrderState extends State<MemberOrder> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class BothOrder extends StatefulWidget {
  const BothOrder({Key? key}) : super(key: key);

  @override
  State<BothOrder> createState() => _BothOrderState();
}

class _BothOrderState extends State<BothOrder> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class paymentScreen extends StatefulWidget {
  final int kosten;
  final String clubName;
  final String hoursPerWeek;
  final String mail;
  final String phoneNumber;
  final String allCourts;
  final String logo;
  final String abo;
  const paymentScreen(int this.kosten, this.allCourts, this.clubName,
      this.hoursPerWeek, this.logo, this.mail, this.phoneNumber, this.abo,
      {Key? key})
      : super(key: key);

  @override
  State<paymentScreen> createState() => _paymentScreenState();
}

class _paymentScreenState extends State<paymentScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text("Zahlung"),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(64),
                        child: Center(
                            child: Text("Zahlungsart auswählen:",
                                style: TextStyle(
                                  fontSize: 25,
                                ))),
                      ),
                      Padding(
                        padding: EdgeInsets.all(64),
                        child: CupertinoButton.filled(
                            child: const Text("PayPal",
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                            onPressed: () => {}),
                      ),
                      Padding(
                        padding: EdgeInsets.all(64),
                        child: CupertinoButton.filled(
                            child: const Text("Kreditkarte",
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                            onPressed: () => {}),
                      ),
                      Padding(
                        padding: EdgeInsets.all(64),
                        child: CupertinoButton.filled(
                            child: const Text("Rechnung",
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                            onPressed: () => {}),
                      ),
                      Padding(
                        padding: EdgeInsets.all(64),
                        child: CupertinoButton.filled(
                            child: const Text("Sofortüberweisung (Klarna)",
                                style: TextStyle(
                                  fontSize: 20,
                                )),
                            onPressed: () => {}),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(64),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CupertinoButton.filled(
                                  child:
                                      const Text("Kostenpflichtig bestellen"),
                                  onPressed: () {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (_) => FinalOrderScreen(
                                                createClub(
                                                    widget.clubName,
                                                    widget.logo,
                                                    widget.allCourts,
                                                    widget.hoursPerWeek,
                                                    widget.mail,
                                                    widget.phoneNumber,
                                                    widget.abo))),
                                        ((route) => false));
                                  }),
                            ]),
                      )
                    ],
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}

String createClub(clubName, logo, courtArray, hoursPerWeek, mail, phone, abo) {
  String res = "Erfolgreiche Bestellung";
  FirebaseFirestore.instance.collection("clubs").doc(clubName).set({
    "user-Email": FirebaseAuth.instance.currentUser!.email,
    "logo": logo,
    "Plätze": courtArray,
    "Stunden pro Woche": hoursPerWeek,
    "Email": mail,
    "Telefon": phone,
    "abo": abo
  }).then((value) {
    // er hat alles geschaft
  }).catchError((onError) {
    // catch all errors
    res = onError.toString().split("]").last;
  });
  return res;
}

class FinalOrderScreen extends StatelessWidget {
  final String success;
  const FinalOrderScreen(this.success, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Center(
          child: Icon(
            CupertinoIcons.check_mark_circled,
            size: 200,
            color: CupertinoColors.systemGreen,
          ),
        ),
        Center(child: Text(success)),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: CupertinoButton.filled(
                child: const Text("Zurück zur Website"),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      CupertinoPageRoute(builder: (_) => const MyHome()),
                      (route) => false);
                }),
          ),
        )
      ],
    ));
  }
}

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

void showMyCupDialog(context, content, header) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(header),
          content: Text(content),
          actions: <Widget>[
            CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'))
          ],
        );
      });
}
