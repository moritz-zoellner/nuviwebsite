import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/contact/contact.dart';
import 'package:noviwebsite/firebase_options.dart';
import 'package:noviwebsite/aboutus/aboutus.dart';
import 'package:noviwebsite/blog/blog.dart';
import 'package:noviwebsite/home/home.dart';
import 'package:noviwebsite/projects/projects.dart';
import 'package:noviwebsite/styling.dart';

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
      child: MyScaffold(
          child: Column(children: const [
        MenuBar(),
        Expanded(
          child: TabBarView(physics: NeverScrollableScrollPhysics(), children: [
            HomeScreen(),
            ProjectsScreen(),
            BlogScreen(),
            AboutUsScreen(),
            KontaktFormular(),
          ]),
        )
      ])),
    );
  }
}

class MenuBar extends StatelessWidget {
  const MenuBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: OverflowBar(
          overflowAlignment: OverflowBarAlignment.center,
          alignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text("Novi Corp.",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 30)),
            TabBar(
                physics: NeverScrollableScrollPhysics(),
                isScrollable: true,
                tabs: [
                  Tab(text: "Home"),
                  Tab(text: "Products"),
                  Tab(text: "Blog"),
                  Tab(text: "About Us"),
                  Tab(text: "Contact"),
                ])
          ]),
    );
  }
}
