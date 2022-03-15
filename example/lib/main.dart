import 'package:ar_core/ar_core.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';



List<CameraDescription> cameras = [];
Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    cameras = await availableCameras();
  } on CameraException catch (e) {
    print(e.description);
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Augmented Reality Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  const AugmentedReality(),
    );
  }
}

class AugmentedReality extends StatefulWidget {
  const AugmentedReality({Key? key}) : super(key: key);

  @override
  _AugmentedRealityState createState() => _AugmentedRealityState();
}

class _AugmentedRealityState extends State<AugmentedReality> {
  @override
  Widget build(BuildContext context) {
    return Augmented(
        image: 'https://freepngimg.com/static/img/cat/hair.png'
    );
  }
}


