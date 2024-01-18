import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:skinsavvy/presentation/pages/routine/models/schedule_model.dart';

class CardPeriodSchedule extends StatefulWidget {
  final List<Product> products;
  final String iconPath;
  final String title;
  final Color color;
  final Color textColor;
  final Function()? onAdd;
  final Function()? onOption;

  const CardPeriodSchedule(
      {super.key,
      this.textColor = Colors.black,
      this.onAdd,
      this.onOption,
      required this.products,
      required this.title,
      required this.color,
      required this.iconPath});

  @override
  State<CardPeriodSchedule> createState() => _CardPeriodScheduleState();
}

class _CardPeriodScheduleState extends State<CardPeriodSchedule> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: widget.color,
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                  child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: widget.textColor),
              )),
              Image.asset(
                widget.iconPath,
                height: 48,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Column(
            children: [
              ..._productItem(widget.products),
              GestureDetector(
                onTap: () {
                  // call api to add product
                  widget.onAdd;
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white.withOpacity(0.5),
                  ),
                  child: Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white),
                        child: const Icon(
                          Icons.add,
                          size: 24,
                        ),
                      ),
                      const SizedBox(
                        width: 12,
                      ),
                      const Text(
                        'Add Product',
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  List<Container> _productItem(List<Product> products) {
    List<Container> productList = [];
    String rangeTime = '';
    String days = '';
    int startHour;
    int endHour;
    int startMinute;
    int endMinute;

    for (var item in products) {
      if (item.schedule.days.length == 7) {
        days = 'Everyday';
      } else {
        days = item.schedule.days.join(', ');
      }

      startHour = item.schedule.startTime.hour;
      endHour = item.schedule.endTime.hour;
      startMinute = item.schedule.startTime.minute;
      endMinute = item.schedule.endTime.minute;

      rangeTime =
          '${startHour < 10 ? '0$startHour' : startHour}:${startMinute < 10 ? '0$startMinute' : startMinute} - ${endHour < 10 ? '0$endHour' : endHour}:${endMinute < 10 ? '0$endMinute' : endMinute}';

      productList.add(Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        padding: const EdgeInsets.all(8),
        child: Row(
          children: [
            Image.asset(
              item.imagePath,
              width: 48,
              height: 48,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.brand,
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    days,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    rangeTime,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 12, color: Colors.black),
                  )
                ],
              ),
            ),
            const SizedBox(
              width: 2,
            ),
            GestureDetector(
              onTap: () {
                // call api to view product option
                widget.onOption;
              },
              child: SvgPicture.asset(
                'assets/icons/ui_option.svg',
                height: 24,
              ),
            )
          ],
        ),
      ));
    }

    return productList;
  }
}
