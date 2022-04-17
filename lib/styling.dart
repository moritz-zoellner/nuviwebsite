import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoviTile extends StatelessWidget {
  final Widget child;
  const NoviTile(this.child, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
          color: Colors.white54,
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: child,
    );
  }
}

Future waitDialog(BuildContext context) {
  return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black26,
      pageBuilder: (context, a1, a2) =>
          const Center(child: CircularProgressIndicator()));
}

void closeDialog(context) {
  return Navigator.pop(context);
}

void myCustomError(context, content) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(content),
      action: SnackBarAction(
          label: "Verstanden",
          onPressed: () => ScaffoldMessenger.of(context).clearSnackBars())));
}

class MyBlueButton extends StatelessWidget {
  final Function()? onPressed;
  final String title;

  const MyBlueButton(this.title, {Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: Text(title, style: const TextStyle(color: Colors.white)),
        color: Colors.blue,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        onPressed: onPressed);
  }
}

class MyScaffold extends StatelessWidget {
  final Widget? child;
  final Widget? bBar;
  const MyScaffold({this.child, Key? key, this.bBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: bBar,
        body: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.pink, Colors.blue],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight)),
            child: child));
  }
}

class ProjectCheckMark extends StatelessWidget {
  final String text;
  const ProjectCheckMark(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 3, bottom: 3),
      child: Row(children: [
        const Icon(Icons.check_circle_outline_rounded, color: Colors.green),
        const SizedBox(width: 10),
        Flexible(child: Text(text))
      ]),
    );
  }
}
