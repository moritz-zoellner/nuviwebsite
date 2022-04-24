import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/impressum/secure_menu.dart';
import 'package:noviwebsite/management/empty.dart';
import 'package:noviwebsite/styling.dart';

class RightSide extends StatefulWidget {
  const RightSide({Key? key}) : super(key: key);
  @override
  State<RightSide> createState() => _RightSide();
}

class _RightSide extends State<RightSide> {
  static const int SIGNUP = 0, SIGNIN = 1, FPASS = 2, LOGGED_IN = 3;

  int currentState = SIGNUP;
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser != null) {
      currentState = LOGGED_IN;
    }
    if (currentState == SIGNUP) {
      return signup();
    } else if (currentState == SIGNIN) {
      return signin();
    } else if (currentState == FPASS) {
      return fpass();
    } else if (currentState == LOGGED_IN) {
      return userProjects();
    } else {
      return const Center(child: CircularProgressIndicator());
    }
  }

  Widget userProjects() {
    String useremail = FirebaseAuth.instance.currentUser!.email!;
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      const Text("Ihre Projekte",
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30)),
      FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("apps")
              .where("useremail", isEqualTo: useremail)
              .get(),
          builder: ((context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            List<DocumentSnapshot<Map<String, dynamic>>> list =
                snapshot.data!.docs;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: List.generate(
                    list.length,
                    (index) => Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: MaterialButton(
                            elevation: 0,
                            hoverElevation: 0,
                            focusElevation: 0,
                            highlightElevation: 0,
                            disabledElevation: 0,
                            splashColor: Colors.pink,
                            highlightColor: Colors.blue.withAlpha(100),
                            hoverColor: Colors.blue.withAlpha(100),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 30),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            color: Colors.white12,
                            onPressed: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          EmptyProject(list[index]),
                                  transitionsBuilder: (c, a1, a2, w) =>
                                      FadeTransition(opacity: a1, child: w),
                                ),
                              );
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(list[index]["appname"],
                                    style: const TextStyle(fontSize: 20)),
                                const SizedBox(height: 10),
                                Text(list[index]["description"])
                              ],
                            ),
                          ),
                        )));
          })),
      const SizedBox(height: 20),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          MaterialButton(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
              child:
                  const Text("Abmelden", style: TextStyle(color: Colors.white)),
              color: Colors.pink,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              onPressed: () {
                waitDialog(context);
                FirebaseAuth.instance.signOut().then((value) {
                  closeDialog(context);
                  setState(() => currentState = SIGNIN);
                }).catchError((e) {
                  closeDialog(context);
                  myCustomError(context, e.toString().split("]").last.trim());
                });
              }),
        ],
      ),
      const SizedBox(height: 20),
      const SecureMenu(),
    ]);
  }

  Widget fpass() {
    TextEditingController emailController = TextEditingController();
    return Center(
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text("Passwort vergessen",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30)),
                const SizedBox(height: 0),
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(
                              const EdgeInsets.symmetric(vertical: 4))),
                      onPressed: () => setState(() => currentState = SIGNIN),
                      child: const Text("Zurück zur Anmeldung",
                          style: TextStyle(color: Colors.white, fontSize: 16))),
                ),
                const SizedBox(height: 20),
                NoviTile(
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
                ),
                const SizedBox(height: 20),
                MyBlueButton(
                  "Passwort an Email versenden",
                  onPressed: () {
                    waitDialog(context);
                    FirebaseAuth.instance
                        .sendPasswordResetEmail(email: emailController.text)
                        .then((value) {
                      closeDialog(context);
                      myCustomError(context, "Email wurde gesendet");
                    }).catchError((e, s) {
                      closeDialog(context);

                      myCustomError(
                          context, e.toString().split("]").last.trim());
                    });
                  },
                ),
                const SizedBox(height: 20),
                const SecureMenu(),
              ],
            )));
  }

  Widget signin() {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwController = TextEditingController();
    return Center(
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text("Anmelden",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 30)),
                const SizedBox(height: 0),
                OverflowBar(
                  children: [
                    const Text("Ich habe keinen Account!",
                        maxLines: 4,
                        style: TextStyle(color: Colors.white, fontSize: 16)),
                    TextButton(
                        onPressed: () => setState(() => currentState = SIGNUP),
                        child: const Text("Registrieren",
                            style:
                                TextStyle(color: Colors.white, fontSize: 16)))
                  ],
                ),
                const SizedBox(height: 20),
                NoviTile(Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                      TextButton(
                          onPressed: () => setState(() => currentState = FPASS),
                          child: const Text("Passwort vergessen?",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 14)))
                    ])),
                const SizedBox(height: 20),
                MyBlueButton("Anmelden", onPressed: () {
                  waitDialog(context);
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwController.text)
                      .then((value) {
                    closeDialog(context);

                    myCustomError(context, "Nutzer erfolgreich angemeldet");
                    setState(() => currentState = LOGGED_IN);
                  }).catchError((e, s) {
                    closeDialog(context);

                    myCustomError(context, e.toString().split("]").last.trim());
                  });
                }),
                const SizedBox(height: 20),
                const SecureMenu(),
              ],
            )));
  }

  Widget signup() {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwController = TextEditingController();
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 600),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Registrieren",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30)),
            const SizedBox(height: 0),
            OverflowBar(
              children: [
                const Text("Habe bereits einen Account?",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 4,
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                TextButton(
                    onPressed: () => setState(() => currentState = SIGNIN),
                    child: const Text("Anmelden",
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.white, fontSize: 16)))
              ],
            ),
            const SizedBox(height: 20),
            NoviTile(Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                  )
                ])),
            const SizedBox(height: 20),
            MyBlueButton("Registrieren", onPressed: (() {
              waitDialog(context);
              FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: emailController.text,
                      password: passwController.text)
                  .then((value) {
                closeDialog(context);

                myCustomError(context, "Nutzer erfolgreich registriert");
                setState(() {
                  currentState = LOGGED_IN;
                });
              }).catchError((e) {
                closeDialog(context);

                myCustomError(
                    context, e.message.toString().split("]").last.trim());
              });
            })),
            const SizedBox(height: 20),
            const SecureMenu(),
          ],
        ),
      ),
    );
  }
}
