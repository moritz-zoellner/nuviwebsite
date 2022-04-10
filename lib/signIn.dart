import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:noviwebsite/main.dart';
//import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwController = TextEditingController();
  bool passwVisible = false;
  bool validEmail = false;
  bool validPassword = false;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: CustomScrollView(slivers: [
      const CupertinoSliverNavigationBar(largeTitle: Text("Login")),
      SliverList(
        delegate: SliverChildListDelegate([
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Padding(
                padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
                child: NoviTile(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: CupertinoTextField.borderless(
                          placeholder: "Email oder Telefon",
                          controller: emailController,
                          prefix: const Icon(CupertinoIcons.person),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: CupertinoTextField.borderless(
                            obscureText: !passwVisible,
                            placeholder: "Passwort",
                            controller: passwController,
                            prefix: const Icon(CupertinoIcons.lock),
                            suffix: Row(children: [
                              CupertinoButton(
                                  onPressed: () => setState(() {
                                        passwVisible = !passwVisible;
                                      }),
                                  child: Icon(passwVisible
                                      ? CupertinoIcons.eye
                                      : CupertinoIcons.eye_slash)),
                            ])),
                      ),
                      CupertinoButton(
                          child: const Text(
                            "Passwort vergessen?",
                            style: TextStyle(
                                color: CupertinoColors.systemGrey,
                                fontSize: 15),
                            textAlign: TextAlign.end,
                          ),
                          onPressed: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (_) => const forgotPasswort()))),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 800,
                minWidth: 800,
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
                child: CupertinoButton.filled(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      String email = emailController.text;
                      String password = passwController.text;
                      if (invalidMailAdress(email)) {
                        //ungültige Mail
                        showMyCupDialog(context, 'Ungültige Mailadresse');
                      } else if (invalidPW(password)) {
                        //ungültiges Passwort
                        showMyCupDialog(context, 'Ungültiges Passwort');
                      } else {
                        // einfügen der Daten in firebase
                        Future<bool> success = signIn(email, password);
                        waitDialog(context);
                        success.then((success) {
                          Navigator.pop(context);
                          if (success) {
                            Navigator.pushAndRemoveUntil(
                                context,
                                CupertinoPageRoute(
                                    builder: (_) => const MyHome()),
                                (route) => false);
                          } else {
                            showMyCupDialog(context, 'Ungültige Anmeldedaten');
                          }
                        });
                      }
                    },
                    child: const Text("Anmelden")),
              ),
            ),
          ),
          Center(
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: const EdgeInsets.only(top: 16, left: 74),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Zum ersten mal auf unserer Website?",
                        style: TextStyle(
                            color: CupertinoColors.systemGrey, fontSize: 15),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      CupertinoButton(
                          padding: EdgeInsets.zero,
                          child: const Text("Registrieren",
                              style: TextStyle(fontSize: 16)),
                          onPressed: () => Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (_) => const RegistrierScreen()))),
                    ],
                  ),
                )),
          )
        ]),
      ),
    ]));
  }
}

class RegistrierScreen extends StatefulWidget {
  const RegistrierScreen({Key? key}) : super(key: key);

  @override
  State<RegistrierScreen> createState() => _RegistrierScreenState();
}

