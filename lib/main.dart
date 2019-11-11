import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './ui/sura.dart';

void main() => runApp(MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.brown, accentColor: Colors.yellowAccent),
      home: SplashScreen(),
    ));

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(
        Duration(seconds: 2),
        () => Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Sura())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
              child: DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/quranap.jpg"),
                fit: BoxFit.fill,
              ),
            ),
          )),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 158,
                        child: Image.asset("assets/images/quran_icon.png"),
                      ),
                      Padding(padding: EdgeInsets.only(top: 10)),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
