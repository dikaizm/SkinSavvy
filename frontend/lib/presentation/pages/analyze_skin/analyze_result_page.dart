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

      var response = await post(
        Uri.parse('${AppConfig.serverAddress}/post/recommendation'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(req),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonData = jsonDecode(response.body);

        final SkincareRecResponse productRec =
            SkincareRecResponse.fromJson(jsonData);

        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SkincareRecPage(
              products: productRec.response,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to get skincare recommendation'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } on Exception {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to get skincare recommendation'),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
        ),
      );
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
                              const Expanded(
                                  child: Text(
                                'Hi Nadya, this is your skin condition!',
                                style: TextStyle(
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
            '${item.percentage.toStringAsFixed(2)}%',
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
