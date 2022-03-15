import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'augmented_reality/camera_preview.dart';



class Augmented extends StatefulWidget {

  @override
  _AugmentedState createState() => _AugmentedState();
}

class _AugmentedState extends State<Augmented> {
  var controller;
  List<CameraDescription> cameras = [];
  bool loadingCamera = false;
  void loadCamera() async {
    setState(() {
      loadingCamera = true;
    });
    try {
      cameras = await availableCameras();
      controller = CameraController(cameras[0], ResolutionPreset.ultraHigh);
      await controller.initialize();
      loadingCamera = false;

      print('controller value');
      print(controller.toString());
    } catch (e) {
      loadingCamera = false;
      print(e.toString());
    }

    /// Timer

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadCamera();
  }
  double xPosition = 0;
  double yPosition = 0;
  double height = 150;
  double onchange = 22;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Testing'),
      ),
      body: Stack(
        children: [
          Container(
              height: 1000,
              width: MediaQuery.of(context).size.width,
              child: CameraWidget(controller)),
          Positioned(
            top: yPosition,
            left: xPosition,
            child: GestureDetector(


              onPanUpdate: (tapInfo) {
                setState(() {

                  xPosition += tapInfo.delta.dx;
                  yPosition += tapInfo.delta.dy;
                });
              },
              child:
              Container(
                  height: onchange,
                  color: Colors.transparent,
                  child: Image.asset('assets/female.png', height: onchange,width: onchange,)),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              child: Slider(
                value: onchange,
                min: 20,
                max: 100,
                onChanged: (value){
                  setState(() {
                    onchange = value;
                  });
                },
              )
          )
        ],
      ),
    );
  }
}

