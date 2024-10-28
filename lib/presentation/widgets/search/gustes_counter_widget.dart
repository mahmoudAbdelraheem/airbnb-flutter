import 'package:flutter/material.dart';

class GustesCounterWidget extends StatelessWidget {
  final String title;
  final String subTitle;
  final ValueNotifier<int> counterNotifier;

  const GustesCounterWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.counterNotifier,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      padding: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          color: Colors.grey.shade300,
        ),
      )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  height: 1.2,
                ),
              ),
              Text(
                subTitle,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: () {
                  if (counterNotifier.value == 0) return;
                  counterNotifier.value--;
                },
                child: Container(
                  width: 35,
                  height: 35,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.remove),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: ValueListenableBuilder<int>(
                  valueListenable: counterNotifier,
                  builder: (context, counter, child) {
                    return Text(
                      '$counter',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    );
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  counterNotifier.value++;
                },
                child: Container(
                  width: 35,
                  height: 35,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.shade300,
                    ),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  alignment: Alignment.center,
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
