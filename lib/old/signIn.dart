import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/main.dart';
import 'package:noviwebsite/ld_page/projects.dart';
//import 'package:flutter/material.dart';

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
                                myCustomError(context, 'Ungültige Mailadresse');
                              } else if (invalidPW(password)) {
                                //ungültiges Passwort
                                myCustomError(context, 'Ungültiges Passwort');
                              } else if (clubName.isEmpty) {
                                //clubname darf nicht leer sein
                                myCustomError(
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
                                            builder: (_) => const TClub()),
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

class NoviTile extends StatelessWidget {
  final Widget child;
  const NoviTile(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          color: Colors.white70,
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

void myCustomError(context, content) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(title: Text(content), actions: [
            MaterialButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('OK'))
          ]));
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
