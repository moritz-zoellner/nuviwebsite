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
            ]);
      } else {
        page = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Expanded(child: LeftSide()),
              SizedBox(width: 40),
              Expanded(child: RightSide())
            ]);
      }
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(minHeight: 400),
              child: SingleChildScrollView(
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 40),
                    child: page),
              ),
            ),
          ),
          const SecureMenu()
        ],
      );
    });
  }
}
