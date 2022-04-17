import 'package:flutter/material.dart';
import 'package:noviwebsite/aboutus/novi.dart';
import 'package:noviwebsite/aboutus/tile.dart';

import 'history.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(minHeight: 400),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 60, vertical: 40),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Expanded(child: AboutNoviDescription()),
                          SizedBox(width: 40),
                          Expanded(child: OurHistoryDescription())
                        ])),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Unser Team",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.white)),
                ),
                Center(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.only(
                        left: 24, right: 24, top: 8, bottom: 8),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          AboutUsTile("Moritz Zöllner", Icons.person,
                              MoritzDescription()),
                          AboutUsTile("Vadime Novikau", Icons.person,
                              VadimeDescription()),
                          AboutUsTile("Denis Novikau", Icons.person,
                              DenisDescription()),
                        ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

