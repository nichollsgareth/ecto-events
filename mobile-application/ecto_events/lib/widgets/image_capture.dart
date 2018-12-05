import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:camera/camera.dart';

List<CameraDescription> _cameras;

class ImageCapture extends StatefulWidget {

  ImageCapture(List<CameraDescription> cameras) {
    _cameras = cameras;
  }

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<ImageCapture> with AutomaticKeepAliveClientMixin {
  CameraController controller;

  @override
  void initState() {
    super.initState();
    controller = CameraController(_cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return AspectRatio(
        aspectRatio:
        controller.value.aspectRatio,
        child: CameraPreview(controller));
  }

  @override
  bool get wantKeepAlive => true;
}