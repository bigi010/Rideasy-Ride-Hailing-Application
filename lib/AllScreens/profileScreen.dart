import 'package:flutter/material.dart';
import 'package:rideasy/Components/divider.dart';
import 'package:rideasy/constants.dart';

class ProfileScreen extends StatefulWidget {
  static const String id = "profile";
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("User Profile"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundColor: kPrimaryColor,
              backgroundImage: AssetImage("assets/userIcon.png"),
            ),
            Text(
              "Bigi K.C.",
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20.0, width: 150.0),
            DividerWidget(),
            Card(
                color: kPrimaryColor,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.phone,
                    color: Colors.white,
                  ),
                  title: Text(
                    '9845673125',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0,
                    ),
                  ),
                )),
            Card(
                color: kPrimaryColor,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.email,
                    color: Colors.white,
                  ),
                  title: Text(
                    'bigikc@gmail.com',
                    style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontFamily: 'Source Sans Pro'),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
