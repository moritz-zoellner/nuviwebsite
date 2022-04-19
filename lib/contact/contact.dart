import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/styling.dart';

class KontaktFormular extends StatelessWidget {
  const KontaktFormular({Key? key}) : super(key: key);

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
              padding: const EdgeInsets.all(20),
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Text("Kontakt",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 30,
                                color: Colors.white)),
                        const SizedBox(height: 20),
                        NoviTile(
                          Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: CupertinoTextField.borderless(
                                    placeholder: "Name",
                                    controller: nameController,
                                    prefix: const Icon(
                                      CupertinoIcons.person,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: CupertinoTextField.borderless(
                                    obscureText: true,
                                    placeholder: "Email",
                                    controller: emailController,
                                    prefix: const Icon(
                                      CupertinoIcons.mail,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 16, right: 16, top: 16, bottom: 16),
                          child: Text("Ihr Anliegen",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                        NoviTile(CupertinoTextField.borderless(
                          maxLines: 5,
                          placeholder: "Beginne hier...",
                          controller: concernController,
                        )),
                        const SizedBox(height: 20),
                        MaterialButton(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 24),
                            child: const Text("Senden",
                                style: TextStyle(color: Colors.white)),
                            color: Colors.blue,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            onPressed: () {
                              waitDialog(context);
                              FirebaseFirestore.instance
                                  .collection("concerns")
                                  .add({
                                "name": nameController.text,
                                "email": emailController.text,
                                "concern": concernController.text
                              }).then((value) {
                                closeDialog(context);
                                nameController.clear();
                                emailController.clear();
                                concernController.clear();
                                myCustomError(
                                    context, "Nachricht wurde abgesendet");
                              }).catchError((e, s) {
                                closeDialog(context);

                                myCustomError(context,
                                    e.toString().split("]").last.trim());
                              });
                            })
                      ]))),
        ),
      ),
    );
  }
}
