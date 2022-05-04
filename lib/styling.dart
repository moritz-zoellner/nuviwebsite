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

Widget waitWidget() =>
    const Center(child: CircularProgressIndicator.adaptive());

Widget errorWidget() => const Center(child: Text("Fehler aufgetreten"));

Future waitDialog(BuildContext context) {
  return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black26,
      pageBuilder: (context, a1, a2) =>
          const Center(child: CircularProgressIndicator.adaptive()));
}

void closeDialog(context) {
  return Navigator.pop(context);
}

void myCustomError(context, content) {
  ScaffoldMessenger.of(context).clearSnackBars();
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      content: Text(content),
      action: SnackBarAction(
          label: "Ok",
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

String inputControl(
    {String? email,
    String? passw,
    String? clubName,
    String? phone,
    String? hoursPerWeek,
    List<List<TextEditingController>>? aboList,
    List<TextEditingController>? allCourts,
    bool? beitragsOrdnung}) {
  if (email != null) {
    if (invalidMailAdress(email)) {
      return "Ungültige E-Mail Adresse";
    }
  }

  if (passw != null) {
    if (invalidPW(passw)) {
      return "Ungültiges Passwort";
    }
  }

  if (clubName != null) {
    if (clubName.trim().isEmpty) {
      return "Clubname darf nicht leer sein";
    }
  }

  if (phone != null) {
    if (invalidPhoneNumber(phone)) {
      return "Ungültige Telefonnummer";
    }
  }

  if (hoursPerWeek != null) {
    if (!isNumber(hoursPerWeek)) {
      return "Ungültige wöchentliche Stundenanzahl";
    }
  }

  if (allCourts != null) {
    if (allCourts.isEmpty) {
      return "Es müssen Plätze angegeben werden";
    } else {
      for (TextEditingController cons in allCourts) {
        if (cons.text.isEmpty) {
          return "Die Felder dürfen nicht leer sein";
        }
      }
    }
  }

  if (aboList != null) {
    if (aboList.isEmpty) {
      return "Es müssen Abos und deren Preise angegeben werden";
    } else {
      for (List<TextEditingController> cons in aboList) {
        if (cons[0].text.isEmpty) {
          return "Die Felder dürfen nicht leer sein";
        }
        if (cons[1].text.isEmpty) {
          return "Die Felder dürfen nicht leer sein";
        } else if (!isNumber(cons[1].text)) {
          return "Die Preise müssen Zahlen sein";
        }
      }
    }
  }

  if (beitragsOrdnung != null) {
    if (!beitragsOrdnung) {
      return "Die Beitragsordnung muss hochgeladen werden";
    }
  }

  return "valid";
}

bool invalidMailAdress(String data) {
  return !RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(data);
}

bool invalidPW(String data) {
  if (data.length >= 6) {
    return false;
  }
  return true;
}

bool isNumber(String data) {
  return double.tryParse(data.replaceAll(",", ".")) != null;
}

bool invalidPhoneNumber(String data) {
  data = data.replaceAll(" ", "");
  if (data.isEmpty) {
    return true;
  }
  for (var i = 0; i < data.length; i++) {
    if (!(isNumber(data[i]) || data[i] == '+')) {
      return true;
    }
  }
  return false;
}
