import 'package:api_integration/routes.dart';
import 'package:flutter/material.dart';
 void main()
{
  runApp(const ApiIntergration());
}


class ApiIntergration extends StatefulWidget {
   const ApiIntergration({super.key});

   @override
   State<ApiIntergration> createState() => _ApiIntergrationState();
 }

 class _ApiIntergrationState extends State<ApiIntergration> {
   @override
   Widget build(BuildContext context) {
return MaterialApp(
  debugShowCheckedModeBanner: false,
  routes: routes,
);
   }
 }