class _RegistrierScreenState extends State<RegistrierScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwController = TextEditingController();
  TextEditingController clubNameController = TextEditingController();
  bool passwVisible = false;
  bool validEmail = false;
  bool validPassword = false;
  bool validClubName = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(slivers: [
        const CupertinoSliverNavigationBar(largeTitle: Text("Registrieren")),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 800),
                  child: Padding(
                    padding: const EdgeInsets.all(32),
                    child: NoviTile(
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: CupertinoTextField.borderless(
                              placeholder: "Name des Vereins",
                              controller: clubNameController,
                              prefix: const Icon(CupertinoIcons.person),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: CupertinoTextField.borderless(
                              placeholder: "Email oder Telefon",
                              controller: emailController,
                              prefix: const Icon(CupertinoIcons.person),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: CupertinoTextField.borderless(
                                obscureText: !passwVisible,
                                placeholder: "Passwort",
                                controller: passwController,
                                prefix: const Icon(CupertinoIcons.lock),
                                suffix: CupertinoButton(
                                    onPressed: () => setState(() {
                                          passwVisible = !passwVisible;
                                        }),
                                    child: Icon(passwVisible
                                        ? CupertinoIcons.eye
                                        : CupertinoIcons.eye_slash))),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Center(
                  child: ConstrainedBox(
                      constraints:
                          const BoxConstraints(maxWidth: 800, minWidth: 800),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 32, right: 32),
                        child: CupertinoButton.filled(
                            padding: const EdgeInsets.all(12),
                            onPressed: () {
                              String email = emailController.text;
                              String password = passwController.text;
                              String clubName = clubNameController.text;
                              if (invalidMailAdress(email)) {
                                //ungültige Mail
                                showMyCupDialog(
                                    context, 'Ungültige Mailadresse');
                              } else if (invalidPW(password)) {
                                //ungültiges Passwort
                                showMyCupDialog(context, 'Ungültiges Passwort');
                              } else if (clubName.isEmpty) {
                                //clubname darf nicht leer sein
                                showMyCupDialog(
                                    context, 'Bitte Name des Vereins eingeben');
                              } else {
                                // einfügen der Daten in firebase
                                Future<bool> success =
                                    add(clubName, email, password);
                                waitDialog(context);
                                success.then((success) {
                                  Navigator.pop(context);
                                  if (success) {
                                    Navigator.pushAndRemoveUntil(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (_) => const MyHome()),
                                        (route) => false);
                                  }
                                });
                              }
                            },
                            child: const Text("Registrieren")),
                      ))),
              // Center(
              //   child: ConstrainedBox(
              //       constraints: const BoxConstraints(maxWidth: 900),
              //       child: Padding(
              //         padding: const EdgeInsets.all(16),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.center,
              //           children: [
              //             const Text(
              //               "Sie haben bereits einen Account für Ihren Verein? Jetzt hier",
              //               style: TextStyle(
              //                   color: CupertinoColors.systemBlue,
              //                   decoration: TextDecoration.underline),
              //             ),
              //             const SizedBox(width: 8),
              //             CupertinoButton.filled(
              //                 padding: const EdgeInsets.all(12),
              //                 child: const Text("Anmelden"),
              //                 onPressed: () => Navigator.pop(context)),
              //           ],
              //         ),
              //       )),
              // )
            ],
          ),
        ),
      ]),
    );
  }
}

class forgotPasswort extends StatelessWidget {
  const forgotPasswort({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    return CupertinoPageScaffold(
      child: CustomScrollView(slivers: [
        CupertinoSliverNavigationBar(largeTitle: Text("Passwort schicken")),
        SliverList(
          delegate: SliverChildListDelegate([
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 800),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: NoviTile(
                    CupertinoTextField.borderless(
                        placeholder: "Email oder Telefon",
                        controller: emailController,
                        prefix: const Icon(CupertinoIcons.person)),
                  ),
                ),
              ),
            ),
            Center(
                child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800, minWidth: 800),
              child: Padding(
                padding: const EdgeInsets.only(left: 32, right: 32),
                child: CupertinoButton.filled(
                    onPressed: () {}, child: const Text("Passwort senden")),
              ),
            ))
          ]),
        ),
      ]),
    );
  }
}

class NoviTile extends StatelessWidget {
  final Widget child;
  const NoviTile(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: CupertinoColors.systemGroupedBackground,
          borderRadius: BorderRadius.all(Radius.circular(16))),
      child: child,
    );
  }
}

Future<bool> add(
    final String clubName, final String email, final String password) async {
  try {
    // create new User      in FireAuth
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    await userCredential.user?.updateDisplayName(clubName);

    // create new Document  in FirebaseFirestore
    await FirebaseFirestore.instance
        .collection("tclub_users")
        .doc(userCredential.user?.uid)
        .set({
      "Vereinsname": clubName,
      "Emailadresse": email,
    });
    print("User '$clubName' was successfully added to the Database");
    return true;
  } catch (error) {
    print("User'$email'");
    print(error);
    return false;
  }
}

bool invalidMailAdress(String data) {
  return !RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(data);
}

bool invalidPW(String data) {
  if (data.length >= 6) {
    return false;
  }
  return true;
}

Future waitDialog(BuildContext context) {
  return showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CupertinoActivityIndicator()));
}

void showMyCupDialog(context, content) {
  showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text('Fehler bei der Anmeldung!'),
          content: Text(content),
          actions: <Widget>[
            CupertinoDialogAction(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'))
          ],
        );
      });
}

Future<bool> signIn(final String email, final String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    print("User $email signed in ");
    return true;
  } catch (error) {
    print(error);
    return false;
  }
}
