import 'package:flutter/material.dart';
import 'package:devs_talk/srcreens/welcome_screen.dart';
import 'package:devs_talk/srcreens/registration_screen.dart';
import 'package:devs_talk/srcreens/login_screen.dart';
import 'package:devs_talk/srcreens/chat_screen.dart';


void main(){
  runApp(DevsTalk());
}

class DevsTalk extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Devs chat',
      debugShowCheckedModeBanner: false,
      initialRoute:WelcomeScreen.id,
      routes: {
          WelcomeScreen.id:(context)=>WelcomeScreen(),
          LoginScreen.id :(context)=>LoginScreen(),
          RegistrationScreen.id:(context)=>RegistrationScreen(),
          ChatScreen.id:(context)=>ChatScreen(),
      },
    );
  }
}