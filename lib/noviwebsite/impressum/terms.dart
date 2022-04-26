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
                                        const Text("AGB",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 30)),
                                      ]),
                                      SingleChildScrollView(
                                          child: Center(
                                              child: Container(
                                                  margin: const EdgeInsets.only(
                                                      top: 20,
                                                      left: 20,
                                                      right: 20),
                                                  constraints:
                                                      const BoxConstraints(
                                                          maxWidth: 800),
                                                  child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .stretch,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceAround,
                                                      children: [
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "§1 Geltung gegenüber Unternehmern und Begriffsdefinitionen",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "(1) Die nachfolgenden Allgemeinen Geschäftbedingungen gelten für alle Lieferungen zwischen uns und einem Verbraucher in ihrer zum Zeitpunkt der Bestellung gültigen Fassung.",
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "Verbraucher ist jede natürliche Person, die ein Rechtsgeschäft zu Zwecken abschließt, die überwiegend weder ihrer gewerblichen noch ihrer selbständigen beruflichen Tätigkeit zugerechnet werden können (§ 13 BGB).",
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "§2 Zustandekommen eines Vertrages, Speicherung des Vertragstextes",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "(1) Die folgenden Regelungen über den Vertragsabschluss gelten für Bestellungen über unseren Internetshop http://www.novicorp.com .",
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "(2) Im Falle des Vertragsschlusses kommt der Vertrag mit",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Row(children: const [
                                                          SizedBox(
                                                            width: 32,
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              "Novi Corp.\nDenis Novikau\nKartäuserstraße 11\nD-99084 Erfurt\nRegisternummer 12131415\nRegistergericht Amtsgericht Erfurt",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "zustande.",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "(3) Die Präsentation der Waren in unserem Internetshop stellen kein rechtlich bindendes Vertragsangebot unsererseits dar, sondern sind nur eine unverbindliche Aufforderungen an den Verbraucher, Waren zu bestellen. Mit der Bestellung der gewünschten Ware gibt der Verbraucher ein für ihn verbindliches Angebot auf Abschluss eines Kaufvertrages ab.\n\n(4) Bei Eingang einer Bestellung in unserem Internetshop gelten folgende Regelungen: Der Verbraucher gibt ein bindendes Vertragsangebot ab, indem er die in unserem Internetshop vorgesehene Bestellprozedur erfolgreich durchläuft.\n\nDie Bestellung erfolgt in folgenden Schritten:",
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Row(children: const [
                                                          SizedBox(
                                                            width: 32,
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              "1) Auswahl der gewünschten Ware\n2) Bestätigen durch Anklicken der Buttons „Bestellen“\n3) Prüfung der Angaben im Warenkorb\n4) Betätigung des Buttons „zur Kasse“\n5) Anmeldung im Internetshop nach Registrierung und Eingabe der Anmelderangaben (E-Mail-Adresse und Passwort).\n6) Nochmalige Prüfung bzw. Berichtigung der jeweiligen eingegebenen Daten.\n7) Verbindliche Absendung der Bestellung durch Anklicken des Buttons „kostenpflichtig bestellen“ bzw. „kaufen“",
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "Der Verbraucher kann vor dem verbindlichen Absenden der Bestellung durch Betätigen der in dem von ihm verwendeten Internet-Browser enthaltenen „Zurück“-Taste nach Kontrolle seiner Angaben wieder zu der Internetseite gelangen, auf der die Angaben des Kunden erfasst werden und Eingabefehler berichtigen bzw. durch Schließen des Internetbrowsers den Bestellvorgang abbrechen. Wir bestätigen den Eingang der Bestellung unmittelbar durch eine automatisch generierte E-Mail („Auftragsbestätigung“). Mit dieser nehmen wir Ihr Angebot an.\n\n(5) Speicherung des Vertragstextes bei Bestellungen über unseren Internetshop : Wir speichern den Vertragstext und senden Ihnen die Bestelldaten und unsere AGB per E-Mail zu. Die AGB können Sie jederzeit auch unter http://www.novicorp.com einsehen. Direkt auf Startseite",
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "§3 Preise, Versandkosten, Zahlung, Fälligkeit",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "(1) Die angegebenen Preise enthalten die gesetzliche Umsatzsteuer und sonstige Preisbestandteile. Hinzu kommen etwaige Versandkosten.\n\n(2) Der Verbraucher hat die Möglichkeit der Zahlung per Bankeinzug, PayPal, Kreditkarte( Visa ) ",
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "§4 Lieferung",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "(1) Sofern wir dies in der Produktbeschreibung nicht deutlich anders angegeben haben, sind alle von uns angebotenen Artikel sofort versandfertig. Die Lieferung erfolgt hier spätesten innerhalb von 1 Werktagen. Dabei beginnt die Frist für die Lieferung im Falle der Zahlung per Vorkasse am Tag nach Zahlungsauftrag an die mit der Überweisung beauftragte Bank und bei allen anderen Zahlungsarten am Tag nach Vertragsschluss zu laufen. Fällt das Fristende auf einen Samstag, Sonntag oder gesetzlichen Feiertag am Lieferort, so endet die Frist am nächsten Werktag.\n\n(2) Die Gefahr des zufälligen Untergangs und der zufälligen Verschlechterung der verkauften Sache geht auch beim Versendungskauf erst mit der Übergabe der Sache an den Käufer auf diesen über.",
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "§4 Eigentumsvorbehalt",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "Wir behalten uns das Eigentum an der Ware bis zur vollständigen Bezahlung des Kaufpreises vor.",
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        const Divider(
                                                          color: Colors.black,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "§6 Widerrufsrecht des Kunden als Verbraucher",
                                                              style: TextStyle(
                                                                  fontSize: 20,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color: Colors
                                                                      .black),
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "Widerrufsrecht für Verbraucher",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "Verbrauchern steht ein Widerrufsrecht nach folgender Maßgabe zu, wobei Verbraucher jede natürliche Person ist, die ein Rechtsgeschäft zu Zwecken abschließt, die überwiegend weder ihrer gewerblichen noch ihrer selbständigen beruflichen Tätigkeit zugerechnet werden können:",
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "Widerrufsbelehrung",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "Widerrufsrecht",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "Sie haben das Recht, binnen vierzehn Tagen ohne Angabe von Gründen diesen Vertrag zu widerrufen.\nDie Widerrufsfrist beträgt vierzehn Tage, ab dem Tag des Vertragsabschlusses.\n\nUm Ihr Widerrufsrecht auszuüben, müssen Sie uns",
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 4,
                                                        ),
                                                        Row(children: const [
                                                          SizedBox(
                                                            width: 32,
                                                          ),
                                                          Flexible(
                                                            child: Text(
                                                              "Novi Corp.\nDenis Novikau\nKartäuserstraße 11\nD-99084 Erfurt\nE-Mail novikaudenis@gmail.com",
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "mittels einer eindeutigen Erklärung (z.B. ein mit der Post versandter Brief, Telefax oder E-Mail) über Ihren Entschluss, diesen Vertrag zu widerrufen, informieren. Sie können dafür das beigefügte Muster-Widerrufsformular verwenden, das jedoch nicht vorgeschrieben ist.\n\nZur Wahrung der Widerrufsfrist reicht es aus, dass Sie die Mitteilung über die Ausübung des Widerrufsrechts vor Ablauf der Widerrufsfrist absenden.",
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "Widerrufsfolgen",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "Wenn Sie diesen Vertrag widerrufen, haben wir Ihnen alle Zahlungen, die wir von Ihnen erhalten haben, einschließlich der Lieferkosten (mit Ausnahme der zusätzlichen Kosten, die sich daraus ergeben, dass Sie eine andere Art der Lieferung als die von uns angebotene, günstigste Standardlieferung gewählt haben), unverzüglich und spätestens binnen vierzehn Tagen ab dem Tag zurückzuzahlen, an dem die Mitteilung über Ihren Widerruf dieses Vertrags bei uns eingegangen ist. Für diese Rückzahlung verwenden wir dasselbe Zahlungsmittel, das Sie bei der ursprünglichen Transaktion eingesetzt haben, es sei denn, mit Ihnen wurde ausdrücklich etwas anderes vereinbart; in keinem Fall werden Ihnen wegen dieser Rückzahlung Entgelte berechnet.\n\nHaben Sie verlangt, dass die Dienstleistungen während der Widerrufsfrist beginnen soll, so haben Sie uns einen angemessenen Betrag zu zahlen, der dem Anteil der bis zu dem Zeitpunkt, zu dem Sie uns von der Ausübung des Widerrufsrechts hinsichtlich dieses Vertrags unterrichten, bereits erbrachten Dienstleistungen im Vergleich zum Gesamtumfang der im Vertrag vorgesehenen Dienstleistungen entspricht.",
                                                            ),
                                                          ),
                                                        ]),
                                                        const SizedBox(
                                                          height: 16,
                                                        ),
                                                        Row(children: const [
                                                          Flexible(
                                                            child: Text(
                                                              "Ende der Widerrufsbelehrung",
                                                              style: TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ),
                                                        ]),
                                                        const Divider(
                                                          color: Colors.black,
                                                        ),
                                                        const Text(
                                                          "§7 Widerrufsformular",
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                            height: 16),
                                                        const Text(
                                                          "Muster-Widerrufsformular",
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                            height: 16),
                                                        const Text(
                                                            "(Wenn Sie den Vertrag widerrufen wollen, dann füllen Sie bitte dieses Formular aus und senden Sie es zurück.)"),
                                                        const SizedBox(
                                                            height: 8),
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(16),
                                                          child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .stretch,
                                                              children: const [
                                                                Text(
                                                                    "An :\nNovi Corp.\nDenis Novikau\nKartäuserstraße 11\nD-99084 Erfurt\nE-Mail novikaudenis@gmail.com\n\nHiermit widerrufe(n) ich/wir (*) den von mir/uns (*) abgeschlossenen Vertrag über den Kauf der folgenden Waren (*)/die Erbringung der folgenden Dienstleistung (*)\n\n"),
                                                                Divider(),
                                                                Text(
                                                                    "Bestellt am (*)/erhalten am (*)\n\n"),
                                                                Divider(),
                                                                Text(
                                                                    "Name des/der Verbraucher(s)\n\n"),
                                                                Divider(),
                                                                Text(
                                                                    "Anschrift des/der Verbraucher(s)\n\n"),
                                                                Divider(),
                                                                Text(
                                                                    "Unterschrift des/der Verbraucher(s) (nur bei Mitteilung auf Papier)\n\n"),
                                                                Divider(),
                                                                Text(
                                                                    "Datum\n\n"),
                                                                Divider(),
                                                              ]),
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              border: Border.all(
                                                                  color: Colors
                                                                      .black)),
                                                        ),
                                                        const Text(
                                                            "(*) Unzutreffendes streichen."),
                                                        const SizedBox(
                                                            height: 16),
                                                        const Text(
                                                          "§8 Gewährleistung",
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                            height: 16),
                                                        const Text(
                                                            "Es gelten die gesetzlichen Gewährleistungsregelungen."),
                                                        const SizedBox(
                                                            height: 16),
                                                        const Text(
                                                          "§9 Vertragssprache",
                                                          textAlign:
                                                              TextAlign.start,
                                                          style: TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                        const SizedBox(
                                                            height: 16),
                                                        const Text(
                                                            "Als Vertragssprache steht ausschließlich Deutsch zur Verfügung."),
                                                        const SizedBox(
                                                            height: 32),
                                                        Text(
                                                          "Stand der AGB Apr.2022",
                                                          style: TextStyle(
                                                              fontSize: 13,
                                                              color: Colors.grey
                                                                  .shade600),
                                                        )
                                                      ]))))
                                    ]))))))));
  }
}
