import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:login/services/crud.dart';
import 'package:image_picker/image_picker.dart';
import 'package:login/utils/widgets/loading.dart';
import 'package:random_string/random_string.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({super.key});

  @override
  _CreateBlogState createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
  late String authorName, title, desc;
  String? userId = FirebaseAuth.instance.currentUser?.uid;

  File? selectedImage;
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();
  //CrudMethods crudMethods = new CrudMethods();

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (image == null) {
      return;
    }

    setState(() {
      selectedImage = File(image.path);
    });
  }

  uploadBlog() async {
     
    if (selectedImage != null && _formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      /// uploading image to firebase storage
      Reference firebaseStorageRef = FirebaseStorage.instance
          .ref()
          .child("blogs")
          .child("${randomAlphaNumeric(9)}.jpg");

      final task = await firebaseStorageRef.putFile(selectedImage!);

      //var downloadUrl = await (await task.onComplete).ref.getDownloadURL();

      //task.whenComplete(() => print("Upload Complete"));
      String downloadURL = await firebaseStorageRef.getDownloadURL();
      //print("---------------------");
      //print('Download URL: $downloadURL');

      Map<String, String> blogMap = {
        "imgUrl": downloadURL,
        "authorName": authorName,
        "title": title,
        "desc": desc,
        "id": userId!,
      };
      FirebaseFirestore.instance
          .collection("blogs")
          .doc()
          .set(blogMap)
          .catchError((e) {
        //print(e);
      }).then((result) {
        Navigator.pop(context);
      });
    } else {
      //print("---------------------");
      //print("Did not upload");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _isLoading
          ? Container(
              alignment: Alignment.center,
              child: const LoadingScreen(),
            )
          : WillPopScope(
            onWillPop: () async {
          bool willLeave = false;
          // show the confirm dialog
          await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: const Text('Are you sure want to leave?'),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            willLeave = true;
                            Navigator.of(context).pop();
                          },
                          child: const Text('Yes')),
                      TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('No'))
                    ],
                  ));
          return willLeave;
        },
            child: Container(
                child: Column(
                  children: <Widget>[
                    const SizedBox(
                      height: 10,
                    ),
                    GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: selectedImage != null
                            ? Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                height: 170,
                                width: MediaQuery.of(context).size.width,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(6),
                                  child: Image.file(
                                    selectedImage!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              )
                            : Container(
                                margin: EdgeInsets.symmetric(horizontal: 16),
                                height: 170,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(6)),
                                width: MediaQuery.of(context).size.width,
                                child: const Icon(
                                  Icons.add_a_photo,
                                  color: Colors.black45,
                                ),
                              )),
                    const SizedBox(
                      height: 8,
                    ),
                    Form(
                      key: _formKey,
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Empty field";
                                }
                              },
                              decoration: InputDecoration(hintText: "Author Name"),
                              onSaved: (val) {
                                authorName = val!;
                              },
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Empty field";
                                }
                              },
                              decoration: InputDecoration(hintText: "Title"),
                              onSaved: (val) {
                                title = val!;
                              },
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Empty field";
                                }
                              },
                              maxLines: null,
                              decoration: InputDecoration(hintText: "Desc"),
                              onSaved: (val) {
                                desc = val!;
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: ElevatedButton.icon(
                        onPressed: uploadBlog,
                        icon: const Icon(Icons.file_upload),
                        label: const Text("Upload Blog"),
                      ),
                    ),
                  ],
                ),
              ),
          ),
    );
  }
}
