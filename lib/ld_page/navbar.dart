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
                SizedBox(width: 30),
                RegistrierenButton(),
                SizedBox(width: 10),
                AnmeldenButton()
              ],
            ),
          ),
        ]));
  }
}

class RegistrierenButton extends StatelessWidget {
  const RegistrierenButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
        //padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: const Text("Sign Up",
            style: TextStyle(color: Colors.white, fontSize: 14)),
        //color: Colors.pink,
        //shape: const RoundedRectangleBorder(
        //    borderRadius: BorderRadius.all(Radius.circular(16))),
        onPressed: () {});
  }
}

class AnmeldenButton extends StatelessWidget {
  const AnmeldenButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: const Text("Sign In", style: TextStyle(color: Colors.white)),
        color: Colors.pink,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        onPressed: () {});
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
            children: const [MenuBar(), SizedBox(width: 20), AnmeldenButton()],
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
