import 'package:flutter/cupertino.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Novi Website',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(slivers: [
      CupertinoSliverNavigationBar(
          largeTitle: const Text("Novi Corp"),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: const Text("Anmelden"),
            onPressed: () => Navigator.push(context,
                CupertinoPageRoute(builder: ((context) => LoginScreen()))),
          )),
      SliverList(
        delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
            child: Text(
              "Tclub",
              style:
                  CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 32, left: 64, right: 64),
            child: Text(
              "Tclub ist eine App für Tennisclubs, welche die Verwaltung von Plätzen und Mitgliedern übernimmt. Dadurch werden viele Vorgänge sowohl für Spieler als auch für Organisatoren drastisch vereinfacht. Tclub ist DER Schritt in Richtung Digitalisierung für Tennisclubs. Einfach. Innovativ. Günstig. Die zentralisierte Verwaltung von Benutzerdaten ermöglicht einen sicheren und zuverlässigen Umgang und ermöglicht auch anstrebenden Tennisspielern einen komfortablen und schnellen Einstieg in den ersten Club.",
              style: CupertinoTheme.of(context).textTheme.textStyle,
            ),
          ),
        ]),
      ),
      SliverPadding(
        padding: const EdgeInsets.all(16),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 500, mainAxisExtent: 500),
          delegate: SliverChildListDelegate([
            Tile("Plätzeverwaltung", const CourtPrice(), CupertinoIcons.person,
                CourtDescription(), () {}),
            Tile("Mitgliederverwaltung", const MemberPrice(),
                CupertinoIcons.person, const MemberDescription(), () {}),
            Tile("Plätze- & Mitgliederverwaltung", const BothPrice(),
                CupertinoIcons.person, const BothDescription(), () {}),
          ]),
        ),
      ),
    ]));
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(slivers: [
      const CupertinoSliverNavigationBar(
        largeTitle: Text("Novi Corp"),
      ),
      SliverList(
          delegate: SliverChildListDelegate([
        const Text("Hallo"),
      ]))
    ]);
  }
}

class Tile extends StatelessWidget {
  final String name;
  final Widget price;
  final IconData data;
  final Widget content;
  final void Function() onOrder;
  const Tile(this.name, this.price, this.data, this.content, this.onOrder,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: CupertinoColors.systemGrey6),
      child: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                  ),
                  content,
                ],
              ),
            ),
          ),
        ),
        Row(children: [
          const SizedBox(width: 16),
          price,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.bottomRight,
                child: CupertinoButton.filled(
                  padding: const EdgeInsets.all(16),
                  child: const Text("Jetzt kaufen"),
                  onPressed: () => Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (context) => const LoginScreen())),
                ),
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}

class CourtPrice extends StatelessWidget {
  const CourtPrice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "7",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Column(
          children: const [
            Text(
              "€ / Platz",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "/ Monat",
              style: TextStyle(fontSize: 15),
            )
          ],
        )
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
        const Text(
          "40",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "€",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "/ Monat",
              style: TextStyle(fontSize: 15),
            )
          ],
        )
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
        const Text(
          "30",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "€",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "/ Monat",
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
        const SizedBox(width: 16),
        const Icon(CupertinoIcons.add),
        const SizedBox(width: 16),
        const Text(
          "5",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Column(
          children: const [
            Text(
              "€ / Platz",
              style: TextStyle(fontSize: 15),
            ),
            Text(
              "/ Monat",
              style: TextStyle(fontSize: 15),
            )
          ],
        )
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
                "Abbuchung der Mitgliedsbeiträge per Lastschriftverfahren wird gewährleistet"),
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
