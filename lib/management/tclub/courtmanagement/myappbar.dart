import 'package:flutter/material.dart';
import 'package:noviwebsite/management/tclub/courtmanagement/courtmanagement.dart';
import 'package:noviwebsite/management/tclub/courtmanagement/mygrid.dart';

class MyAppBar extends StatelessWidget {
  final String name;
  const MyAppBar(this.name, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20, left: 20, right: 40),
        child: OverflowBar(
            alignment: MainAxisAlignment.spaceBetween,
            spacing: 40,
            overflowSpacing: 20,
            children: [
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.white)),
                  const SizedBox(width: 20),
                  Text(name,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 30)),
                ],
              ),
              TabBar(
                  physics: const NeverScrollableScrollPhysics(),
                  isScrollable: true,
                  tabs: List.generate(
                      DAYS_FOREWARD,
                      (index) => Tab(
                          text: dateToString(
                              DateTime.now().add(Duration(days: index))))))
            ]));
  }
}
