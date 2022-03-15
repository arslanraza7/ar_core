# ar_core Flutter Package for Augmented Reality
[![pub package](https://img.shields.io/pub/v/camera.svg)](https://pub.dev/packages/ar_core)

ar_core is an augmented reality mobile application kit for mobile devices that enables the creation of augmented reality applications.

Many thanks to Arslan Raza for the [ar_core](https://github.com/arslanraza7/ar_core), he served as a great basis and starting point for this project.

## Features

* Display live camera preview in a widget.
* Custom Camera, Place anywhere on the Screen.
* Choose Asset, Network or 3d objects in png.
* Drag, Resize, Rotate, Zoom in and out objects.
* Add access to the image stream from Dart.

## Getting Started

### Installing


Add the Flutter package to your project by running:

```bash
flutter pub add ar_core
```

Or manually add this to your `pubspec.yaml` file (and run `flutter pub get`):

```yaml
dependencies:
  ar_core: ^0.0.1
```

### iOS

The camera plugin functionality works on iOS 10.0 or higher. If compiling for any version lower than 10.0,
make sure to programmatically check the version of iOS running on the device before using any camera plugin features.
The [device_info_plus](https://pub.dev/packages/device_info_plus) plugin, for example, can be used to check the iOS version.

Add two rows to the `ios/Runner/Info.plist`:

* one with the key `Privacy - Camera Usage Description` and a usage description.
* and one with the key `Privacy - Microphone Usage Description` and a usage description.

Or in text format add the key:

```xml
<key>NSCameraUsageDescription</key>
<string>Can I use the camera please?</string>
<key>NSMicrophoneUsageDescription</key>
<string>Can I use the mic please?</string>
```

### Android

Change the minimum Android sdk version to 21 (or higher) in your `android/app/build.gradle` file.

```
minSdkVersion 21
```

It's important to note that the `MediaRecorder` class is not working properly on emulators, as stated in the documentation: https://developer.android.com/reference/android/media/MediaRecorder. Specifically, when recording a video with sound enabled and trying to play it back, the duration won't be correct and you will only see the first frame.


### Importing

Add this to your code:

```dart
import 'package:ar_core/ar_core.dart';
```


### Usage or How to Use

Replace your Scaffold to Augmented(), and it will handle all your view. if you want to pass an image just pass an image as a constructor.

#Write this code in main
```dart

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
```

```dart
class AugmentedReality extends StatefulWidget {
  const AugmentedReality({Key? key}) : super(key: key);

  @override
  _AugmentedRealityState createState() => _AugmentedRealityState();
}

class _AugmentedRealityState extends State<AugmentedReality> {
  @override
  Widget build(BuildContext context) {
    return Augmented(
     /// Provide Network Image Link to add your object
    image: 'https://freepngimg.com/static/img/cat/hair.png'
    );
  }
}
```
