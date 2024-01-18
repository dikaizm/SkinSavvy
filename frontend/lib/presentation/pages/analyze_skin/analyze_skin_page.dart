// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart';
import 'package:skinsavvy/core/config.dart';
import 'package:skinsavvy/core/themes/theme.dart';
import 'package:skinsavvy/main.dart';
import 'package:skinsavvy/presentation/pages/analyze_skin/analyze_result_page.dart';
import 'package:skinsavvy/presentation/pages/analyze_skin/models/analyze_skin_model.dart';

// A screen that allows users to take a picture using a given camera.
class AnalyzeSkinPage extends StatefulWidget {
  const AnalyzeSkinPage({
    super.key,
    required this.cameras,
  });

  final List<CameraDescription> cameras;

  @override
  AnalyzeSkinPageState createState() => AnalyzeSkinPageState();
}

class AnalyzeSkinPageState extends State<AnalyzeSkinPage> {
  late CameraController _controller;
  late Future<void>? _initializeControllerFuture;

  CameraDescription? _selectedCamera = cameras[1];

  @override
  void initState() {
    super.initState();
    // To display the current output from the Camera,
    // create a CameraController.
    _controller = CameraController(
      // Get a specific camera from the list of available cameras.
      _selectedCamera ?? widget.cameras[0],
      // Define the resolution to use.
      ResolutionPreset.ultraHigh,
    );

    // Next, initialize the controller. This returns a Future.
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed.
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 60,
        title: const Text('Take a selfie'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontFamily: 'Poppins',
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        automaticallyImplyLeading: false,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),
      // You must wait until the controller is initialized before displaying the
      // camera preview. Use a FutureBuilder to display a loading spinner until the
      // controller has finished initializing.
      body: GestureDetector(
        onTapDown: (details) {
          // Get the tap coordinates
          final double x =
              details.globalPosition.dx / MediaQuery.of(context).size.width;
          final double y =
              details.globalPosition.dy / MediaQuery.of(context).size.height;

          // Set the focus point based on the tap location
          _controller.setFocusPoint(Offset(x, y));
        },
        child: FutureBuilder<void>(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              final size = MediaQuery.of(context).size;

              return SizedBox(
                  width: size.width,
                  height: size.height,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: 100,
                      child: CameraPreview(_controller),
                    ),
                  ));
            } else {
              // Otherwise, display a loading indicator.
              return const Center(
                  child: CircularProgressIndicator(
                color: AppTheme.primaryColor,
              ));
            }
          },
        ),
      ),

      bottomSheet: BottomSheet(
        builder: (BuildContext context) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 12),
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 50,
                ),
                FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999.0),
                  ),
                  // Provide an onPressed callback.
                  onPressed: _captureAndSend,
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: SvgPicture.asset(
                      'assets/icons/cam_shutter.svg',
                    ),
                  ),
                ),
                FloatingActionButton(
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(999.0),
                  ),
                  onPressed: () {
                    setState(() {
                      _selectedCamera = _selectedCamera == cameras[0]
                          ? cameras[1]
                          : cameras[0];
                    });
                    initState();
                  },
                  child: Icon(
                    Icons.flip_camera_android,
                    size: 50,
                    color: Colors.blueGrey[900],
                  ),
                )
              ],
            ),
          );
        },
        onClosing: () {},
      ),
    );
  }

  Future<void> _captureAndSend() async {
    // Take the Picture in a try / catch block. If anything goes wrong,
    // catch the error.
    try {
      // Ensure that the camera is initialized.
      await _initializeControllerFuture;

      // Check if exposure compensation is supported
      if (_controller.value.exposurePointSupported) {
        _controller.setExposureMode(ExposureMode.auto);

        // Set exposure compensation value (in exposure stops, 0 is neutral)
        _controller.setExposureOffset(1.0); // Adjust this value as needed
      }
      // Check if flash is supported
      if (_controller.value.flashMode == FlashMode.off) {
        _controller.setFlashMode(FlashMode.auto);
      } else {
        _controller.setFlashMode(FlashMode.off);
      }

      // Attempt to take a picture and get the file `image`
      // where it was saved.
      final image = await _controller.takePicture();

      if (!mounted) return;

      showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Analyzing skin...',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 16),
                  CircularProgressIndicator(
                    color: AppTheme.primaryColor,
                  ),
                ],
              ),
            );
          });

      // Convert image to bytes
      List<int> imageBytes = await File(image.path).readAsBytes();

      // Create multipart request
      var request = http.MultipartRequest(
          "POST", Uri.parse('${AppConfig.serverAddress}/post/predict'));

      // Add the image as a file in the request
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'image.jpg',
        contentType: MediaType(
            'image', 'jpeg'), // Adjust content type based on your image type
      ));

      // Send the request
      var response = await request.send();

      if (response.statusCode == 200) {
        print('Image successfully sent to the backend');

        final String jsonString = await response.stream.bytesToString();
        final Map<String, dynamic> jsonData = jsonDecode(jsonString);

        final DetectionResponse detectionResponse =
            DetectionResponse.fromJson(jsonData);

        if (detectionResponse.status != 200) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: detectionResponse.error.isNotEmpty
                  ? Text(detectionResponse.error)
                  : const Text('An error occurred. Please try again later.'),
            ),
          );
          Navigator.of(context).pop();
          return;
        }

        Navigator.of(context).pop();

        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => AnalyzeSkinResultPage(
              // Pass the automatically generated path to
              // the AnalyzeSkinResultPage widget.
              imagePath: image.path,
              data: detectionResponse.predictions,
            ),
          ),
        );
      } else {
        throw ('Failed to send image to the server. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // If an error occurs, log the error to the console.
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Something went wrong'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.of(context).pop();
    }
  }
}
