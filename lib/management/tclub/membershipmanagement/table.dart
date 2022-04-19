import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:horizontal_data_table/horizontal_data_table.dart';
import 'package:noviwebsite/management/tclub/membershipmanagement/membershipmanagement.dart';
import 'package:noviwebsite/styling.dart';

class MyTable extends StatefulWidget {
  final String uid;
  bool editUsers, addUser;
  List<ChangedField> fields;
  MyTable(this.uid, this.editUsers, this.addUser, this.fields, {Key? key})
      : super(key: key);
  static const int sortName = 0;
  static const int sortStatus = 1;

  @override
  State<MyTable> createState() => _TableState();
}

class _TableState extends State<MyTable> {
  final List<String> keys = const [
    "Email", //
    "Nachname", //
    "Vorname", //
    "Geburtstag", //
    "Geburtsort", //
    "Straße", //
    "PLZ", //
    "Wohnort", //
    "Telefon", //
    "Abo", //
    "Geldinstitut", //
    "IBAN", //
    "Kontoinhaber", //
    "Beitrag", //
    "Zahlungsmethode", //
    "Bezahlt", //
  ];

  String sortQuery = "Uid";
  bool ascending = true;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection("tclub")
          .doc(widget.uid)
          .collection("users")
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        List<DocumentSnapshot<Map<String, dynamic>>> list = snapshot.data!.docs;

        list.sort((a, b) {
          String valA, valB;
          if (sortQuery == "Uid") {
            valA = a.id;
            valB = b.id;
          } else {
            valA = a.data()![sortQuery].toString();
            valB = b.data()![sortQuery].toString();
          }

          return (ascending) ? valB.compareTo(valA) : valA.compareTo(valB);
        });
        try {
          return HorizontalDataTable(
              leftHandSideColumnWidth: 160,
              rightHandSideColumnWidth: keys.length * 220,
              isFixedHeader: true,
              headerWidgets: List.generate(
                  keys.length + 1,
                  (index) => SizedBox(
                      width: 220,
                      child: TextButton(
                          onPressed: () => setState(() {
                                sortQuery =
                                    (index == 0) ? "Uid" : keys[index - 1];
                                ascending = !ascending;
                              }), // order
                          child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(((index == 0) ? "Uid" : keys[index - 1]),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  (sortQuery ==
                                          ((index == 0)
                                              ? "Uid"
                                              : keys[index - 1]))
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Icon(
                                            ascending
                                                ? Icons.arrow_upward_rounded
                                                : Icons.arrow_downward_rounded,
                                            size: 16,
                                          ),
                                        )
                                      : const SizedBox.shrink()
                                ],
                              ))))),
              leftSideItemBuilder: (context, index) {
                return SizedBox(
                    width: 160,
                    height: 40,
                    child: (index != list.length)
                        ? (!widget.editUsers)
                            ? TextField(
                                style: const TextStyle(fontSize: 14),
                                decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.only(right: 8, left: 8),
                                    enabled: false),
                                controller: TextEditingController(
                                    text: (widget.editUsers)
                                        ? ""
                                        : list[index].id),
                              )
                            : IconButton(
                                tooltip: "Löschen",
                                icon: const Icon(Icons.delete,
                                    color: Colors.blue),
                                onPressed: () {
                                  // TODO: delete user
                                  waitDialog(context);
                                  FirebaseFirestore.instance
                                      .collection("tclub")
                                      .doc(widget.uid)
                                      .collection("users")
                                      .doc(list[index].id)
                                      .delete()
                                      .then((value) {
                                    closeDialog(context);
                                    // myCustomError(context,
                                    //     "Erfolgreich gelöscht");
                                  }).catchError((e) {
                                    closeDialog(context);
                                    myCustomError(context, e.toString());
                                  });
                                },
                              )
                        : IconButton(
                            tooltip: (widget.addUser)
                                ? "Abbrechen"
                                : "Neuen Nutzer hinzufügen",
                            padding: const EdgeInsets.only(right: 4),
                            icon: Icon(
                                (widget.addUser) ? Icons.close : Icons.add,
                                color: Colors.blue),
                            onPressed: () {
                              // TODO: set state to add user state
                              setState(() {
                                if (widget.addUser) {
                                  widget.addUser = false;
                                  widget.fields.removeWhere(
                                      (element) => element.uid == "New User");
                                } else {
                                  widget.addUser = true;
                                }
                              });
                            },
                          ));
              },
              rightSideItemBuilder: (context, index) {
                if (index == list.length) {
                  if (widget.addUser) {
                    return Row(
                        children: List.generate(keys.length, (indexInRow) {
                      return SizedBox(
                          width: 220,
                          height: 40,
                          child: TextField(
                            onChanged: (value) {
                              widget.fields.removeWhere(
                                  (element) => element.key == keys[indexInRow]);

                              widget.fields.add(ChangedField(
                                  "New User", keys[indexInRow], value));
                            },
                            style: const TextStyle(fontSize: 14),
                            enabled: widget.editUsers,
                            decoration: InputDecoration(
                                hintText: keys[indexInRow],
                                contentPadding:
                                    const EdgeInsets.only(left: 8, right: 8)),
                          ));
                    }));
                  } else {
                    return const SizedBox.shrink();
                  }
                }
                Map<String, dynamic> doc = list[index].data()!;
                return Row(
                    children: List.generate(keys.length, (indexInRow) {
                  return SizedBox(
                      width: 220,
                      height: 40,
                      child: TextField(
                        onChanged: (value) {
                          widget.fields.removeWhere(
                              (element) => element.key == keys[indexInRow]);
                          if (value != doc[keys[indexInRow]].toString()) {
                            widget.fields.add(ChangedField(
                                list[index].id, keys[indexInRow], value));
                          }
                        },
                        style: const TextStyle(fontSize: 14),
                        enabled: widget.editUsers,
                        decoration: InputDecoration(
                            hintText: keys[indexInRow],
                            contentPadding:
                                const EdgeInsets.only(left: 8, right: 8)),
                        controller: TextEditingController(
                            text: widget.fields
                                    .where((element) =>
                                        element.key == keys[indexInRow] &&
                                        element.uid == list[index].id)
                                    .isEmpty
                                ? (doc[keys[indexInRow]] == null)
                                    ? ""
                                    : doc[keys[indexInRow]].toString()
                                : widget.fields
                                    .where((element) =>
                                        element.key == keys[indexInRow])
                                    .last
                                    .value),
                      ));
                }));
              },
              itemCount: (widget.editUsers) ? list.length + 1 : list.length,
              leftHandSideColBackgroundColor: Colors.white70,
              rightHandSideColBackgroundColor: Colors.white);
        } catch (e) {
          return const Center(
              child: Text("No users found.",
                  style: TextStyle(color: Colors.white)));
        }
      },
    );
  }
}
