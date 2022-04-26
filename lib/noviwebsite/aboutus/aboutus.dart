import 'package:flutter/material.dart';
import 'package:noviwebsite/noviwebsite/aboutus/novi.dart';
import 'package:noviwebsite/noviwebsite/aboutus/tile.dart';

import 'history.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 400),
            child: Column(children: [
              Padding(
                  padding: const EdgeInsets.all(20),
                  child: Wrap(spacing: 20, children: [
                    const SizedBox(width: 400, child: AboutNoviDescription()),
                    const SizedBox(width: 400, child: OurHistoryDescription()),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Team",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 40,
                                color: Colors.white)),
                        AboutUsTile(
                            "Denis Novikau", Icons.person, DenisDescription()),
                      ],
                    ),
                  ])),
            ])),
      ),
    );
  }
}
