import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:freelance_ibuy_app/constants.dart';
import 'package:freelance_ibuy_app/models/myuser.dart';
import 'package:freelance_ibuy_app/screens/routes.dart';
import 'package:image_picker/image_picker.dart';

class ReceiptUploadScreen extends StatefulWidget {
  static String receiptUrl = "";

  const ReceiptUploadScreen({super.key});

  @override
  State<ReceiptUploadScreen> createState() => _ReceiptUploadScreenState();
}

class _ReceiptUploadScreenState extends State<ReceiptUploadScreen> {
  final ImagePicker _picker = ImagePicker();
  File? _img;

  var isLoading = false;

  imgFromCamera() async {
    XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    setState(() {
      _img = File(
        pickedFile?.path ?? "",
      );
    });
  }

  imgFromGallery() async {
    XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      _img = File(
        pickedFile?.path ?? "",
      );
    });
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: SizedBox(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text(
                    "Select Preferred Option",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          imgFromCamera();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Open Camera",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5, bottom: 5),
                        height: 2,
                        width: MediaQuery.of(context).size.width * .8,
                        color: Colors.grey,
                      ),
                      GestureDetector(
                        onTap: () async {
                          await imgFromGallery();
                          Navigator.pop(context);
                        },
                        child: const Text(
                          "Select From Library",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(),
                ],
              ),
            ),
          );
        });
  }

  Widget imageGet() {
    return Stack(
      children: [
        _img != null
            ? Container(
                height: MediaQuery.of(context).size.height * .5,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  image: DecorationImage(
                    image: FileImage(
                      _img!,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              )
            : Container(
                height: MediaQuery.of(context).size.height * .3,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: goldColor,
                  shape: BoxShape.circle,
                ),
                child: GestureDetector(
                  onTap: () {
                    showPicker(context);
                  },
                  child: const Icon(
                    CupertinoIcons.cloud_upload,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
        _img == null
            ? const SizedBox()
            : Positioned(
                right: 10,
                bottom: 10,
                child: GestureDetector(
                  onTap: () {
                    showPicker(context);
                  },
                  child: Container(
                    height: 35,
                    width: 35,
                    padding: const EdgeInsets.all(0),
                    decoration: const BoxDecoration(
                      color: goldColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(child: Icon(Icons.replay_outlined)),
                  ),
                ),
              ),
      ],
    );
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<void> uploadPic(File imageFile) async {
    setState(() {
      isLoading = true;
    });
    String imgPath = imageFile.path.split("/").last;
    Reference reference = _storage
        .ref()
        .child("receipts/${FirebaseAuth.instance.currentUser?.uid}/$imgPath");
    Task upload = reference.putFile(imageFile);
    await upload.then((v) async {
      String url = await v.ref.getDownloadURL();
      print(url);
      setState(() {
        ReceiptUploadScreen.receiptUrl = url;
        isLoading = false;
      });
      // getFcm();
    });
  }

  void clear() {
    setState(() {
      _img = null;
      ReceiptUploadScreen.receiptUrl = "";
    });
  }

  void saveImage() {
    FirebaseFirestore.instance.collection("receipts").doc().set({
      "receiptUrl": ReceiptUploadScreen.receiptUrl,
      "user_uid": FirebaseAuth.instance.currentUser?.uid,
      "time": DateTime.now().millisecondsSinceEpoch,
      "retailerName": "",
      "status": "",
      "totalSpend": "",
      "trxDate": "",
      "last4Digits": "",
      "update_time": DateTime.now().millisecondsSinceEpoch,
      "plan_id": Userr.userData.planId,
    }).then((value) {
      //Display a snackbar with success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Receipt Uploaded Successfully"),
        ),
      );

      AppRoutes.pop(context);
    }).catchError((onError) {
      //Display a snackbar with error message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Error Uploading Receipt"),
        ),
      );
    });
  }

  void save() async {
    await uploadPic(_img!);
    print(_img);
    print(ReceiptUploadScreen.receiptUrl);
    if (ReceiptUploadScreen.receiptUrl != "" && _img != null) {
      setState(() {
        isLoading = true;
      });

      saveImage();

      //wait for 2 seconds
      await Future.delayed(const Duration(seconds: 2));
      clear();

      setState(() {
        isLoading = false;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Select the receipt image."),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_img == null) {
      imgFromCamera();
    }
    print(_img);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Upload Receipt",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              imageGet(),
              _img == null
                  ? const SizedBox()
                  : isLoading
                      ? const CircularProgressIndicator(
                          color: goldColor,
                        )
                      : GestureDetector(
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
                                "Upload Receipt",
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
    );
  }
}
