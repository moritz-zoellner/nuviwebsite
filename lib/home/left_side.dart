import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/main.dart';
import 'package:noviwebsite/styling.dart';

class LeftSide extends StatelessWidget {
  const LeftSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(20),
        constraints: const BoxConstraints(maxWidth: 500),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text("Wir verwirklichen Ihre Ideen",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      color: Colors.white)),
              SizedBox(height: 20),
              Text(
                  "Checken Sie unsere bereits entwickelten Anwendungen.\nWollen Sie etwas Für sich oder Ihr Unternehmen? Wir entwickeln Apps für Web, IOS and Android auf Anfrage.",
                  maxLines: 4,
                  style: TextStyle(color: Colors.white, fontSize: 16)),
              SizedBox(height: 20),
              CreateAppButton(),
            ]),
      ),
    );
  }
}

class CreateAppButton extends StatelessWidget {
  const CreateAppButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child:
            const Text("App erstellen", style: TextStyle(color: Colors.pink)),
        color: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        onPressed: () {
          showGeneralDialog(
              barrierColor: Colors.black26,
              context: context,
              pageBuilder: (context, a1, a2) => const CreateAppDialog());
        });
  }
}

class CreateAppDialog extends StatelessWidget {
  const CreateAppDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool notLoggedIn = FirebaseAuth.instance.currentUser == null;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwController = TextEditingController();
    TextEditingController dreamController = TextEditingController();
    TextEditingController appNameController = TextEditingController();
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600, maxHeight: 600),
            child: ScaffoldMessenger(
              child: Builder(builder: (context) {
                return Scaffold(
                    body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          children: [
                            IconButton(
                                onPressed: () => Navigator.pop(context),
                                icon: const Icon(Icons.close)),
                            const SizedBox(width: 20),
                            const Flexible(
                              child: Text("App erstellen",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30)),
                            ),
                          ],
                        ),
                        notLoggedIn
                            ? const Padding(
                                padding: EdgeInsets.all(20),
                                child: Text("Registrieren",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                              )
                            : const SizedBox.shrink(),
                        notLoggedIn
                            ? Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade100,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(20))),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: CupertinoTextField.borderless(
                                          placeholder: "Email",
                                          controller: emailController,
                                          prefix: const Icon(
                                            CupertinoIcons.mail,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: CupertinoTextField.borderless(
                                          obscureText: true,
                                          placeholder: "Passwort",
                                          controller: passwController,
                                          prefix: const Icon(
                                            CupertinoIcons.lock,
                                            color: Colors.blue,
                                          ),
                                        ),
                                      ),
                                    ]),
                              )
                            : const SizedBox.shrink(),
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text("App-Name",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: CupertinoTextField.borderless(
                              placeholder: "MeineTraumApp",
                              controller: appNameController,
                            )),
                        const Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                              "Beschreiben Sie Ihre App in ca. 100 Wörtern",
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                        ),
                        Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(20))),
                            child: CupertinoTextField.borderless(
                              maxLines: 5,
                              placeholder: "Beginne hier...",
                              controller: dreamController,
                            )),
                        const SizedBox(height: 20),
                        MaterialButton(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 24),
                            child: const Text("Eine App-Anfrage erstellen",
                                style: TextStyle(color: Colors.white)),
                            color: Colors.blue,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            onPressed: () {
                              if (appNameController.text.isEmpty ||
                                  dreamController.text.isEmpty ||
                                  dreamController.text.length < 50) {
                                myCustomError(context,
                                    "Die Eingabefelder dürfen nicht leer sein und/oder schreibe ein bisschen mehr über das Projekt");
                                return;
                              }

                              void writeApp() {
                                waitDialog(context);
                                FirebaseFirestore.instance
                                    .collection("apps")
                                    .add({
                                  "useremail": notLoggedIn
                                      ? emailController.text
                                      : FirebaseAuth
                                          .instance.currentUser!.email,
                                  "appname": appNameController.text,
                                  "projectfamily": "private",
                                  "description": dreamController.text,
                                  "businessplan": 0
                                }).then((value) {
                                  closeDialog(context);
                                  closeDialog(context);
                                  Navigator.pushReplacement(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder:
                                          (context, animation1, animation2) =>
                                              const MyApp(),
                                      transitionsBuilder: (c, a1, a2, w) =>
                                          FadeTransition(opacity: a1, child: w),
                                    ),
                                  );
                                  myCustomError(
                                      context, "Auftrag wurde erstellt");
                                }).catchError((e, s) {
                                  closeDialog(context);

                                  myCustomError(context,
                                      e.toString().split("]").last.trim());
                                });
                              }

                              if (notLoggedIn) {
                                waitDialog(context);
                                FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                        email: emailController.text,
                                        password: passwController.text)
                                    .then((value) {
                                  closeDialog(context);
                                  writeApp;
                                }).catchError((e, s) {
                                  closeDialog(context);

                                  myCustomError(context,
                                      e.toString().split("]").last.trim());
                                });
                              } else {
                                writeApp();
                              }
                            })
                      ],
                    ),
                  ),
                ));
              }),
            ),
          ),
        ),
      ),
    );
  }
}
