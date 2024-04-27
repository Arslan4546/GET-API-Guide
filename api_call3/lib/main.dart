import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
// hard fetching api when you are not able to make the models of the api data
void main(){
  runApp(const Method());
}
class Method extends StatefulWidget {
  const Method({super.key});

  @override
  State<Method> createState() => _MethodState();
}

class _MethodState extends State<Method> {


  var data;

  Future<void> getUserApi() async {
    final response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/users"));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    }

  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          centerTitle: true,
          title: const Text("Hard Fetching Api", style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),),
        ),
        body: Column(
          children: [
            Expanded(
                child: FutureBuilder(
                  future: getUserApi(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Text("Loading..", style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),),
                      );
                    } else {
                      return ListView.builder(
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            return Card(
                              child: Column(
                                children: [
                                  ReuseAbleRow(title: "name", value:data[index]["name"].toString() ),
                                  ReuseAbleRow(title: "username", value:data[index]["username"].toString() ),
                                  ReuseAbleRow(title: "address", value:data[index]["address"]["city"].toString() ),
                                  ReuseAbleRow(title: "street", value:data[index]["address"]["street"].toString() ),
                                  ReuseAbleRow(title: "geo", value:data[index]["address"]["geo"]["lat"].toString() ),
                                ],
                              ),
                            );
                          });
                    }
                  },)),
          ],
        ),
      ),
    );
  }
}
class ReuseAbleRow extends StatelessWidget {
  String title;
  String value;
  ReuseAbleRow({required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment
            .spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}