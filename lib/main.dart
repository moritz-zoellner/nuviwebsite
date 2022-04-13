import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/firebase_options.dart';
import 'package:noviwebsite/placeOrder.dart';
import 'OfferContent.dart';
import 'signIn.dart';

const String corpName = "Novi";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const CupertinoApp(
    title: corpName,
    debugShowCheckedModeBanner: false,
    home: HomeScreen(),
  ));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class NoviButton {
  final String text;
  final Widget child;

  NoviButton(this.text, this.child);
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  List<NoviButton> buttons = [
    NoviButton("Blog", const Center(child: Text("Blog"))),
    NoviButton("Projekte", const ProjectsScreen()),
    NoviButton("Kontakt", const Center(child: Text("Kontakt"))),
    NoviButton("Über uns", const Center(child: Text("Über uns"))),
    NoviButton("Impressum", const Center(child: Text("Impressum"))),
  ];
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        backgroundColor: CupertinoColors.systemGrey6,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              child: SizedBox(
                width: 150,
                child: Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset("assets/novi_logo.png"),
                        const SizedBox(height: 16),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: List.generate(
                                buttons.length,
                                (index) => Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 16),
                                      child: CupertinoButton(
                                          padding: const EdgeInsets.only(
                                              left: 16, right: 16),
                                          color: (index != currentIndex)
                                              ? CupertinoColors.systemFill
                                              : CupertinoColors.activeBlue,
                                          child: Text(buttons[index].text),
                                          onPressed: (index != currentIndex)
                                              ? () => setState(
                                                  () => currentIndex = index)
                                              : () {}),
                                    ))),
                      ]),
                ),
              ),
            ),
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: 16,
                          bottom: 16,
                          left: MediaQuery.of(context).size.width / 2 - 180),
                      child: const Text(
                        corpName,
                        style: TextStyle(fontSize: 24),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        decoration: const BoxDecoration(
                            borderRadius:
                                BorderRadius.only(topLeft: Radius.circular(16)),
                            color: CupertinoColors.systemBackground,
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 0.1,
                                  blurRadius: 10,
                                  color: CupertinoColors.systemGrey3)
                            ]),
                        child: buttons[currentIndex].child,
                      ),
                    )
                  ]),
            ),
          ],
        ));
  }
}

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class Project extends StatelessWidget {
  final String title;
  final String content;
  final Widget child;
  const Project(this.title, this.content, this.child);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Text("Details",
                  style:
                      CupertinoTheme.of(context).textTheme.navTitleTextStyle)),
          Padding(
            padding:
                const EdgeInsets.only(left: 32, right: 32, top: 16, bottom: 16),
            child: NoviTile(Text(content,
                textAlign: TextAlign.justify,
                style: CupertinoTheme.of(context).textTheme.textStyle)),
          ),
          SizedBox(
            height: 300,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(
                            left: 32, right: 32, bottom: 16),
                        child: Text("Platformen",
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .navTitleTextStyle)),
                    Expanded(
                      child: NoviTile(Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(CupertinoIcons.check_mark_circled),
                          const SizedBox(height: 8),
                          Text("IOS",
                              textAlign: TextAlign.center,
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle),
                          const SizedBox(height: 16),
                          const Icon(CupertinoIcons.check_mark_circled),
                          const SizedBox(height: 8),
                          Text("Android",
                              textAlign: TextAlign.center,
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle),
                          const SizedBox(height: 16),
                          const Icon(CupertinoIcons.check_mark_circled),
                          const SizedBox(height: 8),
                          Text("Web",
                              textAlign: TextAlign.center,
                              style: CupertinoTheme.of(context)
                                  .textTheme
                                  .textStyle),
                        ],
                      )),
                    ),
                    const SizedBox(height: 16)
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Screenshots",
                          style: CupertinoTheme.of(context)
                              .textTheme
                              .navTitleTextStyle),
                      Expanded(
                        child: Row(
                          children: List.generate(
                              6,
                              (index) => Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.all(16),
                                      decoration: BoxDecoration(
                                          image: const DecorationImage(
                                              fit: BoxFit.cover,
                                              image: NetworkImage(
                                                "https://appradar.com/wp-content/uploads/nyt-cooking-apple-screenshots-1024x768.png",
                                              )),
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                    ),
                                  )),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 32)
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  int currentTab = 0;

  List<Project> tabs = [
    const Project(
      "Tclub",
      "Eine App für Tennisclubs, welche die Verwaltung von Plätzen und Mitgliedern übernimmt. Dadurch werden viele Vorgänge sowohl für Spieler als auch für Organisatoren drastisch vereinfacht. Tclub ist DER Schritt in Richtung Digitalisierung für Tennisclubs. Einfach. Innovativ. Günstig. Die zentralisierte Verwaltung von Benutzerdaten garantiert einen sicheren und zuverlässigen Umgang und ermöglicht auch anstrebenden Tennisspielern einen komfortablen und schnellen Einstieg in den ersten Club.",
      TClub(),
    ),
    const Project(
      "Tcount",
      "Eine App für das mitzählen des Spielstandes. Mit vielen anschaulichen Statistiken kann eine besonders gute Auswertung des Spiels vorgenommen werden.",
      Tcount(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    if (currentTab == -1) {
      return projectList();
    }
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150,
              child: CupertinoButton(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.all(16),
                  child: const Icon(CupertinoIcons.back),
                  onPressed: () => setState(() => currentTab = -1)),
            ),
            Text(
              tabs[currentTab].title,
              style: CupertinoTheme.of(context).textTheme.navTitleTextStyle,
            ),
            SizedBox(
              width: 150,
              child: CupertinoButton(
                  alignment: Alignment.topRight,
                  padding: const EdgeInsets.all(16),
                  child: const Text("Anmelden"),
                  onPressed: () => showCupertinoDialog(
                      context: context,
                      builder: (_) {
                        TextEditingController emailController =
                            TextEditingController();
                        TextEditingController passwController =
                            TextEditingController();
                        return CupertinoAlertDialog(
                          title: const Text("Anmelden"),
                          content: Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: NoviTile(
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CupertinoTextField.borderless(
                                    placeholder: "Email",
                                    controller: emailController,
                                    prefix: const Icon(CupertinoIcons.mail),
                                  ),
                                  const SizedBox(height: 16),
                                  CupertinoTextField.borderless(
                                    obscureText: true,
                                    placeholder: "Passwort",
                                    controller: passwController,
                                    prefix: const Icon(CupertinoIcons.lock),
                                  )
                                ],
                              ),
                            ),
                          ),
                          actions: [
                            CupertinoDialogAction(
                              child: const Text("Zurück"),
                              onPressed: () => Navigator.pop(context),
                            ),
                            CupertinoDialogAction(
                                child: const Text("Passwort vergessen"),
                                onPressed: () => showCupertinoDialog(
                                    context: context,
                                    builder: (_) {
                                      TextEditingController emailController =
                                          TextEditingController();
                                      return CupertinoAlertDialog(
                                        title: const Text("Passwort vergessen"),
                                        content: Padding(
                                            padding:
                                                const EdgeInsets.only(top: 16),
                                            child: NoviTile(
                                                CupertinoTextField.borderless(
                                                    placeholder: "Email",
                                                    controller: emailController,
                                                    prefix: const Icon(
                                                        CupertinoIcons.mail)))),
                                        actions: [
                                          CupertinoDialogAction(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text("Zurück")),
                                          CupertinoDialogAction(
                                              onPressed: () {
                                                FirebaseAuth.instance
                                                    .sendPasswordResetEmail(
                                                        email: emailController
                                                            .text)
                                                    .then((value) => myCustomError(
                                                        context,
                                                        "Email wurde geschickt"))
                                                    .catchError((onError) => {
                                                          myCustomError(
                                                              context,
                                                              onError
                                                                  .toString()
                                                                  .split("]")
                                                                  .last)
                                                        });
                                              },
                                              child:
                                                  const Text("Passwort senden"))
                                        ],
                                      );
                                    })),
                            CupertinoDialogAction(
                              child: const Text("Anmelden"),
                              onPressed: () {
                                String email = emailController.text;
                                String password = passwController.text;
                                if (invalidMailAdress(email)) {
                                  //ungültige Mail
                                  myCustomError(
                                      context, 'Ungültige Mailadresse');
                                } else if (invalidPW(password)) {
                                  //ungültiges Passwort
                                  myCustomError(context, 'Ungültiges Passwort');
                                } else {
                                  // einfügen der Daten in firebase
                                  Future<bool> success =
                                      signIn(email, password);
                                  waitDialog(context);
                                  success.then((success) {
                                    Navigator.pop(context);
                                    if (success) {
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          CupertinoPageRoute(
                                              builder: (_) => const TClub()),
                                          (route) => false);
                                    } else {
                                      myCustomError(
                                          context, 'Ungültige Anmeldedaten');
                                    }
                                  });
                                }
                              },
                            )
                          ],
                        );
                      })),
            ),
          ],
        ),
        Expanded(child: tabs[currentTab]),
      ],
    );
  }

  Widget projectList() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Wrap(
        children: List.generate(
          tabs.length,
          (index) => Padding(
            padding: const EdgeInsets.all(8),
            child: NoviTile(ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tabs[index].title,
                    style:
                        CupertinoTheme.of(context).textTheme.navTitleTextStyle,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Text(
                      tabs[index].content,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: CupertinoTheme.of(context).textTheme.textStyle,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CupertinoButton(
                        padding: const EdgeInsets.all(16),
                        child: const Text("Weiteres"),
                        onPressed: () => setState(() => currentTab = index)),
                  ),
                ],
              ),
            )),
          ),
        ),
      ),
    );
  }
}

