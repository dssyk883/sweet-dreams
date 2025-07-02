import 'package:flutter/material.dart';

class CustomTextStyle {
  static TextStyle subTitle(BuildContext context) {
    return Theme
        .of(context)
        .textTheme
        .headline1!
        .copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(118, 195, 238, 1));
  }

  static TextStyle contents(BuildContext context){
    return Theme
        .of(context)
        .textTheme
        .headline2!
        .copyWith(
        fontSize: 18,
        fontWeight: FontWeight.normal,
        color: Color.fromRGBO(68, 76, 80, 1));
  }

  static TextStyle boldContents(BuildContext context){
    return Theme
        .of(context)
        .textTheme
        .headline2!
        .copyWith(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color.fromRGBO(24, 48, 201, 1));
  }

  static TextStyle listText(BuildContext context) {
    return Theme
        .of(context)
        .textTheme
        .headline3!
        .copyWith(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.black54,);
  }
}