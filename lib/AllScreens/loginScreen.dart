import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rideasy/AllScreens/mainScreen.dart';
import 'package:rideasy/AllScreens/registrationScreen.dart';
import 'package:rideasy/Components/progressDialog.dart';
import 'package:rideasy/Components/roundedButton.dart';
import 'package:rideasy/constants.dart';
import 'package:rideasy/main.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'loginscreen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image(
                      image: AssetImage('assets/RideasyLOGO.png'),
                      height: 80.0,
                    ),
                    Text(
                      'Rideasy',
                      style: TextStyle(
                        color: Color(0xFF1E319D),
                        fontSize: 40.0,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 32.0),
                TextField(
                  controller: emailTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  style: kTextStyle,
                  onChanged: (value) {},
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Email',
                  ),
                ),
                SizedBox(height: 28.0),
                TextField(
                  controller: passwordTextEditingController,
                  obscureText: true,
                  style: kTextStyle,
                  onChanged: (value) {},
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Password',
                  ),
                ),
                SizedBox(height: 15.0),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 15.0,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ),
                SizedBox(height: 28.0),
                RoundedButton(
                  title: 'Login',
                  colour: kPrimaryColor,
                  onPressed: () {
                    if (!emailTextEditingController.text.contains("@")) {
                      displayToastMessage(
                          "Email address is not valid.", context);
                    } else if (passwordTextEditingController.text.length < 8) {
                      displayToastMessage("Password is mandatory.", context);
                    } else {
                      loginAndAuthenticateUser(context);
                    }
                  },
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, RegistrationScreen.id, (route) => false);
                      },
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  void loginAndAuthenticateUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Authenticating, Please wait...",
          );
        });
    final User firebaseUser = (await _firebaseAuth
            .signInWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) {
      // SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setString('displayName', firebaseUser.uid);
      usersRef.child(firebaseUser.uid).once().then((DataSnapshot snap) {
        if (snap.value != null) {
          Navigator.pushNamedAndRemoveUntil(
              context, MainScreen.id, (route) => false);
          displayToastMessage("You are logged in.", context);
        } else {
          Navigator.pop(context);
          _firebaseAuth.signOut();
          displayToastMessage(
              "No record exist. Please create new account.", context);
        }
      });
    } else {
      Navigator.pop(context);
      displayToastMessage("Error occurred. Unable to sign in.", context);
    }
  }
}
