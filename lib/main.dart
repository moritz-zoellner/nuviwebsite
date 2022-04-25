import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noviwebsite/contact/contact.dart';
import 'package:noviwebsite/firebase_options.dart';
import 'package:noviwebsite/aboutus/aboutus.dart';
import 'package:noviwebsite/blog/blog.dart';
import 'package:noviwebsite/home/home.dart';
import 'package:noviwebsite/projects/projects.dart';
import 'package:noviwebsite/styling.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const String corpName = "Novi";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.pink,
            unselectedItemColor: Colors.grey.shade400)),
    localeResolutionCallback: (
      Locale? locale,
      Iterable<Locale> supportedLocales,
    ) {
      return locale;
    },
    title: corpName,
    home: const MyApp(),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: MyScaffold(
          child: NestedScrollView(
        headerSliverBuilder: (c, b) => [
          const SliverToBoxAdapter(child: MenuBar()),
        ],
        body: const TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              ProjectsScreen(),
              BlogScreen(),
              AboutUsScreen(),
              KontaktFormular(),
            ]),
      )),
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
            TabBar(isScrollable: true, tabs: [
              Tab(text: "Startseite"),
              Tab(text: "Produkte"),
              Tab(text: "Blog"),
              Tab(text: "Über uns"),
              Tab(text: "Kontakt"),
            ])
          ]),
    );
  }
}
