import 'package:flutter/material.dart';
import 'package:noviwebsite/ld_page/blog.dart';
import 'package:noviwebsite/ld_page/impressum.dart';

class DesktopLandingPage extends StatelessWidget {
  const DesktopLandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
            child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Expanded(child: LeftSide()),
              const SizedBox(width: 40),
              Expanded(child: Image.asset("assets/lp_image.png"))
            ])),
        const Center(child: Text("About us")),
        const ImpressumDescription(),
        const BlogScreen()
      ]),
    );
  }
}

class MobileLandingPage extends StatelessWidget {
  const MobileLandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
          TabBarView(physics: const NeverScrollableScrollPhysics(), children: [
        SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const LeftSide(),
                    const SizedBox(height: 40),
                    Image.asset("assets/lp_image.png")
                  ])),
        ),
        const Center(child: Text("About us")),
        const ImpressumDescription(),
        const BlogScreen()
      ]),
    );
  }
}

class LeftSide extends StatelessWidget {
  const LeftSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Software\nDevelopers",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white)),
          const SizedBox(height: 20),
          const Text(
              "Check out our already developed Apps.\nWant something personal? We create Apps for Web, IOS and Android on demand.",
              maxLines: 4,
              style: TextStyle(color: Colors.white, fontSize: 16)),
          const SizedBox(height: 20),
          Row(
            children: const [
              OurProductsButton(),
              SizedBox(width: 20),
              CreateAppButton()
            ],
          ),
          const SizedBox(height: 20),
        ]);
  }
}

class OurProductsButton extends StatelessWidget {
  const OurProductsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: const Text("Our Products", style: TextStyle(color: Colors.pink)),
        color: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        onPressed: () {});
  }
}

class CreateAppButton extends StatelessWidget {
  const CreateAppButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: const Text("Create App", style: TextStyle(color: Colors.white)),
        color: Colors.pink,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        onPressed: () {});
  }
}
