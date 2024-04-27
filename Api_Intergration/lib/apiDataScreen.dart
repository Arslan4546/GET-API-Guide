import 'dart:convert';
import 'package:api_integration/Models/postsModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
class ApiScreen extends StatefulWidget {
  const ApiScreen({super.key});

  @override
  State<ApiScreen> createState() => _ApiScreenState();
}

class _ApiScreenState extends State<ApiScreen> {
  List<PostsModel> postsList = [];

  Future<List<PostsModel>> getPosts() async {
    final response =
    await get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    var data = jsonDecode(response.body.toString());
   postsList.clear();
   if(response.statusCode==200){
     for(Map i in data){
       postsList.add(PostsModel.fromJson(i));

     }
     return postsList;
   }
     else{
       return postsList;

   }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text("Fetch Data From API",style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
                      ),),
        ),
      body: Column(
        children: [
        Flexible(
          child: FutureBuilder(
              future: getPosts(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return const Center(
                    child: Text("Loading...",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,

                    ),),
                  );
                }
                else
                {
                  return ListView.builder(
                      itemCount: postsList.length,
                      itemBuilder: (context,index){
                        return Container(
                          height: 200,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                          decoration: const BoxDecoration(
                              color: Colors.yellow,
                              boxShadow: [
                                BoxShadow(
                                  blurRadius: 2.0,


                                )
                              ]
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(postsList[index].id.toString()),
                                 const  SizedBox(width: 10,),
                                  const Text("Title",style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),),

                                ],
                              ),

                              const  Text("Discription"),
                              Text(postsList[index].body.toString()),
                            ],
                          ),
                        );
                      });
                }
              }

          ),
        ),

        ],
      ),
      );

  }
}
