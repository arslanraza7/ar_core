import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'augmented_reality/augmented_preview.dart';


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
      setState(() {
        loadingCamera = false;
      });

      print('controller value');
      print(controller.toString());
    } catch (e) {
      setState(() {
        loadingCamera = false;
      });
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
  double xPosition = 130;
  double yPosition = 150;
  double height = 150;
  double onchange = 150;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      loadingCamera?
      Center(
        child: CircularProgressIndicator(),
      ):

      Stack(
        children: [
          Container(
              height: 1000,
              width: MediaQuery.of(context).size.width,
              child: ArWidget(controller)),
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
                  child: Image.network('https://freepngimg.com/thumb/3d/32378-7-3d-photos-thumb.png', height: onchange,width: onchange,)),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 10,
              child: Slider(
                value: onchange,
                min: 10,
                max: 300,
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



