import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyDescription extends StatelessWidget {
  const PrivacyDescription({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();

    return Center(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Scaffold(
                        body: SingleChildScrollView(
                            child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(children: [
                                        IconButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            icon: const Icon(Icons.close)),
                                        const SizedBox(width: 20),
                                        const Text("Datenschutz",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30)),
                                      ]),
                                      SingleChildScrollView(
                                        child: Center(
                                          child: Container(
                                              margin: const EdgeInsets.all(20),
                                              constraints: const BoxConstraints(
                                                  maxWidth: 800),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Row(children: const [
                                                    Flexible(
                                                      child: Text(
                                                        "1. Datenschutz auf einen Blick",
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ]),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(children: const [
                                                    Flexible(
                                                      child: Text(
                                                        "Allgemeine Hinweise",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ]),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(children: const [
                                                    Flexible(
                                                      child: Text(
                                                        "Die folgenden Hinweise geben einen einfachen Überblick darüber, was mit Ihren personenbezogenen Daten passiert, wenn Sie diese Website besuchen. Personenbezogene Daten sind alle Daten, mit denen Sie persönlich identifiziert werden können. Ausführliche Informationen zum Thema Datenschutz entnehmen Sie unserer unter diesem Text aufgeführten Datenschutzerklärung.",
                                                      ),
                                                    ),
                                                  ]),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(children: const [
                                                    Flexible(
                                                      child: Text(
                                                        "Datenerfassung auf dieser Website",
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                    ),
                                                  ]),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(children: const [
                                                    Flexible(
                                                      child: Text(
                                                        "Wer ist verantwortlich für die Datenerfassung auf dieser Website?",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ]),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(children: const [
                                                    Flexible(
                                                      child: Text(
                                                        "Die Datenverarbeitung auf dieser Website erfolgt durch den Websitebetreiber. Dessen Kontaktdaten können Sie dem Abschnitt „Hinweis zur Verantwortlichen Stelle“ in dieser Datenschutzerklärung entnehmen.",
                                                      ),
                                                    ),
                                                  ]),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(children: const [
                                                    Flexible(
                                                      child: Text(
                                                        "Wie erfassen wir Ihre Daten?",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ]),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(children: const [
                                                    Flexible(
                                                      child: Text(
                                                        "Ihre Daten werden zum einen dadurch erhoben, dass Sie uns diese mitteilen. Hierbei kann es sich z. B. um Daten handeln, die Sie in ein Kontaktformular eingeben.\n\nAndere Daten werden automatisch oder nach Ihrer Einwilligung beim Besuch der Website durch unsere IT-Systeme erfasst. Das sind vor allem technische Daten (z. B. Internetbrowser, Betriebssystem oder Uhrzeit des Seitenaufrufs). Die Erfassung dieser Daten erfolgt automatisch, sobald Sie diese Website betreten.",
                                                      ),
                                                    ),
                                                  ]),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(children: const [
                                                    Flexible(
                                                      child: Text(
                                                        "Wofür nutzen wir Ihre Daten?",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ]),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(children: const [
                                                    Flexible(
                                                      child: Text(
                                                        "Ein Teil der Daten wird erhoben, um eine fehlerfreie Bereitstellung der Website zu gewährleisten. Andere Daten können zur Analyse Ihres Nutzerverhaltens verwendet werden.",
                                                      ),
                                                    ),
                                                  ]),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(children: const [
                                                    Flexible(
                                                      child: Text(
                                                        "Welche Rechte haben Sie bezüglich Ihrer Daten?",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ]),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(children: const [
                                                    Flexible(
                                                      child: Text(
                                                        "Sie haben jederzeit das Recht, unentgeltlich Auskunft über Herkunft, Empfänger und Zweck Ihrer gespeicherten personenbezogenen Daten zu erhalten. Sie haben außerdem ein Recht, die Berichtigung oder Löschung dieser Daten zu verlangen. Wenn Sie eine Einwilligung zur Datenverarbeitung erteilt haben, können Sie diese Einwilligung jederzeit für die Zukunft widerrufen. Außerdem haben Sie das Recht, unter bestimmten Umständen die Einschränkung der Verarbeitung Ihrer personenbezogenen Daten zu verlangen.\n\nDes Weiteren steht Ihnen ein Beschwerderecht bei der zuständigen Aufsichtsbehörde zu.\n\nHierzu sowie zu weiteren Fragen zum Thema Datenschutz können Sie sich jederzeit an uns wenden.",
                                                      ),
                                                    ),
                                                  ]),
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  Row(children: const [
                                                    Flexible(
                                                      child: Text(
                                                        "Analyse-Tools und Tools von Drittanbietern",
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ]),
                                                  const SizedBox(
                                                    height: 4,
                                                  ),
                                                  Row(children: const [
                                                    Flexible(
                                                      child: Text(
                                                        "Beim Besuch dieser Website kann Ihr Surf-Verhalten statistisch ausgewertet werden. Das geschieht vor allem mit sogenannten Analyseprogrammen.\n\nDetaillierte Informationen zu diesen Analyseprogrammen finden Sie in der folgenden Datenschutzerklärung.",
                                                      ),
                                                    ),
                                                  ]),
                                                ],
                                              )),
                                        ),
                                      )
                                    ]))))))));
  }
}
