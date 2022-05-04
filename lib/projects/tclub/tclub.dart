import 'package:flutter/material.dart';
import 'package:noviwebsite/projects/tclub/bothOrder.dart';
import 'package:noviwebsite/projects/tclub/courtOrder.dart';
import 'package:noviwebsite/projects/tclub/membershipOrder.dart';
import 'package:noviwebsite/styling.dart';

class TClub extends StatelessWidget {
  const TClub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 20),
        OverflowBar(
          children: const [
            Text("Unsere Lösung",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 24)),
            SizedBox(width: 20),
/*            IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.help_outline_rounded,
                color: Colors.white,
              ),
              tooltip: "Beraten lassen!")*/
          ],
        ),
        const SizedBox(height: 20),
        LayoutBuilder(builder: (context, constraints) {
          List<Widget> widgets = [
            Tile(
                "Plätzeverwaltung",
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("7 ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20)),
                    Text("€ / Platz\n/ Monat"),
                  ],
                ),
                "Plätzeverwaltung war noch nie so einach - wir kümmern uns um:",
                Icons.person,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    ProjectCheckMark(
                        "Mitglieder können jederzeit Platzbuchungen vornehmen und diese bei Bedarf wieder stonieren"),
                    ProjectCheckMark(
                        "Wochenstunden von Mitgliedern werden von uns überwacht und verwaltet"),
                    ProjectCheckMark(
                        "Die AdminApp ermöglicht dem Verein die individuelle Verwaltung von Benutzerdaten und uneingeschränkten Zugriff auf alle Plätze"),
                  ],
                ), () {
              showGeneralDialog(
                  context: context,
                  pageBuilder: (c, a1, a2) => const CourtOrder());
            }),
            const SizedBox(height: 20, width: 20),
            Tile(
                "Mitgliederverwaltung",
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("40 ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20)),
                    Text("€ \n/ Monat")
                  ],
                ),
                "Mitgliederverwaltung simpler denn je - das bieten wir:",
                Icons.person,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    ProjectCheckMark(
                        "Praktischer Aufnahmeantrag von überall für neue Mitglieder, Registrierung und Anmeldung für bestehende Mitglieder"),
                    ProjectCheckMark(
                        "Komfortable Bearbeitung der eigenen Daten für die Mitglieder mit nur wenigen Klicks"),
                    ProjectCheckMark(
                        "Abbuchung der Mitgliedsbeiträge per Lastschriftverfahren"),
                    ProjectCheckMark(
                        "Übersicht und Zugriff auf angegebene Daten aller Mitglieder in der AdminApp")
                  ],
                ), () {
              showGeneralDialog(
                  context: context,
                  pageBuilder: (c, a1, a2) => const MembershipOrder());
            }),
            const SizedBox(height: 20, width: 20),
            Tile(
                "Plätze- & Mitgliederverwaltung",
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text("40 ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20)),
                    Text("€\n/ Monat"),
                    Text(" + 5 ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20)),
                    Text("€ / Platz\n/ Monat"),
                  ],
                ),
                "Bessere Verwaltung geht nicht - beide Vorteile vereint:",
                Icons.person,
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: const [
                    ProjectCheckMark(
                        "Mitglieder und Admins können Funktionen der Plätze- und der Mitgliederverwaltung nutzen ..."),
                    SizedBox(height: 16),
                    ProjectCheckMark(
                        "... trotzdem ist alles in einer App vereint"),
                    ProjectCheckMark(
                        "Upgrade von Teilverwaltung auf das volle Paket jederzeit Problemlos möglich"),
                  ],
                ), () {
              showGeneralDialog(
                  context: context,
                  pageBuilder: (c, a1, a2) => const BothOrder());
            })
          ];
          if (constraints.maxWidth < 800) {
            return Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: widgets);
          }
          return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: widgets);
        }),
        const SizedBox(height: 20)
      ],
    );
  }
}

class Tile extends StatelessWidget {
  final String name;
  final Widget price;
  final String slogan;
  final IconData data;
  final Widget content;
  final void Function() onOrder;

  const Tile(
      this.name, this.price, this.slogan, this.data, this.content, this.onOrder,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(name,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 20)),
        const SizedBox(height: 20),
        price,
        const SizedBox(height: 20),
        SizedBox(
          height: 40,
          child: Text(slogan,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Colors.white, fontSize: 16)),
        ),
        const SizedBox(height: 20),
        Container(
            constraints: const BoxConstraints(minHeight: 240),
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.white60),
            child: content),
        const SizedBox(height: 16),
        MaterialButton(
            color: Colors.blue,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: const Text("Jetzt bestellen",
                style: TextStyle(color: Colors.white)),
            onPressed: onOrder)
      ],
    ));
  }
}
