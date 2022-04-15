import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Image.asset(
          "assets/novi_logo.png",
          width: 400,
          height: 400,
        ),
        Text(
          "Hallo, wir sind Novi.",
          textAlign: TextAlign.center,
          style: CupertinoTheme.of(context).textTheme.navLargeTitleTextStyle,
        ),
        const Divider(),
        Container(
          child: Row(
            children: [
              Text("Datenschutz"),
              Text("Bedingungen"),
              Text("")
            ],
          ),
        )
      ],
    );
  }
}
