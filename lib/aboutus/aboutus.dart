import 'package:flutter/material.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 400),
            child: Column(children: [
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Wrap(spacing: 20, children: [
                    SizedBox(
                        width: 400,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
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
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              SizedBox(height: 20),
                            ])),
                    SizedBox(
                        width: 400,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: const [
                              Text("Unsere Geschichte",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 40,
                                      color: Colors.white)),
                              SizedBox(height: 20),
                              Text(
                                  "Novi begann im Jahr 2021 als ein gemeinnütziges Projekt mit dem Erfurter TC Rot-Weiß e.V. Der Grund dafür war der hohe Bedarf an einer Reduzierung des organisatorischen und verwaltungstechnischen Aufwands des Tennisclubs. Es musste also ein „Tool“ entwickelt werden, welches alle Belange eines Tennisclubs erfüllen soll.\n\nDie Lösung kam 2022 mit einer für den Erfurter Rot-Weiß optimierten App, namens „Rot-Weiß-App“, die auf allen Geräten und Plattformen Lauffähig ist. Der Entwickler Hundesohn Vadime Novikau erkannte schnell das Potenzial dieser App und weitete das Konzept für alle Tennisvereine aus.\n\nDies mündete 2022 mit der Unternehmensgründung von der Novi UG (Haftungsbeschränkt). Heute ist Novi nicht nur für den Tennisbereich aktiv, sondern übernimmt alle möglichen Software-Solutions in der App-Developement-Welt.",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16)),
                              SizedBox(height: 20),
                            ])),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Team",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: Colors.white)),
                        Column(
                          children: [
                            ConstrainedBox(
                                constraints: const BoxConstraints(
                                    minWidth: 300,
                                    maxWidth: 300,
                                    minHeight: 300,
                                    maxHeight: 300),
                                child: Container(
                                    padding: const EdgeInsets.all(20),
                                    child: ClipRRect(
                                      child: Image.asset(
                                          'assets/denis_bild.jpeg',
                                          fit: BoxFit.cover),
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(150)),
                                    ))),
                            ConstrainedBox(
                              constraints: const BoxConstraints(
                                  maxHeight: 440, maxWidth: 400),
                              child: Container(
                                padding: const EdgeInsets.all(20),
                                margin: const EdgeInsets.all(8),
                                decoration: const BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    Text("Denis Novikau",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16)),
                                    SizedBox(height: 16),
                                    Text(
                                        "Bachelor of Science in Computer Science",
                                        style: TextStyle(color: Colors.white)),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ])),
            ])),
      ),
    );
  }
}
