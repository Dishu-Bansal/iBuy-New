import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/screens/grocery_budget_screen.dart';
import 'package:freelance_ibuy_app/screens/routes.dart';
import 'package:freelance_ibuy_app/utils.dart';
import 'package:image_picker/image_picker.dart';

class InputUserDetails extends StatefulWidget {
  final String email;
  final String password;
  static String imgUrl = "";
  const InputUserDetails(
      {super.key, required this.email, required this.password});

  @override
  State<InputUserDetails> createState() => _InputUserDetailsState();
}

class _InputUserDetailsState extends State<InputUserDetails> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _img;

  var isLoading = false;

  bool validateInputs() {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  imgFromCamera() async {
    XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    if (pickedFile?.path != null) {
      setState(() {
        _img = File(
          pickedFile?.path ?? "",
        );
      });
    }
  }

  imgFromGallery() async {
    XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile?.path != null) {
      setState(() {
        _img = File(
          pickedFile?.path ?? "",
        );
      });
    }
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: SizedBox(
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      imgFromCamera();
                      Navigator.pop(context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.camera_alt),
                        Text(
                          "Open Camera",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 5, bottom: 5),
                    height: MediaQuery.of(context).size.width * .2,
                    width: 2,
                    color: Colors.grey,
                  ),
                  GestureDetector(
                    onTap: () async {
                      await imgFromGallery();
                      Navigator.pop(context);
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.photo_library),
                        Text(
                          "Select From Library",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Widget imageGet() {
    return Stack(
      children: [
        (_img != null && _img != "")
            ? Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: FileImage(
                      _img!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : Container(
                height: 120,
                width: 120,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
        Positioned(
          right: 5,
          bottom: 5,
          child: GestureDetector(
            onTap: () {
              showPicker(context);
            },
            child: Container(
              height: 30,
              width: 30,
              padding: const EdgeInsets.all(0),
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                shape: BoxShape.circle,
              ),
              child: const Center(child: Icon(Icons.edit)),
            ),
          ),
        ),
      ],
    );
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> uploadPic(File imageFile) async {
    String imgPath = imageFile.path.split("/").last;
    Reference reference = _storage
        .ref()
        .child("images/${FirebaseAuth.instance.currentUser?.uid}/$imgPath");
    Task upload = reference.putFile(imageFile);
    await upload.then((v) async {
      String url = await v.ref.getDownloadURL();
      setState(() {
        InputUserDetails.imgUrl = url;
      });
    });
  }

  void save() async {
    setState(() {
      isLoading = true;
    });

    //if the user has not selected any image then set null to imgUrl
    if (_img == null) {
      InputUserDetails.imgUrl = "";
    } else {
      await uploadPic(_img!);
    }

    await userUploadToDB();

    setState(() {
      isLoading = false;
    });
  }

  Future<void> userUploadToDB() async {
    // await uploadPic(_img!);
    String id = await FirebaseAuth.instance.currentUser!.uid;
    Map<String, dynamic> data = {
      "uid": id,
      "img_url": InputUserDetails.imgUrl,
      "email": widget.email,
      "name": nameController.text.toString().trim(),
      "createdAt": DateTime.now().millisecondsSinceEpoch,
      "mailing_address": "Not Setup yet",
      "budget": 0,
      "postalCode": 0,
      "plan_id": "",
      "cards": [],
      "endDate": 0,
      "startDate": 0,
    };
    await FirebaseFirestore.instance
        .collection("User")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(data)
        .then((va) async {
      Utils().getDataFromDB(id);
      //showToast("Thanks for Sign Up", context);

      AppRoutes.push(context, GroceryBudgetScreen(false));

      // infoDialogue(context, "Thanks you for applying,\n We’ll come back to you soon.");
    });
  }

  // void showToast(String msg, context) {
  //   FlutterToastr.show(
  //     msg,
  //     context,
  //     duration: 2,
  //     position: FlutterToastr.center,
  //     backgroundColor: Colors.green,
  //     textStyle: const TextStyle(
  //       color: Colors.white,
  //       fontSize: 12,
  //       fontWeight: FontWeight.w700,
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  color: Color(0xffFEC107),
                )
              : Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Edit your Profile",
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              imageGet(),
                              const SizedBox(height: 40),
                              TextFormField(
                                controller: nameController,
                                cursorColor: Colors.black45,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(
                                    Icons.email,
                                    color: Colors.black45,
                                  ),
                                  labelText: "Enter your full Name",
                                  //border: OutlineInputBorder(),
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelStyle:
                                      const TextStyle(color: Colors.black45),

                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35.0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(35.0),
                                    borderSide: const BorderSide(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Name cannot be empty";
                                  }
                                  return null;
                                },
                              ),

                              //Generate UI on an image picker
                            ],
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => save(),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xffFEC107),
                              borderRadius: BorderRadius.circular(25),
                            ),
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: const Center(
                              child: Text(
                                "Next",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 14),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
