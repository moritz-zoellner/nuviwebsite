import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../styling.dart';

class ImpressumDescription extends StatelessWidget {
  const ImpressumDescription({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    return SingleChildScrollView(
      child: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          constraints: const BoxConstraints(maxWidth: 800),
          child: NoviTile(Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(children: [
                Flexible(
                  child: Text(
                    "Angaben gemäß § 5 TMG",
                    style:
                        CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                  ),
                ),
              ]),
              const SizedBox(
                height: 16,
              ),
              Row(children: const [
                Flexible(
                  child: Text(
                    "Novi UG (haftungsbeschränkt)\nKartäuserstraße 11\nWohnungseinheit 6\n99084 Erfurt\n\nHandelsregister: HRB 999999\nRegistergericht: Amtsgericht Erfurt\n",
                  ),
                ),
              ]),
              Row(children: const [
                Flexible(
                  child: Text(
                    "Vertreten durch:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ]),
              Row(children: const [
                Flexible(
                  child: Text(
                    "Lappen Vadime Novikau\nMoritz Zöllner\nDr. Denis Novikau\n",
                  ),
                ),
              ]),
              Row(children: [
                Flexible(
                  child: Text(
                    "Kontakt\n",
                    style:
                        CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                  ),
                ),
              ]),
              Row(children: const [
                Flexible(
                  child: Text(
                    "Telefon 1: +49(0) 17622581686\nTelefon2: +49(0) 17622587789\nE-Mail: novi.corp@gmail.com\n",
                  ),
                ),
              ]),
              Row(children: [
                Flexible(
                  child: Text(
                    "Umsatzsteuer-ID\n",
                    style:
                        CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                  ),
                ),
              ]),
              Row(children: const [
                Flexible(
                  child: Text(
                    "Umsatzsteuer-Identifikationsnummer gemaß §27 a Umsatzsteuergesetz:\nDE9999999\n",
                  ),
                ),
              ]),
              Row(children: [
                Flexible(
                  child: Text(
                    "Redaktionell verantwortlich\n",
                    style:
                        CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                  ),
                ),
              ]),
              Row(children: const [
                Flexible(
                  child: Text(
                    "Vadime Novikau\nKartäuserstraße 11\n99084 Erfurt\n",
                  ),
                ),
              ]),
              Row(children: [
                Flexible(
                  child: Text(
                    "EU-Streitschlichtung\n",
                    style:
                        CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                  ),
                ),
              ]),
              Row(children: const [
                Flexible(
                  child: Text(
                    "Die Europäische Kommission stellt eine Plattform zur Online-Streitbeilegung (OS) bereit:",
                  ),
                ),
              ]),
              Row(children: [
                MouseRegion(
                  child: GestureDetector(
                    child: const Text("https://ec.europa.eu/consumers/odr/",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue)),
                    onTap: () => launch('https://ec.europa.eu/consumers/odr/'),
                  ),
                  cursor: SystemMouseCursors.click,
                )
              ]),
              Row(children: const [
                Flexible(
                  child: Text(
                    "Unsere Adresse finden Sie oben im Impressum.\n",
                  ),
                ),
              ]),
              Row(children: [
                Flexible(
                  child: Text(
                    "Verbraucherstreitbeilegung/ Universalschlichtungsstelle\n",
                    style:
                        CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                  ),
                ),
              ]),
              Row(children: const [
                Flexible(
                  child: Text(
                    "Wir sind nicht bereit oder verpflichtet, an Streitbeilegungsverfahren vor einer Verbraucherschlichtungsstelle teilzunehmen.\n",
                  ),
                ),
              ]),
            ],
          )),
        ),
      ),
    );
  }
}
