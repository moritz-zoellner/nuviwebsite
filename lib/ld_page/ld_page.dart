import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noviwebsite/ld_page/blog.dart';
import 'package:noviwebsite/ld_page/impressum.dart';
import 'package:noviwebsite/ld_page/projects.dart';
import 'package:noviwebsite/old/signIn.dart';

class DesktopLandingPage extends StatelessWidget {
  const DesktopLandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
          TabBarView(physics: const NeverScrollableScrollPhysics(), children: [
        Padding(
            padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Expanded(child: LeftSide()),
                  SizedBox(width: 40),
                  Expanded(child: SignUpSide())
                ])),
        const ProjectsScreen(),
        const BlogScreen(),
        const Center(child: Text("About us")),
        const ImpressumDescription(),
      ]),
    );
  }
}

class MobileLandingPage extends StatelessWidget {
  const MobileLandingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child:
          TabBarView(physics: const NeverScrollableScrollPhysics(), children: [
        SingleChildScrollView(
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 40),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    LeftSide(),
                    SizedBox(height: 40),
                    SignUpSide()
                  ])),
        ),
        const ProjectsScreen(),
        const BlogScreen(),
        const Center(child: Text("About us")),
        const ImpressumDescription(),
      ]),
    );
  }
}

class SignUpSide extends StatefulWidget {
  const SignUpSide({Key? key}) : super(key: key);
  @override
  State<SignUpSide> createState() => _SignUpSideState();
}

const int SIGNUP = 0, SIGNIN = 1, FPASS = 2;

class _SignUpSideState extends State<SignUpSide> {
  int currentState = SIGNUP;
  @override
  Widget build(BuildContext context) {
    if (currentState == SIGNUP) {
      return signup();
    } else if (currentState == SIGNIN) {
      return signin();
    } else {
      return fpass();
    }
  }

  Widget fpass() {
    TextEditingController emailController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Forgot Password",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 30)),
        const SizedBox(height: 0),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(vertical: 4))),
              onPressed: () => setState(() => currentState = SIGNIN),
              child: const Text("Back to Sign In",
                  style: TextStyle(color: Colors.white, fontSize: 16))),
        ),
        const SizedBox(height: 20),
        NoviTile(
          Padding(
            padding: const EdgeInsets.all(16),
            child: CupertinoTextField.borderless(
              placeholder: "Email",
              controller: emailController,
              prefix: const Icon(
                CupertinoIcons.mail,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        FPassButton(emailController.text)
      ],
    );
  }

  Widget signin() {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Sign In",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 30)),
        const SizedBox(height: 0),
        Row(
          children: [
            const Text("I do not have an account!",
                maxLines: 4,
                style: TextStyle(color: Colors.white, fontSize: 16)),
            TextButton(
                onPressed: () => setState(() => currentState = SIGNUP),
                child: const Text("Sign Up",
                    style: TextStyle(color: Colors.white, fontSize: 16)))
          ],
        ),
        const SizedBox(height: 20),
        NoviTile(Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: CupertinoTextField.borderless(
                  placeholder: "Email",
                  controller: emailController,
                  prefix: const Icon(
                    CupertinoIcons.mail,
                    color: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: CupertinoTextField.borderless(
                  obscureText: true,
                  placeholder: "Password",
                  controller: passwController,
                  prefix: const Icon(
                    CupertinoIcons.lock,
                    color: Colors.blue,
                  ),
                ),
              ),
              TextButton(
                  onPressed: () => setState(() => currentState = FPASS),
                  child: const Text("Forgot Password?",
                      style: TextStyle(color: Colors.blue, fontSize: 14)))
            ])),
        const SizedBox(height: 20),
        SignInButton(emailController.text, passwController.text)
      ],
    );
  }

  Widget signup() {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwController = TextEditingController();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text("Sign Up",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 30)),
        const SizedBox(height: 0),
        Row(
          children: [
            const Text("Already have an account?",
                maxLines: 4,
                style: TextStyle(color: Colors.white, fontSize: 16)),
            TextButton(
                onPressed: () => setState(() => currentState = SIGNIN),
                child: const Text("Sign In",
                    style: TextStyle(color: Colors.white, fontSize: 16)))
          ],
        ),
        const SizedBox(height: 20),
        NoviTile(Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: CupertinoTextField.borderless(
                  placeholder: "Email",
                  controller: emailController,
                  prefix: const Icon(
                    CupertinoIcons.mail,
                    color: Colors.blue,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: CupertinoTextField.borderless(
                  obscureText: true,
                  placeholder: "Password",
                  controller: passwController,
                  prefix: const Icon(
                    CupertinoIcons.lock,
                    color: Colors.blue,
                  ),
                ),
              )
            ])),
        const SizedBox(height: 20),
        SignUpButton(emailController.text, passwController.text)
      ],
    );
  }
}

class LeftSide extends StatelessWidget {
  const LeftSide({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Software\nDevelopers",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.white)),
          SizedBox(height: 20),
          Text(
              "Check out our already developed Products.\nWant something personal? We create Apps for Web, IOS and Android on demand.",
              maxLines: 4,
              style: TextStyle(color: Colors.white, fontSize: 16)),
          SizedBox(height: 20),
          CreateAppButton(),
          SizedBox(height: 20),
        ]);
  }
}

class CreateAppButton extends StatelessWidget {
  const CreateAppButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: const Text("Create App", style: TextStyle(color: Colors.pink)),
        color: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        onPressed: () {});
  }
}

class SignInButton extends StatelessWidget {
  final String email, password;

  const SignInButton(this.email, this.password, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: const Text("Sign In", style: TextStyle(color: Colors.white)),
        color: Colors.blue,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        onPressed: () {
          FirebaseAuth.instance
              .signInWithEmailAndPassword(email: email, password: password)
              .then((value) {
            // Navigiere zur Admin app

            myCustomError(context, "Nutzer erfolgreich angemeldet");
          }).onError((e, s) {
            myCustomError(context, "Fehler aufgetreten");
          });
        });
  }
}

class FPassButton extends StatelessWidget {
  final String email;
  const FPassButton(this.email, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: const Text("Send password by email",
            style: TextStyle(color: Colors.white)),
        color: Colors.blue,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        onPressed: () {
          FirebaseAuth.instance
              .sendPasswordResetEmail(email: email)
              .then((value) {
            myCustomError(context, "Email has been sent.");
          }).onError((e, s) {
            myCustomError(context, "Fehler aufgetreten");
          });
        });
  }
}

class SignUpButton extends StatelessWidget {
  final String email, password;
  const SignUpButton(this.email, this.password, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 24),
        child: const Text("Sign Up", style: TextStyle(color: Colors.white)),
        color: Colors.blue,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16))),
        onPressed: () {
          FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((value) {
            myCustomError(context, "Nutzer erfolgreich registriert");
          }).onError((e, s) {
            myCustomError(context, "Fehler aufgetreten");
          });
        });
  }
}
