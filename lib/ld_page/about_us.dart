import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 400),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 40),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Expanded(child: AboutNoviDescription()),
                          SizedBox(width: 40),
                          Expanded(child: OurHistoryDescription())
                        ])),
                const Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Unser Team",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.white)),
                ),
                Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 8, bottom: 8),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AboutUsTile("Moritz Zöllner", CupertinoIcons.person,
                              MoritzDescription()),
                          AboutUsTile("Vadime Novikau", CupertinoIcons.person,
                              VadimeDescription()),
                          AboutUsTile("Denis Novikau", CupertinoIcons.person,
                              DenisDescription()),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AboutNoviDescription extends StatelessWidget {
  const AboutNoviDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Über Novi",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white)),
          SizedBox(height: 20),
          Text(
              """Novi ist ein kleines privates Unternehmen, welches sich im Bereich Softwareentwicklung für den Consumer-Markt spezialisiert hat.\n\nUnser Ziel ist es für Privatpersonen, Kleinunternehmer aber auch Vereine und kleine Verbände digitale Lösungen anzubieten, um dessen geschäftlichen Anforderungen zu befriedigen und dessen Tätigkeiten zu vereinfachen und zu automatisieren.\n\nUnsere Motivation ist es die Digitalisierung in allen Bereichen der Gesellschaft voranzubringen ohne jegliche finanziellen oder rechtlichen Hürden, wodurch unsere Produkte kostengünstig und mit größter Sicherheit und Sorgfalt für den Kunden gefertigt sind.\n\n\nIhr Erfolg ist unser Ziel 
und Ihr erreichtes Ziel ist unser Erfolg.
""",
              style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(height: 20),
        ]);
  }
}

class OurHistoryDescription extends StatelessWidget {
  const OurHistoryDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Unsere Geschichte",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white)),
          SizedBox(height: 20),
          Text(
              "Novi begann im Jahr 2021 als ein gemeinnütziges Projekt mit dem Erfurter TC Rot-Weiß e.V. Der Grund dafür war der hohe Bedarf an einer Reduzierung des organisatorischen und verwaltungstechnischen Aufwands des Tennisclubs. Es musste also ein „Tool“ entwickelt werden, welches alle Belange eines Tennisclubs erfüllen soll.\n\nDie Lösung kam 2022 mit einer für den Erfurter Rot-Weiß optimierten App, namens „Rot-Weiß-App“, die auf allen Geräten und Plattformen Lauffähig ist. Der Entwickler Hundesohn Vadime Novikau erkannte schnell das Potenzial dieser App und weitete das Konzept für alle Tennisvereine aus.\n\nDies mündete 2022 mit der Unternehmensgründung von der Novi UG (Haftungsbeschränkt). Heute ist Novi nicht nur für den Tennisbereich aktiv, sondern übernimmt alle möglichen Software-Solutions in der App-Developement-Welt.",
              style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(height: 20),
        ]);
  }
}

class AboutUsTile extends StatelessWidget {
  final String name;
  final IconData data;
  final Widget content;
  const AboutUsTile(this.name, this.data, this.content, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(minWidth: 300, maxWidth: 300),
          child: Container(
            padding: const EdgeInsets.all(16),
            child: ClipRRect(
              child: Image.asset('assets/novi_logo.jpeg'),
              borderRadius: const BorderRadius.all(Radius.circular(50)),
            ),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 440, maxWidth: 400),
          child: Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              //color: CupertinoColors.systemGroupedBackground
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    textAlign: TextAlign.center,
                    style:
                        CupertinoTheme.of(context).textTheme.navTitleTextStyle),
                const SizedBox(height: 16),
                content,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MoritzDescription extends StatelessWidget {
  MoritzDescription({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(children: const [
          Flexible(
            child: Text(
                "Mies korrekter Typ. In Mathe ne Maschine. Mittlerweile auch genug Erfahrung in Flutter um App-Developement effektiv und erfolgreich umzusetzen."),
          ),
        ]),
      ],
    );
  }
}

class VadimeDescription extends StatelessWidget {
  VadimeDescription({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(children: const [
          Flexible(
            child: Text(
                "Jungfrau. 18 Jahre alt. Ist Alkohol- und Nikotinsüchtig und konsumiert viele weitere Drogen. Aber sonst sehr schlauer, chilliger Typ. Absolutes Programmier-Baron."),
          ),
        ]),
      ],
    );
  }
}

class DenisDescription extends StatelessWidget {
  DenisDescription({Key? key}) : super(key: key);
  TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(children: const [
          Flexible(
            child: Text(
                "Sexy Boy halt. Hat ein riesen Coq. Macht sogar Lesben straight. Ansonsten auch genug Erfahrung in Programmierung."),
          ),
        ]),
      ],
    );
  }
}
