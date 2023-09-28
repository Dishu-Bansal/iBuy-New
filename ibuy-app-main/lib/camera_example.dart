// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:freelance_ibuy_app/constants.dart';
import 'package:freelance_ibuy_app/models/myuser.dart';
import 'package:freelance_ibuy_app/screens/receipt_upload_screen.dart';
import 'package:freelance_ibuy_app/screens/routes.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

/// Camera example home widget.
class CameraExampleHome extends StatefulWidget {
  /// Default Constructor
  const CameraExampleHome({Key? key}) : super(key: key);

  @override
  State<CameraExampleHome> createState() {
    return _CameraExampleHomeState();
  }
}

void _logError(String code, String? message) {
  // ignore: avoid_print
  print('Error: $code${message == null ? '' : '\nError Message: $message'}');
}

class _CameraExampleHomeState extends State<CameraExampleHome>
    with WidgetsBindingObserver, TickerProviderStateMixin {
  bool isLoading = false;

  Future<void> getCameras() {
    return availableCameras().then((value) => _cameras = value);
  }

  CameraController? controller;
  bool _initialized = false;
  XFile? imageFile;
  XFile? videoFile;
  VideoPlayerController? videoController;
  VoidCallback? videoPlayerListener;
  bool enableAudio = true;

  double _currentScale = 1.0;
  double _baseScale = 1.0;

  // Counting pointers (number of user fingers on screen)
  int _pointers = 0;

  @override
  void initState() {
    super.initState();
    getCameras().then((value) {
      setState(() {});
    });

    WidgetsBinding.instance.addObserver(this);

    _initCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    controller?.dispose();
    super.dispose();
  }

  // #docregion AppLifecycle
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    @override
    void didChangeAppLifecycleState(AppLifecycleState state) {
      // App state changed before we got the chance to initialize.
      if (controller == null || !controller!.value.isInitialized) {
        return;
      }
      if (state == AppLifecycleState.inactive) {
        controller?.dispose();
      } else if (state == AppLifecycleState.resumed) {
        if (controller != null) {
          _initCamera();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton:
          imageFile == null ? _captureControlRowWidget() : SizedBox(),
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.only(top: 25),
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back,
                      size: 25,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(0.0),
                child: Center(
                  child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: imageFile == null
                          ? Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              child: _cameraPreviewWidget(),
                            )
                          : Container(
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  image: FileImage(
                                    File(imageFile!.path),
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        imageFile != null
                            ? (isLoading
                                ? const CircularProgressIndicator(
                                    color: goldColor,
                                  )
                                : RawMaterialButton(
                                    onPressed: () {
                                      save();
                                    },
                                    fillColor: goldColor,
                                    shape: const CircleBorder(),
                                    padding: const EdgeInsets.all(15),
                                    child: const Icon(
                                      Icons.upload,
                                      size: 50,
                                    ),
                                  ))
                            : SizedBox(),
                        imageFile != null
                            ? RawMaterialButton(
                                onPressed: () {
                                  clear();
                                },
                                fillColor: goldColor,
                                shape: const CircleBorder(),
                                padding: const EdgeInsets.all(15),
                                child: const Icon(
                                  Icons.refresh,
                                  size: 50,
                                ),
                              )
                            : SizedBox(),
                      ]),
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }

  /// Display the preview from the camera (or a message if the preview is not available).
  Widget _cameraPreviewWidget() {
    if (controller == null || !_initialized) {
      return const Text(
        '',
        style: TextStyle(
          color: Colors.black,
          fontSize: 22.0,
          fontWeight: FontWeight.w500,
        ),
      );
    } else {
      return Listener(
        onPointerDown: (_) => _pointers++,
        onPointerUp: (_) => _pointers--,
        child: CameraPreview(
          controller!,
          child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onScaleStart: _handleScaleStart,
              onScaleUpdate: _handleScaleUpdate,
              onTapDown: (TapDownDetails details) =>
                  onViewFinderTap(details, constraints),
            );
          }),
        ),
      );
    }
  }

  void _handleScaleStart(ScaleStartDetails details) {
    _baseScale = _currentScale;
  }

  Future<void> _handleScaleUpdate(ScaleUpdateDetails details) async {
    // When there are not exactly two fingers on screen don't scale
    if (controller == null || _pointers != 2) {
      return;
    }

    await controller!.setZoomLevel(_currentScale);
  }

  /// Display the control bar with buttons to take pictures and record videos.
  Widget _captureControlRowWidget() {
    final CameraController? cameraController = controller;

    return FloatingActionButton.large(
      onPressed: cameraController != null &&
              cameraController.value.isInitialized &&
              !cameraController.value.isRecordingVideo
          ? onTakePictureButtonPressed
          : null,
      backgroundColor: goldColor,
    );
  }

  Future<void> _initCamera() async {
    final cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.high);
    controller?.initialize().then((_) {
      setState(() {
        _initialized = true;
      });
    });
  }

  /// Display a row of toggle to select the camera (or a message if no camera is available).
  Widget _cameraTogglesRowWidget() {
    final List<Widget> toggles = <Widget>[];

    // void onChanged(CameraDescription? description) {
    //   if (description == null) {
    //     return;
    //   }

    //   onNewCameraSelected(description);
    // }

    if (_cameras.isEmpty) {
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        //showInSnackBar('No camera found.');
      });
      return const Text('None');
    } else {
      // for (final CameraDescription cameraDescription in _cameras) {
      //   toggles.add(
      //     SizedBox(
      //       width: 90.0,
      //       child: RadioListTile<CameraDescription>(
      //         title: Icon(getCameraLensIcon(cameraDescription.lensDirection)),
      //         groupValue: controller?.description,
      //         value: cameraDescription,
      //         onChanged:
      //             controller != null && controller!.value.isRecordingVideo
      //                 ? null
      //                 : onChanged,
      //       ),
      //     ),
      //   );1
      // }
    }

    return Row(children: toggles);
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void showInSnackBar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    if (controller == null) {
      return;
    }

    final CameraController cameraController = controller!;

    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    try {
      controller = CameraController(
        cameraDescription,
        kIsWeb ? ResolutionPreset.max : ResolutionPreset.medium,
        enableAudio: enableAudio,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      await controller?.initialize();

      // If the controller is updated then update the UI.
      controller?.addListener(() async {
        if (mounted) {
          setState(() {});
        }
        if (controller?.value.hasError ?? false) {
          showInSnackBar('Camera error ${controller?.value.errorDescription}');
        }
      });
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          showInSnackBar('You have denied camera access.');
          break;
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable camera access.');
          break;
        case 'CameraAccessRestricted':
          // iOS only
          showInSnackBar('Camera access is restricted.');
          break;
        case 'AudioAccessDenied':
          showInSnackBar('You have denied audio access.');
          break;
        case 'AudioAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable audio access.');
          break;
        case 'AudioAccessRestricted':
          // iOS only
          showInSnackBar('Audio access is restricted.');
          break;
        default:
          _showCameraException(e);
          break;
      }
    }

    if (mounted) {
      setState(() {});
    }
  }

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final ImagePicker _picker = ImagePicker();

  Future<void> uploadPic(XFile imageFile) async {
    setState(() {
      //isLoading = true;
    });
    String imgPath = imageFile.path.split("/").last;
    Reference reference = _storage
        .ref()
        .child("receipts/${FirebaseAuth.instance.currentUser?.uid}/$imgPath");
    Task upload = reference.putFile(File(imageFile.path));
    // Task upload = reference.putFile(imageFile as File);
    await upload.then((v) async {
      String url = await v.ref.getDownloadURL();
      print(url);
      setState(() {
        ReceiptUploadScreen.receiptUrl = url;
        //isLoading = false;
      });
      // getFcm();
    });
  }

  void clear() {
    setState(() {
      imageFile = null;
      ReceiptUploadScreen.receiptUrl = "";
    });
  }

  imgFromGallery() async {
    XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    setState(() {
      imageFile = pickedFile;
    });
  }

  void save() async {
    await uploadPic(imageFile!);
    print(imageFile);
    print(ReceiptUploadScreen.receiptUrl);
    if (ReceiptUploadScreen.receiptUrl != "" && imageFile != null) {
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

  void saveImage() {
    FirebaseFirestore.instance.collection("receipts").doc().set({
      "receiptUrl": ReceiptUploadScreen.receiptUrl,
      "user_uid": FirebaseAuth.instance.currentUser?.uid,
      "time": DateTime.now().toString(),
      "retailerName": "",
      "status": "Pending",
      "totalSpend": "",
      "trxDate": "",
      "last4Digits": "",
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

  void onTakePictureButtonPressed() {
    takePicture().then((XFile? file) {
      if (mounted) {
        setState(() {
          imageFile = file;
          videoController?.dispose();
          videoController = null;
        });
        if (file == null) {
          //upload the picture to firebase
          //save();
          showInSnackBar('Unknown Error');
        }
      }
    });
  }

  Future<XFile?> takePicture() async {
    final CameraController? cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  void _showCameraException(CameraException e) {
    _logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }
}

/// CameraApp is the Main Application.
class CameraApp extends StatelessWidget {
  @override
  const CameraApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // //getCameras().then((value) {
    //   print(_cameras);
    // });
    return const MaterialApp(
      home: CameraExampleHome(),
    );
  }
}

List<CameraDescription> _cameras = <CameraDescription>[];
