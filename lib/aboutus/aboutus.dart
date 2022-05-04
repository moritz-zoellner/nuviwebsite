import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: LayoutBuilder(builder: (context, constraints) {
          if (constraints.maxWidth < 800) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  AboutNovi(),
                  SizedBox(height: 40),
                  History(),
                  SizedBox(height: 40),
                  Team(),
                ]);
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Expanded(child: AboutNovi()),
              SizedBox(width: 40),
              Expanded(child: History()),
              SizedBox(width: 40),
              Expanded(child: Team()),
            ],
          );
        }),
      ),
    );
  }
}

class AboutNovi extends StatelessWidget {
  const AboutNovi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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
        ]);
  }
}

class History extends StatelessWidget {
  const History({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
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

class Team extends StatelessWidget {
  const Team({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Text("Team",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                color: Colors.white)),
        SizedBox(height: 20),
        Center(
          child: CircleAvatar(
              foregroundImage: AssetImage('assets/denis_bild.jpeg'),
              radius: 100),
        ),
        SizedBox(height: 20),
        Text("Denis Novikau",
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16)),
        SizedBox(height: 20),
        Text("Bachelor of Science in Computer Science",
            style: TextStyle(color: Colors.white)),
      ],
    );
  }
}
