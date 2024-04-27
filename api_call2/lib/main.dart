import 'dart:convert';
import 'package:api_call2/Models/userModels.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
void main() {
  runApp(const ApiCall2());
}

class ApiCall2 extends StatefulWidget {
  const ApiCall2({super.key});

  @override
  State<ApiCall2> createState() => _ApiCall2State();
}

class _ApiCall2State extends State<ApiCall2> {

  List<UserModels> userList = [];
  Future<List<UserModels>> getUserApi() async {
    final response = await get(Uri.parse("https://jsonplaceholder.typicode.com/users"));

    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
         for(Map i in data){
           userList.add(UserModels.fromJson(i));
         }

      return userList;
  }else{
      return userList;
    }
    }


  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow,
          centerTitle: true,
          title: const Text("Hard Fetching Api",style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),),
        ),
        body: Column(
          children: [
             Expanded(
                 child: FutureBuilder(
              future: getUserApi(),
              builder: (context , AsyncSnapshot<List<UserModels>> snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: Text("Loading..",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),),
                  );
                } else {
                  return ListView.builder(
                      itemCount: userList.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: Column(
                            children: [
                              ReuseAbleRow(title: "name", value: snapshot.data![index].name.toString()),
                              ReuseAbleRow(title: "Username", value: snapshot.data![index].username.toString()),
                              ReuseAbleRow(title: "email", value: snapshot.data![index].email.toString()),
                              ReuseAbleRow(title: "address", value: snapshot.data![index].address!.city.toString()),
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
