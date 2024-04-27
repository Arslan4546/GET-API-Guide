import 'package:api_integration/apiDataScreen.dart';
import 'package:api_integration/homeScreen.dart';
import 'package:flutter/material.dart';

final Map<String,WidgetBuilder> routes = {
  "/" : (BuildContext context) => const HomeScreen(),
  "/screen1" : (BuildContext context) => const ApiScreen(),


};
