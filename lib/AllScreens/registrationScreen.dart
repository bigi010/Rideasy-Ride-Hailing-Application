import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:rideasy/AllScreens/loginScreen.dart';
import 'package:rideasy/Components/progressDialog.dart';
import 'package:rideasy/Components/roundedButton.dart';
import 'package:rideasy/constants.dart';
import 'package:rideasy/main.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registrationscreen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController phoneTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController repasswordTextEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 30.0),
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
                SizedBox(height: 25.0),
                TextField(
                  controller: nameTextEditingController,
                  style: kTextStyle,
                  onChanged: (value) {},
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Name',
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: emailTextEditingController,
                  keyboardType: TextInputType.emailAddress,
                  style: kTextStyle,
                  onChanged: (value) {},
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Email',
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: phoneTextEditingController,
                  keyboardType: TextInputType.phone,
                  style: kTextStyle,
                  onChanged: (value) {},
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Mobile Number',
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: passwordTextEditingController,
                  obscureText: true,
                  style: kTextStyle,
                  onChanged: (value) {},
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Password',
                  ),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: repasswordTextEditingController,
                  obscureText: true,
                  style: kTextStyle,
                  onChanged: (value) {},
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Confirm Password',
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  children: [
                    Expanded(
                      child: RoundedButton(
                        title: 'Sign Up',
                        colour: kPrimaryColor,
                        onPressed: () {
                          if (nameTextEditingController.text.length < 3) {
                            displayToastMessage(
                                "Name must be atleast 3 characters long.",
                                context);
                          } else if (!emailTextEditingController.text
                              .contains("@")) {
                            displayToastMessage(
                                "Email address is not valid.", context);
                          } else if (phoneTextEditingController.text.isEmpty) {
                            displayToastMessage(
                                "Mobile Number is mandatory.", context);
                          } else if (passwordTextEditingController.text.length <
                              8) {
                            displayToastMessage(
                                "Password must be atleast 8 characters long.",
                                context);
                          } else {
                            registerNewUser(context);
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    SizedBox(width: 5.0),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: Text(
                        'Login',
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
  void registerNewUser(BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return ProgressDialog(
            message: "Creating Account, Please wait...",
          );
        });
    final User firebaseUser = (await _firebaseAuth
            .createUserWithEmailAndPassword(
                email: emailTextEditingController.text,
                password: passwordTextEditingController.text)
            .catchError((errMsg) {
      Navigator.pop(context);
      displayToastMessage("Error: " + errMsg.toString(), context);
    }))
        .user;

    if (firebaseUser != null) {
      Map userDataMap = {
        "name": nameTextEditingController.text.trim(),
        "email": emailTextEditingController.text.trim(),
        "phone": phoneTextEditingController.text.trim(),
      };
      usersRef.child(firebaseUser.uid).set(userDataMap);
      displayToastMessage("Your account has been created.", context);

      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.id, (route) => false);
    } else {
      Navigator.pop(context);
      displayToastMessage("New User Account has not been created.", context);
    }
  }
}

displayToastMessage(String message, BuildContext context) {
  Fluttertoast.showToast(msg: message);
}
