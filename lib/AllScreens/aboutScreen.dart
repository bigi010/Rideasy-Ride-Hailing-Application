import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutScreen extends StatefulWidget {
  static const String id = "about";
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Rideasy"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Container(
          child: Text(
            "Rideasy is an easy to use application that enables users to book a ride. "
            "Once logged in to the system, user can search for desired destination and request ride."
            "This application provides trasnparent payment system for user convenience.",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}
