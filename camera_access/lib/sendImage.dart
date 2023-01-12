// import 'dart:html';
import 'package:camera_access/imagesShow.dart';
import 'package:http/http.dart'as http;
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart';
import 'dart:convert' ;
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';



class SendImage extends StatefulWidget {
  const SendImage({super.key});

  @override
  State<SendImage> createState() => _SendImageState();
}

class _SendImageState extends State<SendImage> {


  File? pickedImage ;
  PickedFile ? photo ; 

void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
          ),
          child: Container(
            color: Colors.white,
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pic Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                    pickImage(ImageSource.camera);
                    },
                    icon: const Icon(Icons.camera),
                    label: const Text("CAMERA"),
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                    pickImage(ImageSource.gallery);
                    
                    },
                    icon: const Icon(Icons.image),
                    label: const Text("GALLERY"),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.close),
                    label: const Text("CANCEL"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }





  Future<void> pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
        
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }





//   senddata()async{


// var formData = FormData.fromMap({
//   'name': 'wendux',
//   'age': 25,
//   'file': await MultipartFile.fromFile('./text.txt',filename: 'upload.txt')
// });
// response = await dio.post('/info', data: formData);


//   }




// Future uploadData(imageFilePath, url) async {
//   var request = http.MultipartRequest('POST', Uri.parse("http://192.168.18.4:8585/upload"));
 
//     await http.MultipartFile.fromPath(
//       'file',
//       imageFilePath,
//       filename:
//           'image1.jpg',
//     )
    
    


//     var res = await request.send();
//     return res.statusCode;
  

  
// }

 Future<void> uploadFileAsFormData() async {
    try {
      var uri = Uri.parse("http://192.168.18.4:1212/uploadimage");
      var request = http.MultipartRequest('POST', uri);
      // request.files.add(await http.MultipartFile.fromPath('file', pickedImage!.path));
 
 var stream = await http.ByteStream(pickedImage!.openRead());
  var length = await pickedImage!.length();
 var multipartFile = await http.MultipartFile('user_file', stream
 , length, filename: pickedImage!.path
 );
 
// ..............






// ..............
      request.headers["Content-Type"] = "multipart/form-data" ;
      request.headers["Accept"] = "multipart/form-data" ;
      request.fields["name"] = "Hamza" ;
      request.fields["college"] = "Sir Syed" ;
      request.fields["age"] = "19" ;
      request.files.add(multipartFile) ;
      // print(request);
      
      var res = await request.send();
      if (res.statusCode == 200) {
        // print(res);
        print("Send") ;
        // return true;
      } else {
        print("Not Send") ;
        // return false;
      }
    } catch (err) {
        print("Error") ;
    }
      
  }








  @override
 


  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Image Picker")),
        ),
        body:  Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 50,
          ),
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigo, width: 5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(100),
                    ),
                  ),
                  child: ClipOval(
                    child: 
                    pickedImage != null
                        ? Image.file(
                            pickedImage!,
                            width: 170,
                            height: 170,
                            fit: BoxFit.cover,
                          )
                        : 
                        Image.network(
                            'https://images.pexels.com/photos/39501/lamborghini-brno-racing-car-automobiles-39501.jpeg?cs=srgb&dl=pexels-pixabay-39501.jpg&fm=jpg',
                            width: 170,
                            height: 170,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 5,
                  child: IconButton(
                    onPressed: imagePickerOption,
                    icon: const Icon(
                      Icons.add_a_photo_outlined,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
                onPressed: imagePickerOption,
                icon: const Icon(Icons.add_a_photo_sharp),
                label: const Text('UPLOAD IMAGE')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
                onPressed: uploadFileAsFormData,
                icon: const Icon(Icons.post_add),
                label: const Text('POST IMAGE')),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton.icon(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ImageShow()));
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Go to Images')),
          )
        ],
      ),
    );
}
}



















