import 'package:flutter/material.dart';

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
