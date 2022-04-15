import 'package:flutter/material.dart';

class DesktopNavBar extends StatelessWidget {
  const DesktopNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          const Title(),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: const [
                MenuBar(),
              ],
            ),
          ),
        ]));
  }
}

class MobileNavBar extends StatelessWidget {
  const MobileNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          const Title(),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [MenuBar()],
          ),
        ]));
  }
}

class Title extends StatelessWidget {
  const Title({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text("Novi Corp.",
        style: TextStyle(
            fontWeight: FontWeight.bold, color: Colors.white, fontSize: 30));
  }
}

class MenuBar extends StatelessWidget {
  const MenuBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Flexible(
      child: TabBar(
          physics: NeverScrollableScrollPhysics(),
          isScrollable: true,
          tabs: [
            Tab(text: "Home"),
            Tab(text: "About Us"),
            Tab(text: "Impressum"),
            Tab(text: "Blog"),
          ]),
    );
  }
}
