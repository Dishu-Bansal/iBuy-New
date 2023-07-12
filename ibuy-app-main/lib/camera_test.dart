import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

late List<CameraDescription> _cameras;

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(const CameraApp());
// }

/// CameraApp is the Main Application.
class CameraApp extends StatefulWidget {
  ///
  const CameraApp({Key? key}) : super(key: key);

  @override
  State<CameraApp> createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;

  //future function to get the list of cameras
  Future<void> getCameras() async {
    _cameras = await availableCameras();
    //print(_cameras);
  }

  @override
  void initState() {
    super.initState();
    //call the future function to get the list of cameras
    getCameras().then((value) {
      setState(() {
        //initialize the camera controller
        controller = CameraController(_cameras[0], ResolutionPreset.max);
        controller.initialize().then((_) {
          if (!mounted) {
            return;
          }
          setState(() {});
        }).catchError((Object e) {
          if (e is CameraException) {
            switch (e.code) {
              case 'CameraAccessDenied':
                // Handle access errors here.
                break;
              default:
                // Handle other errors here.
                break;
            }
          }
        });
      });
    });
    //initialize the camera controller

    // controller = CameraController(_cameras[0], ResolutionPreset.max);
    // controller.initialize().then((_) {
    //   if (!mounted) {
    //     return;
    //   }
    //   setState(() {});
    // }).catchError((Object e) {
    //   if (e is CameraException) {
    //     switch (e.code) {
    //       case 'CameraAccessDenied':
    //         // Handle access errors here.
    //         break;
    //       default:
    //         // Handle other errors here.
    //         break;
    //     }
    //   }
    //});
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print(_cameras);

    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: Column(
        children: [
          CameraPreview(controller),
        ],
      ),
    );
  }
}
