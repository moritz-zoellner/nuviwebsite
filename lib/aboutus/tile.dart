import 'package:flutter/material.dart';

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
          constraints: const BoxConstraints(
              minWidth: 300, maxWidth: 300, minHeight: 300, maxHeight: 300),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
              child: Image.asset(
                'assets/Vadim1.jpg',
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(150)),
            ),
          ),
        ),
        ConstrainedBox(
          constraints: const BoxConstraints(maxHeight: 440, maxWidth: 400),
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
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
  const MoritzDescription({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //TextEditingController nameController = TextEditingController();
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
  const VadimeDescription({Key? key}) : super(key: key);
  //TextEditingController nameController = TextEditingController();
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
  const DenisDescription({Key? key}) : super(key: key);
  //TextEditingController nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(children: const [
          Flexible(
            child: Text(
              "Professioneller Blunt Roller. Du denkst Sexy Boy? Hab nicht mal ein riesen Coq. Macht sogar straighte Frauen zu lesben. Kein bisschen Ahnung von Programmieren und Leben.",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ]),
      ],
    );
  }
}
