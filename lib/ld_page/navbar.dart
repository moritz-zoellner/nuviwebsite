import 'package:flutter/material.dart';

class DesktopNavBar extends StatelessWidget {
  const DesktopNavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      child: OverflowBar(
          overflowAlignment: OverflowBarAlignment.center,
          alignment: MainAxisAlignment.spaceBetween,
          children: const [
            Title(),
            Flexible(child: MenuBar()),
          ]),
    );
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
            Tab(text: "Products"),
            Tab(text: "Blog"),
            Tab(text: "About Us"),
            Tab(text: "Impressum"),
          ]),
    );
  }
}
