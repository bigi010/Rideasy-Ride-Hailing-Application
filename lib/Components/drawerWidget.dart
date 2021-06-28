import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rideasy/AllScreens/aboutScreen.dart';
import 'package:rideasy/AllScreens/loginScreen.dart';
import 'package:rideasy/AllScreens/profileScreen.dart';
import 'package:rideasy/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DrawerWidget extends StatefulWidget {
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String displayName = "";

  @override
  void initState() {
    getData();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      displayName = prefs.getString('displayName');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kScaffoldbgColor,
      width: 255.0,
      child: ListView(
        children: [
          Container(
            height: 165.0,
            child: DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[kPrimaryColor, Colors.indigo],
                ),
              ),
              child: Row(
                children: [
                  Image.asset(
                    'assets/userIcon.png',
                    height: 65.0,
                    width: 65.0,
                  ),
                  SizedBox(width: 16.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Bigi K.C.',
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Divider(
            height: 1.0,
            color: kPrimaryColor,
            thickness: 1.0,
          ),
          SizedBox(height: 12.0),
          //Drawer body controllers
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ProfileScreen.id);
            },
            child: ListTile(
              leading: Icon(
                Icons.person,
                color: kPrimaryColor,
              ),
              title: Text("Visit Profile",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: kPrimaryColor,
                  )),
            ),
          ),
          // ListTile(
          //   leading: Icon(
          //     Icons.history,
          //     color: kPrimaryColor,
          //   ),
          //   title: Text("Ride History",
          //       style: TextStyle(
          //         fontSize: 15.0,
          //         color: kPrimaryColor,
          //       )),
          // ),

          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, AboutScreen.id);
            },
            child: ListTile(
              leading: Icon(
                Icons.info,
                color: kPrimaryColor,
              ),
              title: Text("About",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: kPrimaryColor,
                  )),
            ),
          ),

          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(
                  context, LoginScreen.id, (route) => false);
            },
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: kPrimaryColor,
              ),
              title: Text("Log Out",
                  style: TextStyle(
                    fontSize: 15.0,
                    color: kPrimaryColor,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
