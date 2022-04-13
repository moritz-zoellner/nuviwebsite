import 'package:flutter/cupertino.dart';

class CourtPrice extends StatelessWidget {
  const CourtPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("7 ",
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle),
        const Text("€ / Platz\n/ Monat")
      ],
    );
  }
}

class MemberPrice extends StatelessWidget {
  const MemberPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("40 ",
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle),
        const Text("€\n/ Monat"),
      ],
    );
  }
}

class BothPrice extends StatelessWidget {
  const BothPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text("40 ",
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle),
        const Text("€\n/ Monat"),
        Text(" + 5 ",
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle),
        const Text("€ / Platz\n/ Monat")
      ],
    );
  }
}

class CourtDescription extends StatelessWidget {
  CourtDescription({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(children: const [
          Flexible(
            child: Text(
                "Plätzeverwaltung war noch nie so einach - wir kümmern uns um:"),
          ),
        ]),
        const SizedBox(height: 16),
        Row(children: const [
          Icon(CupertinoIcons.check_mark, color: CupertinoColors.activeGreen),
          SizedBox(width: 16),
          Flexible(
            child: Text(
                "Mitglieder können jederzeit Platzbuchungen vornehmen und diese bei Bedarf wieder stonieren"),
          )
        ]),
        const SizedBox(height: 16),
        Row(children: const [
          Icon(CupertinoIcons.check_mark, color: CupertinoColors.activeGreen),
          SizedBox(width: 16),
          Flexible(
            child: Text(
                "Wochenstunden von Mitgliedern werden von uns überwacht und verwaltet"),
          )
        ]),
        const SizedBox(height: 16),
        Row(children: const [
          Icon(CupertinoIcons.check_mark, color: CupertinoColors.activeGreen),
          SizedBox(width: 16),
          Flexible(
              child: Text(
                  "Die AdminApp ermöglicht dem Verein die individuelle Verwaltung von Benutzerdaten und uneingeschränkten Zugriff auf alle Plätze"))
        ]),
      ],
    );
  }
}

class MemberDescription extends StatelessWidget {
  const MemberDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(children: const [
          Flexible(
            child:
                Text("Mitgliederverwaltung simpler denn je - das bieten wir:"),
          ),
        ]),
        const SizedBox(height: 16),
        Row(children: const [
          Icon(CupertinoIcons.check_mark, color: CupertinoColors.activeGreen),
          SizedBox(width: 16),
          Flexible(
            child: Text(
                "Praktischer Aufnahmeantrag von überall für neue Mitglieder, Registrierung und Anmeldung für bestehende Mitglieder"),
          )
        ]),
        const SizedBox(height: 16),
        Row(children: const [
          Icon(CupertinoIcons.check_mark, color: CupertinoColors.activeGreen),
          SizedBox(width: 16),
          Flexible(
            child: Text(
                "Komfortable Bearbeitung der eigenen Daten für die Mitglieder mit nur wenigen Klicks"),
          )
        ]),
        const SizedBox(height: 16),
        Row(children: const [
          Icon(CupertinoIcons.check_mark, color: CupertinoColors.activeGreen),
          SizedBox(width: 16),
          Flexible(
            child: Text(
                "Abbuchung der Mitgliedsbeiträge per Lastschriftverfahren"),
          )
        ]),
        const SizedBox(height: 16),
        Row(children: const [
          Icon(CupertinoIcons.check_mark, color: CupertinoColors.activeGreen),
          SizedBox(width: 16),
          Flexible(
              child: Text(
                  "Übersicht und Zugriff auf angegebene Daten aller Mitglieder in der AdminApp"))
        ]),
      ],
    );
  }
}

class BothDescription extends StatelessWidget {
  const BothDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(children: const [
          Flexible(
            child:
                Text("Bessere Verwaltung geht nicht - beide Vorteile vereint:"),
          ),
        ]),
        const SizedBox(height: 16),
        Row(children: const [
          Icon(CupertinoIcons.check_mark, color: CupertinoColors.activeGreen),
          SizedBox(width: 16),
          Flexible(
            child: Text(
                "Mitglieder und Admins können Funktionen der Plätze- und der Mitgliederverwaltung nutzen ..."),
          )
        ]),
        const SizedBox(height: 16),
        Row(children: const [
          Icon(CupertinoIcons.check_mark, color: CupertinoColors.activeGreen),
          SizedBox(width: 16),
          Flexible(child: Text("... trotzdem ist alles in einer App vereint"))
        ]),
        SizedBox(height: 16),
        Row(children: const [
          Icon(CupertinoIcons.check_mark, color: CupertinoColors.activeGreen),
          SizedBox(width: 16),
          Flexible(
            child: Text(
                "Upgrade von Teilverwaltung auf das volle Paket jederzeit Problemlos möglich"),
          )
        ]),
      ],
    );
  }
}
