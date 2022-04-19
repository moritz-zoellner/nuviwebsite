import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivateProject extends StatelessWidget {
  const PrivateProject(this.name, this.uid, {Key? key}) : super(key: key);
  final String name;
  final String uid;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        MyAppBar(name),
        Center(
            child: ConstrainedBox(
                constraints: const BoxConstraints(minHeight: 400),
                child: SingleChildScrollView(
                    child: Column(children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 60, vertical: 40),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Expanded(child: BusinessPlanDescription()),
                            const SizedBox(width: 40),
                            Expanded(child: ChatDescription(uid))
                          ])),
                ]))))
      ],
    );
  }
}

class MyAppBar extends StatelessWidget {
  const MyAppBar(this.name, {Key? key}) : super(key: key);
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 40),
        child: OverflowBar(
            alignment: MainAxisAlignment.spaceBetween,
            spacing: 40,
            overflowSpacing: 20,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.blue)),
                  const SizedBox(width: 20),
                  Text(name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 30)),
                ],
              ),
            ]));
  }
}

class BusinessPlanDescription extends StatefulWidget {
  const BusinessPlanDescription({Key? key}) : super(key: key);

  @override
  State<BusinessPlanDescription> createState() =>
      _BusinessPlanDescriptionState();
}

class _BusinessPlanDescriptionState extends State<BusinessPlanDescription> {
  int _currentstate = 0;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text("Business-Plan",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                    color: Colors.white)),
            const SizedBox(height: 20),
            Stepper(
              controlsBuilder: (context, onStepContinue) {
                return const SizedBox.shrink();
              },
              steps: [
                Step(
                    isActive: (_currentstate == 0),
                    title: const Text(
                      'Vorstellung',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    content: const Text(
                      "Sie haben die Wahl wie Sie mit uns in Kontakt tretten wollen. Hierzu gibt es heutzutage genügend Möglichkeiten, wie z.B Whatsapp, Zoom oder FaceTime. Auch ein persönliches Treffen ist möglich. Dieser Schritt dient dazu, um genauere Details über das von Ihnen gewünschte Projekt zu erhalten. Gleichzeitig sollen Sie damit natürlich auch einen ersten Einblick in unsere Arbeitsweise bekommen, um damit eine vertrauliche Atmosphäre zwischen Ihnen und unseren Mitarbeitern zu schaffen",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )),
                Step(
                    isActive: (_currentstate == 1),
                    title: const Text(
                      "Fertigung",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    content: const Text(
                      'Sie haben die Wahl wie Sie mit uns in Kontakt tretten wollen. Hierzu gibt es heutzutage genügend Möglichkeiten, wie z.B Whatsapp, Zoom oder FaceTime. Auch ein persönliches Treffen ist möglich. Dieser Schritt dient dazu, um genauere Details über das von Ihnen gewünschte Projekt zu erhalten. Gleichzeitig sollen Sie damit natürlich auch einen ersten Einblick in unsere Arbeitsweise bekommen, um damit eine vertrauliche Atmosphäre zwischen Ihnen und unseren Mitarbeitern zu schaffen',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )),
                Step(
                    isActive: (_currentstate == 2),
                    title: const Text(
                      'Veröffentlichung',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    content: const Text(
                      'Sie haben die Wahl wie Sie mit uns in Kontakt tretten wollen. Hierzu gibt es heutzutage genügend Möglichkeiten, wie z.B Whatsapp, Zoom oder FaceTime. Auch ein persönliches Treffen ist möglich. Dieser Schritt dient dazu, um genauere Details über das von Ihnen gewünschte Projekt zu erhalten. Gleichzeitig sollen Sie damit natürlich auch einen ersten Einblick in unsere Arbeitsweise bekommen, um damit eine vertrauliche Atmosphäre zwischen Ihnen und unseren Mitarbeitern zu schaffen',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ))
              ],
              onStepTapped: (int newIndex) {
                setState(() {
                  _currentstate = newIndex;
                });
              },
              currentStep: _currentstate,
            )
          ]),
    );
  }
}

class ChatDescription extends StatelessWidget {
  final String uid;
  const ChatDescription(this.uid, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    return SingleChildScrollView(
      child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("apps")
              .doc(uid)
              .collection("messages")
              .orderBy("index")
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            List<DocumentSnapshot<Map<String, dynamic>>> messages =
                snapshot.data!.docs;
            return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Chat",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.white)),
                  const SizedBox(height: 20),
                  Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(20)),
                      constraints: const BoxConstraints(
                          maxHeight: 400, maxWidth: 600, minHeight: 300),
                      child: SingleChildScrollView(
                          child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: List.generate(messages.length + 1, (i) {
                          if (i == 0) {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 400),
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.blue.shade200,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Admin",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                          "Hallo und herzlich Willkommen, wie können wir dir helfen"),
                                    ],
                                  )),
                            );
                          }
                          int index = i - 1;
                          Map<String, dynamic> mes = messages[index].data()!;

                          if (mes["sender"] == "Admin") {
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  constraints:
                                      const BoxConstraints(maxWidth: 400),
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.blue.shade200,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        mes["sender"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(mes["content"]),
                                    ],
                                  )),
                            );
                          } else {
                            return Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  constraints: const BoxConstraints(
                                    maxWidth: 400,
                                  ),
                                  margin: const EdgeInsets.only(
                                      top: 10, left: 10, right: 10),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.pink.shade200,
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        mes["sender"],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(mes["content"]),
                                    ],
                                  )),
                            );
                          }
                        }),
                      ))),
                  const SizedBox(height: 20),
                  Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(20)),
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: CupertinoTextField.borderless(
                          controller: messageController,
                          onEditingComplete: () {
                            // send to Firebase
                            FirebaseFirestore.instance
                                .collection("apps")
                                .doc(uid)
                                .collection("messages")
                                .add({
                              "sender": "You",
                              "content": messageController.text,
                              "index": messages.length
                            });
                            messageController.clear();
                          },
                          suffix: IconButton(
                              onPressed: () {
                                // send to Firebase
                                FirebaseFirestore.instance
                                    .collection("apps")
                                    .doc(uid)
                                    .collection("messages")
                                    .add({
                                  "sender": "You",
                                  "content": messageController.text,
                                  "index": messages.length
                                });
                                messageController.clear();
                              },
                              icon: const Icon(Icons.send_rounded)),
                          placeholder: "Write a message"))
                ]);
          }),
    );
  }
}
