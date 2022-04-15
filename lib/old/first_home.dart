import 'package:flutter/cupertino.dart';
import 'package:noviwebsite/ld_page/blog.dart';
import 'package:noviwebsite/old/projects.dart';
import 'package:noviwebsite/old/startseite.dart';

class NoviButton {
  final String text;
  final Widget child;

  const NoviButton(this.text, this.child);
}

class HomeScreen extends StatelessWidget {
  final List<NoviButton> buttons = const [
    NoviButton("Startseite", StartScreen()),
    NoviButton("Über", Center(child: Text("Über"))),
    NoviButton("Projekte", ProjectsScreen()),
    NoviButton("Blog", BlogScreen()),
    NoviButton("Kontakt", Center(child: Text("Kontakt"))),
    NoviButton("Impressum", Center(child: Text("Impressum"))),
    NoviButton("Datenschutz", Center(child: Text("Datenschutz"))),
  ];

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      backgroundColor: CupertinoColors.darkBackgroundGray,
      tabBar: CupertinoTabBar(
          backgroundColor: CupertinoColors.darkBackgroundGray,
          items: List.generate(
              buttons.length,
              (index) => BottomNavigationBarItem(
                  activeIcon: Text(buttons[index].text,
                      style: const TextStyle(
                          color: CupertinoColors.white, fontSize: 16)),
                  icon: Text(buttons[index].text,
                      style: const TextStyle(
                          color: CupertinoColors.systemGrey6, fontSize: 14))))),
      tabBuilder: (_, index) => CupertinoTabView(
          builder: (context) => ClipRRect(
              borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16)),
              child: CupertinoPageScaffold(child: buttons[index].child))),
    );
  }
}
