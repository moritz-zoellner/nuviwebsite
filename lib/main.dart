import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/firebase_options.dart';
import 'package:noviwebsite/ld_page/ld_page.dart';
import 'package:noviwebsite/ld_page/navbar.dart';
import 'package:noviwebsite/old/signIn.dart';

const String corpName = "Novi";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MaterialApp(
    title: corpName,
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.pink, Colors.blue],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight)),
            child: SingleChildScrollView(
              child: LayoutBuilder(builder: (context, constraints) {
                if (constraints.maxWidth < 800) {
                  return ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height),
                    child: Column(children: const [
                      MobileNavBar(),
                      MobileLandingPage(),
                    ]),
                  );
                } else {
                  return ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height),
                      child: Column(children: const [
                        DesktopNavBar(),
                        DesktopLandingPage(),
                      ]));
                }
              }),
            ),
          ),
        ));
  }
}
