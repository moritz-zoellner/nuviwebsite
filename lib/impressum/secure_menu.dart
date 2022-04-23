import 'package:flutter/material.dart';
import 'package:noviwebsite/impressum/impressum.dart';
import 'package:noviwebsite/impressum/privacy.dart';
import 'package:noviwebsite/impressum/terms.dart';

class SecureMenu extends StatelessWidget {
  const SecureMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4, left: 4, right: 4),
      child: OverflowBar(
        alignment: MainAxisAlignment.end,
        overflowAlignment: OverflowBarAlignment.start,
        children: [
          TextButton(
              onPressed: () {
                showGeneralDialog(
                    context: context,
                    barrierColor: Colors.black26,
                    pageBuilder: (context, a1, a2) =>
                        const ImpressumDescription());
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text("§ Impressum",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white)),
                ],
              )),
          const SizedBox(width: 20),
          TextButton(
              onPressed: () {
                showGeneralDialog(
                    context: context,
                    barrierColor: Colors.black26,
                    pageBuilder: (context, a1, a2) =>
                        const PrivacyDescription());
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.privacy_tip_rounded,
                      color: Colors.white, size: 16),
                  SizedBox(width: 4),
                  Text("Datenschutz",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white)),
                ],
              )),
          const SizedBox(width: 20),
          TextButton(
              onPressed: () {
                showGeneralDialog(
                    context: context,
                    barrierColor: Colors.black26,
                    pageBuilder: (context, a1, a2) => const TermsDescription());
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Icon(Icons.policy, color: Colors.white, size: 16),
                  SizedBox(width: 4),
                  Text("AGB",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.white)),
                ],
              )),
        ],
      ),
    );
  }
}
