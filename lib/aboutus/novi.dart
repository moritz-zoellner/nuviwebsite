import 'package:flutter/material.dart';

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
