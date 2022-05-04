import 'package:flutter/material.dart';
import 'package:noviwebsite/home/left_side.dart';
import 'package:noviwebsite/home/right_side.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(40),
            child: LayoutBuilder(builder: (context, constraints) {
              // if (constraints.maxWidth < 800) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 3,
                            child: Center(
                              child: ConstrainedBox(
                                  constraints:
                                      const BoxConstraints(maxWidth: 600),
                                  child: const LeftSide()),
                            )),
                        const Flexible(flex: 2, child: SizedBox()),
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Flexible(flex: 2, child: SizedBox()),
                        Flexible(
                          flex: 3,
                          child: Center(
                            child: ConstrainedBox(
                                constraints:
                                    const BoxConstraints(maxWidth: 600),
                                child: const RightSide()),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            flex: 3,
                            child: Center(
                                child: ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 600),
                                    child: const Projects()))),
                        const Flexible(flex: 2, child: SizedBox()),
                      ],
                    ),
                  ]);
/*              } else {
                return Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Expanded(child: LeftSide()),
                      SizedBox(width: 40),
                      Expanded(child: RightSide()),
                      SizedBox(width: 40),
                      Expanded(child: Projects())
                    ]);
              }*/
            })));
  }
}
