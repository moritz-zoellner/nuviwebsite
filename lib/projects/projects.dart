import 'package:flutter/material.dart';
import 'package:noviwebsite/styling.dart';

class ProjectsScreen extends StatefulWidget {
  final Project child;

  const ProjectsScreen(this.child, {Key? key}) : super(key: key);

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
                        Icons.remove_circle_outlined,
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
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      child: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_ios_new_rounded,
                            color: Colors.blue)),
                    const SizedBox(width: 20),
                    Text(widget.child.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 30)),
                  ],
                ),
                const SizedBox(height: 20),
                widget.child,
              ],
            )),
      ),
    );
  }
}
