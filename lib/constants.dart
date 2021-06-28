import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rideasy/Models/allUsers.dart';

String mapKey = "YOUR_API_KEY";
User firebaseUser;
Users userCurrentInfo;

const kPrimaryColor = Color(0xFF1E319D);
const kAccentColor = Color(0xFFA8D2F6);
const kScaffoldbgColor = Color(0xFFF3F5F7);
const kTextStyle = TextStyle(color: Colors.black);

const kOutlineInputBorderDecoration = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(10.0),
  ),
  borderSide: BorderSide.none,
);

const kFocusedBorderDecoration = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(10.0),
  ),
  borderSide: BorderSide(
    color: kPrimaryColor,
  ),
);

const kTextFieldDecoration = InputDecoration(
  hintText: 'Enter a value',
  hintStyle: TextStyle(
    color: Colors.grey,
  ),
  filled: true,
  fillColor: Color(0xFFF3F5F7),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
  ),
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide(color: kPrimaryColor, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(10.0),
    ),
    borderSide: BorderSide(
      color: kPrimaryColor,
      width: 3.0,
    ),
  ),
);
