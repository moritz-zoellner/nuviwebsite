import 'package:flutter/material.dart';

class TermsDescription extends StatelessWidget {
  const TermsDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(20),
            child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Scaffold(
                        body: SingleChildScrollView(
                            child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Row(children: [
                                        IconButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            icon: const Icon(Icons.close)),
                                        const SizedBox(width: 20),
                                        const Text("Terms",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30)),
                                      ]),
                                      SingleChildScrollView(
                                          child: Center(
                                              child: Container(
                                                  margin:
                                                      const EdgeInsets.all(20),
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxWidth: 800),
                                                  child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: []))))
                                    ]))))))));
  }
}