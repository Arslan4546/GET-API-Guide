import 'package:flutter/material.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("API Intergration!",style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,

          ),),
          centerTitle: true,

        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
             Center(
               child: SizedBox(
                 height: 50,
                 width: 130,
                 child: ElevatedButton(
                     style: ButtonStyle(
                       backgroundColor: MaterialStateProperty.all(Colors.blue),

                     ),
                     onPressed: (){
                   Navigator.pushNamed(context, "/screen1");
                 },

                     child: const Text(
                       "Go TO Home",
                       style: TextStyle(
                         color: Colors.white,
                         fontWeight: FontWeight.bold,

                       ),
                     )),
               ),
             )
          ],
        ),
      );


  }
}
