import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noviwebsite/firebase_options.dart';
import 'package:noviwebsite/aboutus/aboutus.dart';
import 'package:noviwebsite/aboutus/blog.dart';
import 'package:noviwebsite/home/home.dart';
import 'package:noviwebsite/projects/projects.dart';
import 'package:noviwebsite/styling.dart';

const String corpName = "Novi";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    scrollBehavior: MyCustomScrollBehavior(),
    theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.pink,
            unselectedItemColor: Colors.grey.shade400)),
    localeResolutionCallback:
        (Locale? locale, Iterable<Locale> supportedLocales) => locale,
    title: corpName,
    home: const MyApp(),
  ));
}

class MyCustomScrollBehavior extends MaterialScrollBehavior {
  // Override behavior methods and getters like dragDevices
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: MyScaffold(
            child: NestedScrollView(
                headerSliverBuilder: (c, b) =>
                    [const SliverToBoxAdapter(child: MenuBar())],
                body: const TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      HomeScreen(),
                      ProjectsScreen(),
                      BlogScreen(),
                      AboutUsScreen(),
                    ]))));
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
            TabBar(isScrollable: true, tabs: [
              Tab(text: "Startseite"),
              Tab(text: "Produkte"),
              Tab(text: "Blog"),
              Tab(text: "Über uns"),
            ])
          ]),
    );
  }
}