class Tcount extends StatelessWidget {
  const Tcount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [Text("Tcourt kommt bald raus")],
    );
  }
}

class TClub extends StatelessWidget {
  const TClub({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool signedIn = FirebaseAuth.instance.currentUser != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        signedIn
            ? Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 32, left: 16, right: 16, bottom: 16),
                      child: Text(
                        "Ihre Buchungen",
                        style: CupertinoTheme.of(context)
                            .textTheme
                            .navLargeTitleTextStyle,
                      ),
                    ),
                    FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                        future: FirebaseFirestore.instance
                            .collection("clubs")
                            .where("user-Email",
                                isEqualTo:
                                    FirebaseAuth.instance.currentUser!.email)
                            .get(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                                child: CupertinoActivityIndicator());
                          }
                          List<DocumentSnapshot<Map<String, dynamic>>>
                              listOfClubs = snapshot.data!.docs;
                          if (listOfClubs.isEmpty) {
                            return const Padding(
                              padding: EdgeInsets.only(left: 64, right: 64),
                              child: Text(
                                  "Hier stehen bald ihre Buchungen. Starten Sie jetzt."),
                            );
                          }
                          return GridView.builder(
                              shrinkWrap: true,
                              itemCount: listOfClubs.length,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                      maxCrossAxisExtent: 1000,
                                      mainAxisExtent: 200),
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: NoviTile(SizedBox(
                                    height: 100,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        Image.network(
                                          listOfClubs[index].data()!["logo"],
                                          width: 100,
                                        ),
                                        Expanded(
                                          child: Padding(
                                              padding: const EdgeInsets.all(16),
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.stretch,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Text(listOfClubs[index].id,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 28)),
                                                  Text(
                                                    listOfClubs[index]
                                                        .data()!["abo"],
                                                  ),
                                                ],
                                              )),
                                        ),
                                        Align(
                                            alignment: Alignment.bottomRight,
                                            child: CupertinoButton(
                                              padding: EdgeInsets.zero,
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: const [
                                                  Text("Verwalten"),
                                                  Icon(CupertinoIcons.forward)
                                                ],
                                              ),
                                              onPressed: () => print(
                                                  "Hier ist die AdminApp"),
                                            )),
                                      ],
                                    ),
                                  )),
                                );
                              });
                        }),
                    // const Padding(
                    //   padding: EdgeInsets.only(top: 32, left: 16, right: 16),
                    //   child: Divider(
                    //     height: 0,
                    //     thickness: 2,
                    //     color: CupertinoColors.systemBlue,
                    //   ),
                    // ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
        Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: Text("Unsere Angebote",
                style: CupertinoTheme.of(context).textTheme.navTitleTextStyle)),
        Center(
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.only(left: 24, right: 24, top: 8, bottom: 8),
            scrollDirection: Axis.horizontal,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Tile("Plätzeverwaltung", const CourtPrice(),
                      CupertinoIcons.person, CourtDescription(), () {}),
                  Tile("Mitgliederverwaltung", const MemberPrice(),
                      CupertinoIcons.person, const MemberDescription(), () {}),
                  Tile("Plätze- & Mitgliederverwaltung", const BothPrice(),
                      CupertinoIcons.person, const BothDescription(), () {}),
                ]),
          ),
        ),
      ],
    );
  }
}

class Tile extends StatelessWidget {
  final String name;
  final Widget price;
  final IconData data;
  final Widget content;
  final void Function() onOrder;
  const Tile(this.name, this.price, this.data, this.content, this.onOrder,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxHeight: 440, maxWidth: 400),
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            color: CupertinoColors.systemGroupedBackground),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name,
                textAlign: TextAlign.center,
                style: CupertinoTheme.of(context).textTheme.navTitleTextStyle),
            const SizedBox(height: 16),
            content,
            Expanded(
              child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
                price,
                Flexible(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: CupertinoButton(
                      alignment: Alignment.bottomRight,
                      padding: EdgeInsets.zero,
                      child: const Text("Jetzt kaufen"),
                      onPressed: () {
                        Widget helper;
                        switch (name) {
                          case ("Plätzeverwaltung"):
                            helper = const CourtOrder();
                            break;
                          case ("Mitgliederverwaltung"):
                            helper = const MemberOrder();
                            break;
                          case ("Plätze- & Mitgliederverwaltung"):
                            helper = const BothOrder();
                            break;
                          default:
                            return;
                        }
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (context) => helper));
                      },
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}
