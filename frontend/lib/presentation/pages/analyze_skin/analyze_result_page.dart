import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:skinsavvy/core/config.dart';
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
  void _getSkincare(context, List<Prediction> data) async {
    try {
      String concatReq = '';
      for (var prediction in data) {
        concatReq += '${prediction.label}, ';
      }

      Map<String, dynamic> req = {
        'question': concatReq,
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
        print(response.statusCode);
      }
    } on Exception catch (e) {
      print(e);
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
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Container(
                  height: 340,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: DecorationImage(
                      image: FileImage(File(widget.imagePath)),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Table(
                  columnWidths: const {
                    0: FlexColumnWidth(1),
                    1: FlexColumnWidth(1),
                    2: FlexColumnWidth(1),
                  },
                  children: [
                    const TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Skin Problems',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Confidence Level',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Status',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ..._displaySkinResults(widget.data.predictions),
                  ],
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          elevation: 0.0,
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.white,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ButtonGradient(
                  label: 'Get Skincare',
                  onPressed: () =>
                      _getSkincare(context, widget.data.predictions))),
        ));
  }
}

List<TableRow> _displaySkinResults(List<Prediction> predictions) {
  List<TableRow> resultRows = [];

  for (var prediction in predictions) {
    TableRow row = TableRow(
      children: [
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              prediction.label,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              prediction.confidenceLevel.toString(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        TableCell(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              prediction.status.toString(), // Assuming 'status' is of type int
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );

    resultRows.add(row);
  }

  return resultRows;
}
