import 'dart:convert';
import 'package:http/http.dart';
import 'package:flutter/material.dart';
void main(){
  runApp(const ApiCall());
}
class ApiCall extends StatefulWidget {
  const ApiCall({super.key});

  @override
  State<ApiCall> createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {

  List<Photos> photosList = [];
  Future<List<Photos>> getPhotos() async {
    final response = await get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));

    var data = jsonDecode(response.body.toString());
    photosList.clear();
    if(response.statusCode==200){
      for(Map i in data){
        Photos photos = Photos(title: i["title"], url: i["url"], id:i["id"]);
        photosList.add(photos);
      }
      return photosList;
    }else{
      return photosList;
    }


  }
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text("self Created Models",style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),),
          centerTitle: true,

        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getPhotos(),
                  builder: (context,AsyncSnapshot<List<Photos>>snapshots)
              {
                if(!snapshots.hasData){
                  return const Center(
                    child: Text("Loading...",style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),),
                  );

                }else{
                  return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index ){
                        return ListTile(
                          leading:CircleAvatar(
                            backgroundImage: NetworkImage(
                               snapshots.data![index].url.toString()
                            ),
                          ),

                          title:Text( snapshots.data![index].title.toString())
                        );
                      }
                  );
                }
              }
              ),
            )
          ],
        ),
      ),
    );
  }
}


class Photos {
  String title , url;
  int id;
  Photos({required this.title,required this.url,required this.id});
}