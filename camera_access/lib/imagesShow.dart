import 'dart:convert';
// import 'dart:html';
import 'dart:io';
// import 'dart:html';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart'as http;


class ImageShow extends StatefulWidget {
  const ImageShow({super.key});

  @override
  State<ImageShow> createState() => _ImageShowState();
}

class _ImageShowState extends State<ImageShow> {

   List? datas = [] ;



 Future<void> getImages() async {
    // try {
    //   var uri = Uri.parse("http://192.168.18.4:1212/getimage");
    //   var request = http.MultipartRequest('Get', uri);
    //   // request.files.add(await http.MultipartFile.fromPath('file', pickedImage!.path));
 


 const url = 'http://192.168.18.4:1212/getimage' ;
final uri = Uri.parse(url);
final response = await  http.get(uri);
final body = response.body;
final json = jsonDecode(body) ;

setState(() {

  datas = json;

});
// Uint8List ul =  Uint8List(json["data"]["data"]) ;

print( json) ;
// print(ul) ;


 

    //  print(base64.decode(json['data']['data']) ) ;
    //  print(img!) ;
    //  print(body) ;
    //   print(request);
      
    //   var res = await request.get();
    //   if (res.statusCode == 200) {
    //     print("Send") ;
    //     // return true;
    //   } else {
    //     print("Not Send") ;
    //     // return false;
    //   }
    // } catch (err) {
    //     print("Error") ;
    // }
      
  }











  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text("Images Viewer")),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
          ElevatedButton(onPressed: getImages, child: Text("Get Images")),
          Expanded(
            child: ListView.builder(
               itemCount:datas!.length,
               itemBuilder: (context, i) {
                 return(
             datas != null ?Padding(
               padding: const EdgeInsets.symmetric(vertical: 12),
               child: Row(
                 children: [
                   Image.network(
                                    '${datas![i]['img']}',
                                    width: 170,
                                    height: 170,
                                    fit: BoxFit.cover,
                                  ),
                 ],
               ),
             ) : Container()  
                 );
               },
            ),
          ),
       
          
        ]),
    );
  }
}






