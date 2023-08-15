import 'package:flutter/material.dart';

ThemeData theme() {
  const kGrey = Color(0xffE5E5E5);
  return ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: appBarTheme(),
      inputDecorationTheme: const InputDecorationTheme(
  border: OutlineInputBorder(
  borderSide: BorderSide(color: kGrey)
  ),
  ));
}

AppBarTheme appBarTheme() {
  return const AppBarTheme(
    color: Colors.blue,
    elevation: 0,
    centerTitle: false,

    iconTheme: IconThemeData(color: Color(0XFF8B8B8B)),
    titleTextStyle: TextStyle(color: Color(0XFF8B8B8B), fontSize: 15),
  );
}
