import 'package:flutter/material.dart';


class ReusablePadding extends StatelessWidget {
  const ReusablePadding(
      {@required this.onTap, @required this.text, @required this.colour});

  final Function onTap;
  final String text;
  final Color colour;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: colour,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onTap,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
            style: TextStyle(
              color:Colors.white
            ),
          ),
        ),
      ),
    );
  }
}


//I have same problem. I get this error because I edit android module without open it first using AS in another tab (Tools -> Flutter -> Open Android module..). Then I have a solution, just restart and kill the chache in your Android Studio (File -> Invalidate Chache / Restart).
//
//It fixed for me, I hope you too