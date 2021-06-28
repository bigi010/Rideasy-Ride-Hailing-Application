import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rideasy/AllScreens/aboutScreen.dart';
import 'package:rideasy/AllScreens/loginScreen.dart';
import 'package:rideasy/AllScreens/mainScreen.dart';
import 'package:rideasy/AllScreens/profileScreen.dart';
import 'package:rideasy/AllScreens/registrationScreen.dart';
import 'package:rideasy/DataHandler/appData.dart';
import 'package:rideasy/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

DatabaseReference usersRef =
    FirebaseDatabase.instance.reference().child("users");

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppData(),
      child: MaterialApp(
        title: 'Rideasy',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          primaryColor: kPrimaryColor,
          accentColor: kAccentColor,
          scaffoldBackgroundColor: kScaffoldbgColor,
          textTheme: TextTheme(
            bodyText2: TextStyle(color: kPrimaryColor),
          ),
        ),
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? LoginScreen.id
            : MainScreen.id,
        routes: {
          MainScreen.id: (context) => MainScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          AboutScreen.id: (context) => AboutScreen(),
          ProfileScreen.id: (context) => ProfileScreen(),
        },
      ),
    );
  }
}
