import 'package:flutter/material.dart';
import 'package:noviwebsite/home/left_side.dart';
import 'package:noviwebsite/home/right_side.dart';
import 'package:noviwebsite/impressum/secure_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      Widget page;
      if (constraints.maxWidth < 800) {
        page = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              LeftSide(),
              SizedBox(height: 40),
              RightSide(),
              SizedBox(height: 40),
              SecureMenu()
            ]);
      } else {
        page = Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Expanded(child: LeftSide()),
              SizedBox(width: 40),
              Expanded(child: RightSide())
            ]),
            const SizedBox(height: 40),
            const SecureMenu()
          ],
        );
      }
      return SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 400),
              child: page,
            ),
          ),
        ),
      );
    });
  }
}
