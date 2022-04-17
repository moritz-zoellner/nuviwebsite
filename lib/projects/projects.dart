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
  const Project(this.title, this.content, this.child);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 800) {
        return Column(
            children: [DetailWidget(content), const ScreenShotWidget(), child]);
      }
      return Column(
        children: [
          Row(mainAxisSize: MainAxisSize.min, children: [
            Flexible(child: DetailWidget(content)),
            const SizedBox(width: 20),
            const Flexible(child: ScreenShotWidget())
          ]),
          child
        ],
      );
    });
  }
}

class ScreenShotWidget extends StatelessWidget {
  const ScreenShotWidget({Key? key}) : super(key: key);

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
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: List.generate(
              3,
              (index) => Flexible(
                    child: Container(
                      height: 240,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("entry_image.webp"
                                  //"https://appradar.com/wp-content/uploads/nyt-cooking-apple-screenshots-1024x768.png",
                                  )),
                          borderRadius: BorderRadius.circular(20)),
                    ),
                  )),
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
      TClub(),
    ),
    const Project(
      "Tcount",
      "Eine App für das mitzählen des Spielstandes. Mit vielen anschaulichen Statistiken kann eine besonders gute Auswertung des Spiels vorgenommen werden.",
      Tcount(),
    )
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
              Text(tabs[currentTab].title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 30)),
              TextButton(
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.symmetric(vertical: 4))),
                  child: const Text("Go Back to Product overview",
                      style: TextStyle(color: Colors.white, fontSize: 16)),
                  onPressed: () => setState(() => currentTab = -1)),
              const SizedBox(height: 20),
              tabs[currentTab],
            ],
          )),
    );
  }

  Widget projectList() {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: GridView(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                mainAxisExtent: 240, maxCrossAxisExtent: 1000),
            children: List.generate(
              tabs.length,
              (index) => Padding(
                  padding: const EdgeInsets.all(20),
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
                      const SizedBox(height: 20),
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
                          onPressed: () => setState(() => currentTab = index)),
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }
}

