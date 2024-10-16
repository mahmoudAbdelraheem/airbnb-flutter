import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  const Category({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(top: 10),
      margin: const EdgeInsetsDirectional.only(end: 15),
      // decoration: BoxDecoration(
      // border: index == 0
      //     ? const Border(
      //         bottom: BorderSide(
      //           color: Colors.black,
      //           width: 2,
      //         ),
      //       )
      //     : null),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 30,
          ),
          Text('Location'),
        ],
      ),
    );
  }
}
