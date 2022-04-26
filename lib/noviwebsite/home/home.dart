import 'package:flutter/material.dart';
import 'package:noviwebsite/noviwebsite/home/left_side.dart';
import 'package:noviwebsite/noviwebsite/home/right_side.dart';

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
              RightSide()
            ]);
      } else {
        page = Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
              Expanded(child: LeftSide()),
              SizedBox(width: 40),
              Expanded(child: RightSide())
            ]),
            
          ],
        );
      }
      return Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: page,
          ),
        ),
      );
    });
  }
}
