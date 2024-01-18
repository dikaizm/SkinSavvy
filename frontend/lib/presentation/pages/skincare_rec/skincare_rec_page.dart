import 'package:flutter/material.dart';
import 'package:skinsavvy/core/routes.dart';
import 'package:skinsavvy/presentation/pages/skincare_rec/models/skincare_rec_model.dart';
import 'package:skinsavvy/presentation/widgets/app_bar.dart';
import 'package:skinsavvy/presentation/widgets/button.dart';
import 'package:skinsavvy/services/shared_service.dart';

class SkincareRecPage extends StatelessWidget {
  final List<ProductDetail> products;

  const SkincareRecPage({super.key, required this.products});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(context, 'Skincare Recommendation', 18, true, false),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          children: [
            ..._displayProducts(products),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Button(
              label: 'Add to Routine',
              onPressed: () {
                SharedService.saveData('saved_product', products);
                Navigator.pushNamed(context, AppRoutes.home);
              }),
        ));
  }

  List<Container> _displayProducts(List<ProductDetail> products) {
    List<Container> productContainers = [];

    for (var prod in products) {
      Container container = Container(
        padding: const EdgeInsets.all(8),
        width: double.infinity,
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          border: Border.all(
            color: Colors.grey.withOpacity(0.5),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  alignment: Alignment.center,
                  image: NetworkImage(prod.img),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Container(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      prod.brand,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      prod.name,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      prod.price,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

      productContainers.add(container);
    }

    return productContainers;
  }
}
