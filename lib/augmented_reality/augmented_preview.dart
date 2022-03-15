
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A widget showing a live camera preview.
class StartAugmentedReality extends StatelessWidget {
  /// Creates a preview widget for the given camera controller.
  const StartAugmentedReality(this.controller, {this.child});

  /// The controller for the camera that the preview is shown for.
  final CameraController controller;

  /// A widget to overlay on top of the camera preview
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return controller.value.isInitialized
        ? AspectRatio(
      aspectRatio: _isLandscape()
          ? controller.value.aspectRatio
          : (1 / controller.value.aspectRatio),
      child: Stack(
        fit: StackFit.expand,
        children: [
          _wrapInRotatedBox(child: controller.buildPreview()),
          child ?? Container(),
        ],
      ),
    )
        : Container();
  }

  Widget _wrapInRotatedBox({required Widget child}) {
    if (defaultTargetPlatform != TargetPlatform.android) {
      return child;
    }

    return RotatedBox(
      quarterTurns: _getQuarterTurns(),
      child: child,
    );
  }

  bool _isLandscape() {
    return [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]
        .contains(_getApplicableOrientation());
  }

  int _getQuarterTurns() {
    Map<DeviceOrientation, int> turns = {
      DeviceOrientation.portraitUp: 0,
      DeviceOrientation.landscapeLeft: 1,
      DeviceOrientation.portraitDown: 2,
      DeviceOrientation.landscapeRight: 3,
    };
    return turns[_getApplicableOrientation()]!;
  }

  DeviceOrientation _getApplicableOrientation() {
    return controller.value.isRecordingVideo
        ? controller.value.recordingOrientation!
        : (controller.value.lockedCaptureOrientation ??
        controller.value.deviceOrientation);
  }
}


class ArWidget extends StatelessWidget {
  ArWidget(this.controller);
  final controller;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        width: double.infinity,
        height: 1000,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10)
        ),
        child:
        StartAugmentedReality(controller),
      ),


    ]);
  }
}