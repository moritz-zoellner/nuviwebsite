import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PrivateProject extends StatelessWidget {
  const PrivateProject(this.name, this.uid, this.businessplan, {Key? key})
      : super(key: key);
  final String name;
  final String uid;
  final int? businessplan;
  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (c, b) => [
        SliverToBoxAdapter(child: MyAppBar(name)),
      ],
      body: Center(
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
                          (businessplan == -1)
                              ? const SizedBox.shrink()
                              : Expanded(
                                  child: BusinessPlanDescription(businessplan)),
                          const SizedBox(width: 40),
                          Expanded(child: Center(child: ChatDescription(uid)))
                        ])),
              ])))),
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
                  Flexible(
                    child: Text(name,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30)),
                  ),
                ],
              ),
            ]));
  }
}

class BusinessPlanDescription extends StatefulWidget {
  const BusinessPlanDescription(this.businessplan, {Key? key})
      : super(key: key);
  final int? businessplan;
  @override
  State<BusinessPlanDescription> createState() =>
      _BusinessPlanDescriptionState();
}

class _BusinessPlanDescriptionState extends State<BusinessPlanDescription> {
  int _currentstate = 0;
  bool isButtonDisabled = false;

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
                if (_currentstate == 1) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: MaterialButton(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 24),
                            child: Text("Projekt-Fortschritt",
                                style: TextStyle(
                                    color: (isButtonDisabled == true)
                                        ? Colors.pink
                                        : Colors.grey)),
                            color: Colors.white,
                            mouseCursor: SystemMouseCursors.forbidden,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            onPressed:
                                (isButtonDisabled == true) ? () {} : () {}),
                      ),
                    ],
                  );
                }
                if (_currentstate == 2) {
                  return Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: MaterialButton(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 32, vertical: 24),
                            child: Text("Dokument",
                                style: TextStyle(
                                    color: (isButtonDisabled == true)
                                        ? Colors.pink
                                        : Colors.grey)),
                            color: Colors.white,
                            mouseCursor: SystemMouseCursors.forbidden,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            onPressed:
                                (isButtonDisabled == true) ? () {} : () {}),
                      ),
                    ],
                  );
                }
                return const SizedBox.shrink();
              },
              steps: [
                Step(
                    isActive: (widget.businessplan == 0),
                    title: const Text(
                      'Vorstellung',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    content: const Text(
                      "Sobald Sie Ihr Projekt erstellt haben, eröffnet sich für Sie die Möglichkeit über dem „Chat“ mit uns über Ihr Projekt auszutauschen. In dem Chat können Sie uns auch Dateien zusenden lassen, damit wir diese in das Projekt implementieren können. Auch würden wir bevorzugen ein persönliches Gespräch mit Ihnen abzuhalten, da hiermit der Informationenaustausch in der Regel schneller und effizienter stattfindet. Hierzu gibt es heutzutage genügend Möglichkeiten, wie z.B Whatsapp, Zoom oder FaceTime. Dieser Schritt dient dazu, um genauere Details und Vorstellungen über das von Ihnen gewünschte Projekt zu erhalten. Gleichzeitig sollen Sie damit natürlich auch einen ersten Einblick in unsere Arbeitsweise bekommen, um damit eine vertrauliche Atmosphäre zwischen Ihnen und unseren Mitarbeitern zu schaffen.",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )),
                Step(
                    isActive: (widget.businessplan == 1),
                    title: const Text(
                      "Fertigung",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    content: const Text(
                      'Nach dem alle benötigten Details abgesprochen wurden, werden wir Ihnen Bescheid geben, wie viel Zeit die Fertigung des Projektes beanspruchen wird und wie hoch der finanzielle Aufwand ausfällt. Die benötigte Zeit kann in Abhängigkeit vom Umfang des Projektes stark variieren. In der Fertigungsphase können Sie sich über dem „Chat“ jederzeit an uns wenden, um etwaige Detailsänderungen oder weitere Ideen bzgl. des Projektes mit uns abzusprechen. Wir werden auch alle 24 Stunden den derzeitigen Stand des Projekts hochladen, was unter anderem Screenshots oder kurze Nachrichten sein können, welchen Sie sich unter dem Knopf „Projekt-Fortschritt“ ansehen können. Damit sind Sie in dem Fertigungsprozess mit eingebunden und wir können auf Ihre Ideen/ Vorschläge noch während der Fertigung reagieren.',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )),
                Step(
                    isActive: (widget.businessplan == 2),
                    title: const Text(
                      'Veröffentlichung',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    content: const Text(
                      'Das Projekt kann erst veröffentlicht werden, wenn Sie mit dem Produkt zufrieden sind und all Ihre Wünsche und Ideen implementiert wurden. Sobald wir von Ihnen eine schriftliche Zusage erhalten haben, können wir das Produkt auf allen von Ihnen geforderten Plattformen veröffentlichen. Das zur Veröffentlichung geforderte Dokument ist unter dem Knopf „Dokument“ einseh- und downloadbar.',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )),
                Step(
                    isActive: (widget.businessplan == 3),
                    title: const Text(
                      'Aktualisierung',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    content: const Text(
                      'Mit der Veröffentlichung geht die Arbeit an Ihrem Projekt weiter. Das Instandhalten und Aktualisieren Ihres Projekts übernimmt Novi für Sie. Wie gewohnt können Sie sich über dem „Chat“ bei uns melden und wir passen das Produkt Ihren Wünschen entsprechend an. Damit ist eine enge Zusammenarbeit auch nach der Veröffentlichung gesichert. ',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ))
              ],
              onStepTapped: (int newIndex) {
                setState(() {
                  _currentstate = newIndex;
                  if (widget.businessplan! > newIndex - 1) {
                    isButtonDisabled = true;
                  }
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
                  ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                          padding: const EdgeInsets.only(bottom: 10),
                          decoration:
                              const BoxDecoration(color: Colors.white70),
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
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
                              Map<String, dynamic> mes =
                                  messages[index].data()!;

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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                mes["sender"],
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                mes["time"].toString(),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                            ],
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
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                mes["sender"],
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                mes["time"].toString(),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey),
                                              ),
                                            ],
                                          ),
                                          Text(mes["content"]),
                                        ],
                                      )),
                                );
                              }
                            }),
                          )))),
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
                              "time":
                                  "${DateTime.now().hour}:${DateTime.now().minute}",
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
                                  "time":
                                      "${DateTime.now().hour}:${DateTime.now().minute}",
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
