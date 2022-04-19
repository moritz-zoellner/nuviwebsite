import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/management/tclub/membershipmanagement/table.dart';
import 'package:noviwebsite/styling.dart';

class MembershipManagement extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> projectInfo;

  const MembershipManagement(this.projectInfo, {Key? key}) : super(key: key);

  @override
  State<MembershipManagement> createState() => _MembershipManagementState();
}

class ChangedField {
  final String uid;
  final String key;
  final String value;

  const ChangedField(this.uid, this.key, this.value);
}

class _MembershipManagementState extends State<MembershipManagement> {
  bool editUsers = false;
  bool addUser = false;
  List<ChangedField> fields = [];
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 20, left: 20, right: 40),
              child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                                color: Colors.white)),
                        const SizedBox(width: 20),
                        Text(widget.projectInfo["appname"],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 30)),
                      ],
                    ),
                    const SizedBox(width: 20),
                    Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      const ExportTableButton(),
                      (editUsers)
                          ? IconButton(
                              onPressed: () {
                                setState(() {
                                  fields = [];
                                  editUsers = false;
                                  addUser = false;
                                });
                              },
                              tooltip: "Nicht speichern",
                              icon:
                                  const Icon(Icons.close, color: Colors.white))
                          : const SizedBox.shrink(),
                      EditTableButton(
                          widget.projectInfo.id,
                          editUsers,
                          addUser,
                          () => setState(() {
                                fields = [];
                                editUsers = !editUsers;
                                addUser = false;
                              }),
                          fields),
                    ])
                  ])),
          Expanded(
              child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      child: MyTable(
                          widget.projectInfo.id, editUsers, addUser, fields))))
        ]);
  }
}

class EditTableButton extends StatelessWidget {
  bool editUsers, addUser;
  Function() setState;
  List<ChangedField> fields;
  final String projectId;
  EditTableButton(
      this.projectId, this.editUsers, this.addUser, this.setState, this.fields,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        if (editUsers) {
          // update all fields in Firestore from the new texts in controllers -> idk :(
          List<ChangedField> newUserFields =
              fields.where((element) => element.uid == "New User").toList();

          if (newUserFields.isNotEmpty) {
            Map<String, String> newUserMap = {};
            for (int i = 0; i < newUserFields.length; i++) {
              newUserMap.putIfAbsent(
                  newUserFields[i].key, () => newUserFields[i].value);
            }
            print("Map: " + newUserMap.toString());
            waitDialog(context);

            FirebaseFirestore.instance
                .collection("tclub")
                .doc(projectId)
                .collection("users")
                .add(newUserMap)
                .then((value) {
              closeDialog(context);
              //  myCustomError(context, "Erfolgreich gespeichert");
            }).catchError((e) {
              closeDialog(context);
              myCustomError(context, e.toString());
            });
          }

          fields.removeWhere((element) => element.uid == "New User");

          Map<String, Map<String, String>> allChangedDocs = {};
          for (int i = 0; i < fields.length; i++) {
            List<ChangedField> f = fields
                .where((element) => element.uid == fields[i].uid)
                .toList();

            Map<String, String> newUserMap = {};
            for (int j = 0; j < fields.length; j++) {
              newUserMap.putIfAbsent(fields[j].key, () => fields[j].value);
            }

            allChangedDocs.putIfAbsent(f.first.uid, () => newUserMap);
          }
          for (int i = 0; i < allChangedDocs.length; i++) {
            print("DocID: " + allChangedDocs.keys.toList()[i]);
            print("Map: " +
                allChangedDocs[allChangedDocs.keys.toList()[i]].toString());
            waitDialog(context);
            FirebaseFirestore.instance
                .collection("tclub")
                .doc(projectId)
                .collection("users")
                .doc(allChangedDocs.keys.toList()[i])
                .update(allChangedDocs[allChangedDocs.keys.toList()[i]]!)
                .then((value) {
              closeDialog(context);
              // myCustomError(context, "Erfolgreich gespeichert");
            }).catchError((e) {
              closeDialog(context);
              myCustomError(context, e.toString());
            });
          }

          // myCustomError(context, "Du hast den Bearbeitungsmodus verlassen");
        } else {
          // myCustomError(context,
          //     "Du bist im Bearbeitungsmodus. Vergesse nicht deine Änderungen zu speichern!");
        }
        setState();
      },
      icon: (editUsers)
          ? const Icon(Icons.save, color: Colors.white)
          : const Icon(Icons.edit, color: Colors.white),
      tooltip: (editUsers) ? "Speichern" : "Neuer Nutzer",
    );
  }
}

class ExportTableButton extends StatelessWidget {
  const ExportTableButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        // TODO: export table
        // differnet ways on different platforms... :(
      },
      icon: const Icon(Icons.import_export_rounded, color: Colors.white),
      tooltip: "CSV Datei exportieren",
    );
  }
}
