import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/styling.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController nameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController concernController = TextEditingController();
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                const Text("Blog",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white)),
                const SizedBox(height: 20),
                const BlogPost(
                    "Ankündigung einer neuen Schiedsrichter-App",
                    "Novi hat am 14.04.2022 angekündigt eine neue App für Schiedsrichter zu entwickeln, die neben dem Punktezählen auch jegliche Statistiken zum Spiel übersichtlich und leicht abrufbar darlegt. Dabei sollen nicht nur Schiedsrichter, sondern auch am Match beteiligte Spieler die entsprechende Statistik einsehen können. Aktuell wird am Design gearbeitet, wobei das Augenmerk insbesondere auf die leichte und effiziente Bedienung gerichtet ist. Als nächster Schritt sind die mathematisch-analytischen Tools in die App zu integrieren.",
                    "16.04.2022"),
                const BlogPost(
                    "Tclub für Administrator wird noch vor Sommer 2022 released",
                    "Mit großen Schritten geht es in der Entwicklung der Tclub-Admin-App weiter. Die Funktionalitäten der App wurden erfolgreich in der neuen Novi Unternehmens-Webseite implementiert. Insbesondere sind Registrierungs- und Anmeldungsprozedere vollständig, fehlerfrei und mit ansprechendem Design gefertigt worden. Ab sofort wird es für Vertreter eines Tennisclubs möglich sein sich über die Novi-Webseite einzuloggen, um sich den verwaltungstechnischen Tätigkeiten des Clubs zu widmen. Novi hat sich entschieden die Admin-App noch vor dem Juli 2022 für Tennisclubs zugänglich zu machen.",
                    "20.04.2022"),
                const SizedBox(height: 20),
                const Text("Kontakt",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        color: Colors.white)),
                const SizedBox(height: 20),
                NoviTile(Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: TextField(
                            controller: nameController,
                            decoration: const InputDecoration(
                                label: Text("Name"),
                                prefix: Icon(Icons.person_outlined,
                                    color: Colors.blue)),
                          )),
                      Padding(
                          padding: const EdgeInsets.all(20),
                          child: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                label: Text("Email"),
                                prefix: Icon(Icons.mail_outlined,
                                    color: Colors.blue)),
                          ))
                    ])),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 16),
                  child: Text("Ihr Anliegen",
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ),
                NoviTile(TextField(
                    maxLines: 5,
                    decoration:
                        const InputDecoration(label: Text("Beginne hier...")),
                    controller: concernController)),
                const SizedBox(height: 20),
                MaterialButton(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 32, vertical: 24),
                    child: const Text("Senden",
                        style: TextStyle(color: Colors.white)),
                    color: Colors.blue,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    onPressed: () {
                      waitDialog(context);
                      FirebaseFirestore.instance.collection("concerns").add({
                        "name": nameController.text,
                        "email": emailController.text,
                        "concern": concernController.text
                      }).catchError((e, s) {
                        closeDialog(context);

                        myCustomError(
                            context, e.toString().split("]").last.trim());
                      }).then((value) {
                        closeDialog(context);
                        nameController.clear();
                        emailController.clear();
                        concernController.clear();
                        myCustomError(context, "Nachricht wurde abgesendet");
                      });
                    }),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BlogPost extends StatelessWidget {
  final String title;
  final String content;
  final String datum;

  const BlogPost(this.title, this.content, this.datum, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(height: 20),
      Text(title,
          style: const TextStyle(
              fontWeight: FontWeight.bold, fontSize: 24, color: Colors.white)),
      const SizedBox(height: 20),
      NoviTile(Text(content,
          style: const TextStyle(color: Colors.black, fontSize: 16))),
      const SizedBox(height: 20),
    ]);
  }
}
