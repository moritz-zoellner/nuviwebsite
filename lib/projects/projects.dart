import 'package:flutter/material.dart';
import 'package:noviwebsite/projects/tclub/tclub.dart';
import 'package:noviwebsite/projects/tcount/tcount.dart';
import 'package:noviwebsite/styling.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class Project extends StatelessWidget {
  final String title;
  final String content;
  final Widget child;
  final List<String> screenshots;
  const Project(this.title, this.content, this.child, this.screenshots);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 800) {
        return Column(children: [
          DetailWidget(content),
          ScreenShotWidget(screenshots),
          child
        ]);
      }
      return Column(
        children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            Flexible(child: DetailWidget(content)),
            const SizedBox(width: 20),
            Flexible(child: ScreenShotWidget(screenshots))
          ]),
          child
        ],
      );
    });
  }
}

class ScreenShotWidget extends StatelessWidget {
  final List<String> screenshots;

  const ScreenShotWidget(this.screenshots, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Screenshots",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 24)),
        const SizedBox(height: 20),
        SizedBox(
          height: 240,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
                screenshots.length,
                (index) => Flexible(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, right: 10),
                        height: 240,
                        width: 110,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage(screenshots[index])),
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    )),
          ),
        )
      ],
    );
  }
}

class DetailWidget extends StatelessWidget {
  final String content;
  const DetailWidget(this.content, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Details",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 24)),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: NoviTile(Row(
                children: [
                  Flexible(child: Text(content)),
                  const SizedBox(width: 20),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Icon(
                        Icons.check_circle_outline_rounded,
                      ),
                      SizedBox(height: 8),
                      Text("IOS", textAlign: TextAlign.center),
                      SizedBox(height: 16),
                      Icon(
                        Icons.check_circle_outline_rounded,
                      ),
                      SizedBox(height: 8),
                      Text("Android", textAlign: TextAlign.center),
                      SizedBox(height: 16),
                      Icon(
                        Icons.check_circle_outline_rounded,
                      ),
                      SizedBox(height: 8),
                      Text("Web", textAlign: TextAlign.center),
                    ],
                  )
                ],
              )))
        ]);
  }
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  int currentTab = -1;

  List<Project> tabs = [
    const Project(
        "Tclub",
        "Eine App für Tennisclubs, welche die Verwaltung von Plätzen und Mitgliedern übernimmt. Dadurch werden viele Vorgänge sowohl für Spieler als auch für Organisatoren drastisch vereinfacht. Tclub ist DER Schritt in Richtung Digitalisierung für Tennisclubs. Einfach. Innovativ. Günstig. Die zentralisierte Verwaltung von Benutzerdaten garantiert einen sicheren und zuverlässigen Umgang und ermöglicht auch anstrebenden Tennisspielern einen komfortablen und schnellen Einstieg in den ersten Club.",
        TClub(), [
      "screenshots/tclub/courts.png",
      "screenshots/tclub/profil.png",
      "screenshots/tclub/dialog.png"
    ]),
    const Project(
        "Tcount",
        "Eine App für das mitzählen des Spielstandes. Mit vielen anschaulichen Statistiken kann eine besonders gute Auswertung des Spiels vorgenommen werden.",
        Tcount(), [
      // "screenshots/tclub/courts.png",
      // "screenshots/tclub/profil.png",
      // "screenshots/tclub/dialog.png"
    ])
  ];

  @override
  Widget build(BuildContext context) {
    if (currentTab == -1) {
      return projectList();
    }
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () => setState(() => currentTab = -1),
                      icon: const Icon(Icons.arrow_back_ios_new_rounded,
                          color: Colors.blue)),
                  const SizedBox(width: 20),
                  Text(tabs[currentTab].title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 30)),
                ],
              ),
              const SizedBox(height: 20),
              tabs[currentTab],
            ],
          )),
    );
  }

  Widget projectList() {
    return Center(
      child: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: List.generate(
                tabs.length,
                (index) => Padding(
                    padding: const EdgeInsets.all(20),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Flexible(
                            child: Text(tabs[index].title,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontSize: 24)),
                          ),
                          const SizedBox(height: 10),
                          NoviTile(
                            SizedBox(
                              height: 50,
                              child: Text(tabs[index].content,
                                  maxLines: 3, overflow: TextOverflow.ellipsis),
                            ),
                          ),
                          const SizedBox(height: 20),
                          MaterialButton(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 32, vertical: 24),
                              color: Colors.blue,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: const Text("Weiteres",
                                  style: TextStyle(color: Colors.white)),
                              onPressed: () =>
                                  setState(() => currentTab = index)),
                        ],
                      ),
                    )),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
