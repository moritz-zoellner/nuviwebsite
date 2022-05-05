import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:noviwebsite/firebase_options.dart';
import 'package:noviwebsite/aboutus/aboutus.dart';
import 'package:noviwebsite/aboutus/blog.dart';
import 'package:noviwebsite/home/left_side.dart';
import 'package:noviwebsite/home/right_side.dart';
import 'package:noviwebsite/styling.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MaterialApp(
    scrollBehavior: MyCustomScrollBehavior(),
    localizationsDelegates: const [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    theme: ThemeData(
        textTheme: GoogleFonts.latoTextTheme(),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: Colors.pink,
            unselectedItemColor: Colors.grey.shade400)),
    localeResolutionCallback:
        (Locale? locale, Iterable<Locale> supportedLocales) => locale,
    title: "Novi Corp",
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
    return MyScaffold(
        child: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(40),
                child: LayoutBuilder(builder: (context, constraints) {
                  return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text("Novizon",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 40)),
                        const SizedBox(height: 80),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                flex: 3,
                                child: Center(
                                  child: ConstrainedBox(
                                      constraints:
                                          const BoxConstraints(maxWidth: 600),
                                      child: const LeftSide()),
                                )),
                            const Flexible(flex: 2, child: SizedBox()),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Flexible(flex: 2, child: SizedBox()),
                            Flexible(
                              flex: 3,
                              child: Center(
                                child: ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 600),
                                    child: const RightSide()),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 40),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                flex: 3,
                                child: Center(
                                    child: ConstrainedBox(
                                        constraints:
                                            const BoxConstraints(maxWidth: 600),
                                        child: const Projects()))),
                            const Flexible(flex: 2, child: SizedBox()),
                          ],
                        ),
                        const BlogScreen(),
                        const AboutUsScreen(),
                      ]);
                }))));
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
          children: const []),
    );
  }
}
