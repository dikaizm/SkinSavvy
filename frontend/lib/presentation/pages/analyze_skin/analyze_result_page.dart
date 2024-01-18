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

final List<Map<String, dynamic>> productData = [
  {
    "brand": "Drunk Elephant",
    "name": "Ceramighty™  AF Eye Cream with Ceramides",
    "Price": "\$60.00",
    "url":
        "https://www.sephora.com/ceramighty-af-eye-cream-with-ceramides-P501028",
    "img":
        "https://www.sephora.com/productimages/sku/s2593820-main-zoom.jpg?imwidth=480",
    "quantity": "Size: 0.5 oz / 15 mL",
    "Explanation":
        "This eye cream contains a potent blend of vitamin C, ferulic acid, and niacinamide, which work together to brighten dark circles and reduce the appearance of fine lines and wrinkles. It also contains caffeine, which helps to reduce puffiness and inflammation."
  },
  {
    "brand": "Sunday Riley",
    "name": "Auto Correct Brightening + Depuffing Eye Cream for Dark Circles",
    "Price": "\$65.00",
    "url":
        "https://www.sephora.com/auto-correct-brightening-depuffing-eye-contour-cream-P424948",
    "img":
        "https://www.sephora.com/productimages/sku/s2020634-main-zoom.jpg?imwidth=480",
    "quantity": "Size: 0.5 oz/ 15 mL",
    "Explanation":
        "This eye cream contains a cocktail of antioxidants, including vitamin C, green tea extract, and pomegranate extract, which help to protect the delicate skin around the eyes from damage caused by free radicals. It also contains hyaluronic acid, which helps to hydrate and plump the skin, reducing the appearance of dark circles."
  },
  {
    "brand": "Kiehl's Since 1851",
    "name": "Mini Creamy Eye Treatment with Avocado",
    "Price": "\$37.00",
    "url":
        "https://www.sephora.com/creamy-eye-treatment-with-avocado-mini-P435805",
    "img":
        "https://www.sephora.com/productimages/sku/s1988815-main-zoom.jpg?imwidth=480",
    "quantity": "Size: 0.5 oz/ 14 g",
    "Explanation":
        "This eye cream is formulated with avocado oil, which is rich in vitamins A, D, and E. These vitamins help to nourish and protect the skin, while also reducing the appearance of dark circles and fine lines. It also contains shea butter, which helps to hydrate and soften the skin."
  },
  {
    "brand": "La Mer",
    "name": "The Eye Concentrate Cream",
    "Price": "\$270.00",
    "url": "https://www.sephora.com/la-mer-the-eye-concentrate-P455924",
    "img":
        "https://www.sephora.com/productimages/sku/s2341600-main-zoom.jpg?imwidth=480",
    "quantity": "Size: 0.5 oz/ 15 mL",
    "Explanation":
        "This eye cream contains a proprietary blend of sea kelp and other marine botanicals, which help to reduce the appearance of dark circles and fine lines. It also contains hyaluronic acid, which helps to hydrate and plump the skin."
  },
  {
    "brand": "Skinfix",
    "name": "barrier+ Triple Lipid + Collagen Brightening Eye Treatment ",
    "Price": "\$54.00",
    "url": "https://www.sephora.com/skinfix-triple-lipid-eye-lift-P505049",
    "img":
        "https://www.sephora.com/productimages/sku/s2639904-main-zoom.jpg?imwidth=480",
    "quantity": "Size: 0.5 oz / 15 mL",
    "Explanation":
        "This eye gel contains a powerful combination of antioxidants, including vitamin C, vitamin E, and ferulic acid, which help to protect the delicate skin around the eyes from damage caused by free radicals. It also contains hyaluronic acid, which helps to hydrate and plump the skin, reducing the appearance of dark circles."
  },
  {
    "brand": "Peter Thomas Roth",
    "name": "Potent-C™ Vitamin C Power Eye Cream",
    "Price": "\$68.00",
    "url": "https://www.sephora.com/potent-c-tm-power-eye-cream-P433456",
    "img":
        "https://www.sephora.com/productimages/sku/s2058154-main-zoom.jpg?imwidth=480",
    "quantity": "Size: 0.5 oz/ 15 mL",
    "Explanation":
        "This spot brightener is formulated with a high concentration of vitamin C, which helps to lighten dark circles and hyperpigmentation. It also contains niacinamide, which helps to improve the skin's overall tone and texture."
  }
];

class AnalyzeSkinResultPage extends StatefulWidget {
  final String imagePath;
  final PredictionData data;

  const AnalyzeSkinResultPage(
      {super.key, required this.imagePath, required this.data});

  @override
  State<AnalyzeSkinResultPage> createState() => _AnalyzeSkinResultPageState();
}

class _AnalyzeSkinResultPageState extends State<AnalyzeSkinResultPage> {
  final String userName = 'Nadya';

  void _getSkincare(context, List<PredictionSummary> data) async {
    try {
      await showDialog(
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

      // List<ProductDetail> products = productData.map((product) {
      //   return ProductDetail.fromJson(product);
      // }).toList();

      if (response.statusCode == 200) {
        final SkincareRecResponse productRec =
            SkincareRecResponse.fromJson(jsonDecode(response.body));

        print(productRec.response);

        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => SkincareRecPage(
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
    } on Exception catch (e) {
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
                              Expanded(
                                  child: Text(
                                'Hi $userName, ${(widget.data.summary.isNotEmpty) ? 'this is your skin condition!' : 'your skin is healthy!'}',
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
