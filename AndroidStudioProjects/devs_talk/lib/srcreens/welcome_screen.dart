import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:devs_talk/component/roundedbutton.dart';
import 'package:devs_talk/srcreens/login_screen.dart';
import 'package:devs_talk/srcreens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = "/welcome_screen";

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {

    super.initState();

    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    );

//    direction
    controller.forward();

//    Listener
    controller.addListener(() {
      setState(() {});
      print(controller.value);
    });

    animation =
        ColorTween(begin: Colors.blue, end: Colors.white).animate(controller);

//    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);

    //    AnimationStatus
//    animation.addStatusListener((status) {
//      if (status == AnimationStatus.completed) {
//        controller.reverse(from: 1.0);
//      } else if (status == AnimationStatus.dismissed) {
//        controller.forward();
//      }
//    });
  }

  @override
  void dispose() {
  
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 19.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo2.png'),
                    height: 60.0,
                  ),
                ),
                TypewriterAnimatedTextKit(
                  text: ['Flash Chat'],
                  textStyle: TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            ReusablePadding(
              text: 'Log in',
              colour: Colors.lightBlueAccent,
              onTap: () {
                //Go to login screen.
                Navigator.pushNamed(context, LoginScreen.id);
              },
            ),
            ReusablePadding(
              text: 'Register',
              colour: Colors.blueAccent,
              onTap: () {
                //Go to login screen.
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
