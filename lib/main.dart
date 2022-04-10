import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/firebase_options.dart';
import 'package:noviwebsite/placeOrder.dart';
import 'OfferContent.dart';
import 'signIn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const CupertinoApp(
      title: 'Novi Website',
      debugShowCheckedModeBanner: false,
      theme: CupertinoThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatelessWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool signedIn = FirebaseAuth.instance.currentUser != null;
    return CupertinoPageScaffold(
        child: CustomScrollView(slivers: [
      CupertinoSliverNavigationBar(
          largeTitle: const Text("Novi Corp"),
          trailing: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Text(signedIn ? "Abmelden" : "Anmelden"),
            onPressed: () async {
              Widget helper;
              if (signedIn) {
                await FirebaseAuth.instance.signOut();
                helper = const MyHome();
              } else {
                helper = const LoginScreen();
              }
              Navigator.push(
                  context, CupertinoPageRoute(builder: ((context) => helper)));
            },
          )),
      SliverList(
          delegate: SliverChildListDelegate([
        signedIn
            ? Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    const Padding(
                      padding: EdgeInsets.only(top: 32, left: 16, right: 16),
                      child: Divider(
                        height: 0,
                        thickness: 2,
                        color: CupertinoColors.systemBlue,
                      ),
                    ),
                  ],
                ),
              )
            : const SizedBox.shrink(),
        Padding(
          padding: const EdgeInsets.only(top: 32, left: 32, right: 32),
          child: Text(
            "Tclub",
            style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 32, left: 64, right: 64),
          child: Text(
            "Tclub ist eine App für Tennisclubs, welche die Verwaltung von Plätzen und Mitgliedern übernimmt. Dadurch werden viele Vorgänge sowohl für Spieler als auch für Organisatoren drastisch vereinfacht. Tclub ist DER Schritt in Richtung Digitalisierung für Tennisclubs. Einfach. Innovativ. Günstig. Die zentralisierte Verwaltung von Benutzerdaten garantiert einen sicheren und zuverlässigen Umgang und ermöglicht auch anstrebenden Tennisspielern einen komfortablen und schnellen Einstieg in den ersten Club.",
            style: CupertinoTheme.of(context).textTheme.textStyle,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 32, left: 32, right: 32),
          child: Divider(
            height: 0,
            thickness: 2,
            color: CupertinoColors.systemBlue,
          ),
        ),
        const Padding(
          padding: EdgeInsets.only(top: 32, left: 32, right: 32),
          child: Text("Unsere Angebote", style: TextStyle(fontSize: 28)),
        ),
      ])),
      SliverPadding(
        padding: const EdgeInsets.all(16),
        sliver: SliverGrid(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 1000, mainAxisExtent: 500),
          delegate: SliverChildListDelegate([
            Tile("Plätzeverwaltung", const CourtPrice(), CupertinoIcons.person,
                CourtDescription(), () {}),
            Tile("Mitgliederverwaltung", const MemberPrice(),
                CupertinoIcons.person, const MemberDescription(), () {}),
            Tile("Plätze- & Mitgliederverwaltung", const BothPrice(),
                CupertinoIcons.person, const BothDescription(), () {}),
          ]),
        ),
      ),
    ]));
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
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(
                blurRadius: 10,
                spreadRadius: 0.2,
                color: CupertinoColors.systemGrey3)
          ],
          borderRadius: BorderRadius.all(Radius.circular(16)),
          color: CupertinoColors.systemGrey6),
      child: Column(children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(name,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 28, fontWeight: FontWeight.bold)),
                  ),
                  content,
                ],
              ),
            ),
          ),
        ),
        Row(children: [
          const SizedBox(width: 16),
          price,
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.bottomRight,
                child: CupertinoButton.filled(
                  padding: const EdgeInsets.all(16),
                  child: const Text("Jetzt kaufen"),
                  onPressed: () {
                    Widget helper;
                    if (FirebaseAuth.instance.currentUser != null) {
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
                          helper = const LoginScreen();
                      }
                    } else {
                      helper = const LoginScreen();
                    }
                    Navigator.push(context,
                        CupertinoPageRoute(builder: (context) => helper));
                  },
                ),
              ),
            ),
          ),
        ]),
      ]),
    );
  }
}
