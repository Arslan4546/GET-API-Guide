import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'Models/products_model.dart';

void main(){
  runApp(const MyApp());
}
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future<ProductsModel> getProducts() async {
    final response = await get(Uri.parse("https://webhook.site/d24f9761-dfba-4759-bcda-f42f3dd539b7"));
    var data = jsonDecode(response.body.toString());
    if(response.statusCode==200){
      return ProductsModel.fromJson(data);

    }else{
      return ProductsModel.fromJson(data);
    }
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
    debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          centerTitle: true,
          title: const Text("Tough intergration",style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),),
        ),
        body:  Column(
          children: [
           Expanded(
             child:FutureBuilder<ProductsModel>(
                 future: getProducts(),
                 builder: (context, snapshot){
               if(!snapshot.hasData){
                 return const Center(
                   child:  Text("Loading..",style: TextStyle(fontWeight: FontWeight.bold,
                   fontSize: 22,
                     color: Colors.black,
                   ),),
                 );
               }else{
                 return ListView.builder(
                     itemCount: snapshot.data!.data!.length,
                     itemBuilder: (context, index){
                        return Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height*.3,
                              width: MediaQuery.of(context).size.width*1,
                             child: ListView.builder(
                               scrollDirection: Axis.horizontal,
                                 itemCount: snapshot.data!.data![index].images!.length,
                                 itemBuilder: (context,position){
                                     return Container(
                                       height: MediaQuery.of(context).size.height*.3,
                                       width: MediaQuery.of(context).size.width*1,
                                       decoration: BoxDecoration(
                                         image: DecorationImage(
                                           image: NetworkImage(
                                             snapshot.data!.data![index].images![position].url.toString()
                                           ),
                                         )
                                       ),
                                     );
                                 }),

                            )
                          ],
                        );
                 });
               }
             })
           )
          ],
        ),
      ),
    );
  }
}
