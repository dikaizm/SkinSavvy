import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:skinsavvy/core/config.dart';
import 'package:skinsavvy/core/themes/theme.dart';
import 'package:skinsavvy/presentation/pages/analyze_skin/models/analyze_skin_model.dart';
import 'package:skinsavvy/presentation/pages/skincare_rec/models/skincare_rec_model.dart';
import 'package:skinsavvy/presentation/pages/skincare_rec/skincare_rec_page.dart';
import 'package:skinsavvy/presentation/widgets/button_gradient.dart';

class AnalyzeSkinResultPage extends StatefulWidget {
  final String imagePath;
  final PredictionData data;

  const AnalyzeSkinResultPage(
      {super.key, required this.imagePath, required this.data});

  @override
  State<AnalyzeSkinResultPage> createState() => _AnalyzeSkinResultPageState();
}

class _AnalyzeSkinResultPageState extends State<AnalyzeSkinResultPage> {

  void _getSkincare(context, List<PredictionSummary> data) async {
    try {
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
                    'Finding your best skincare...',
                    textAlign: TextAlign.center,
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

      String concatReq = '';
      for (var prediction in data) {
        concatReq += '${prediction.name}, ';
      }

      Map<String, dynamic> req = {
        'question': concatReq,
        'gender': 'female',
        'age': 19,
        'outdoor_activity': 'yes',
      };

      Response response = await post(
        Uri.parse('${AppConfig.serverAddress}/post/recommendation'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(req),
      );

      if (response.statusCode == 200) {
        final SkincareRecResponse productRec = SkincareRecResponse.fromJson(jsonDecode(response.body));

        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SkincareRecPage(
              // products: productRec.response.products,
              products: productRec.response.products,
            ),
          ),
        );

        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to get skincare recommendation'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );

        Navigator.pop(context);
      }
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to get skincare recommendation'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 60,
          title: const Text('Skin Analysis Result'),
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontFamily: 'Poppins',
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
        ),
        // The image is stored as a file on the device. Use the `Image.file`
        // constructor with the given path to display the image.
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 220,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      image: DecorationImage(
                        image: FileImage(File(widget.imagePath)),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        shadowColor:
                            MaterialStateProperty.all(Colors.transparent),
                        backgroundColor: MaterialStateProperty.all(
                            Colors.white.withOpacity(0.9)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(99),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Row(
                        children: [
                          Icon(
                            Icons.camera_alt_outlined,
                            size: 20,
                            color: Colors.black,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Retake',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        bottomSheet: BottomSheet(
          onClosing: () {},
          dragHandleColor: Colors.grey,
          builder: (context) {
            return DraggableScrollableSheet(
              snap: true,
              initialChildSize:
                  0.6, // You can adjust the initial size as needed
              minChildSize: 0.6, // You can adjust the minimum size as needed
              maxChildSize: 1, // You can adjust the maximum size as needed
              expand: false,
              builder: (context, scrollController) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                            color: AppTheme.secondaryColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(16)),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                  child: Text(
                                'Hi, ${(widget.data.summary.isNotEmpty) ? 'this is your skin condition!' : 'your skin is healthy!'}',
                                style: const TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              )),
                              Padding(
                                padding: const EdgeInsets.only(right: 16),
                                child: Image.asset(
                                  'assets/images/onboard_face.png',
                                  height: 50,
                                ),
                              )
                            ]),
                      ),
                      const SizedBox(height: 16),
                      if (widget.data.summary.isNotEmpty)
                        const Text(
                          'Skin Conditions',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      const SizedBox(height: 16),
                      Expanded(
                        child: ListView(
                          controller: scrollController,
                          children: _displaySkinResults(widget.data.summary),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        bottomNavigationBar: BottomAppBar(
          height: 100,
          elevation: 0.0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.white,
          color: Colors.white,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: ButtonGradient(
                  verticalPadding: 8,
                  horizontalPadding: 8,
                  label: 'Get Skincare',
                  onPressed: () => _getSkincare(context, widget.data.summary))),
        ));
  }
}

List<Container> _displaySkinResults(List<PredictionSummary> data) {
  List<Container> resultRows = [];

  for (var item in data) {
    Container row = Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '${item.percentage}%',
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryColor),
          ),
          const SizedBox(width: 24),
          Text(
            item.name,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    resultRows.add(row);
  }

  return resultRows;
}
