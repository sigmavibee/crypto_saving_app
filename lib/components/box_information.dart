import 'package:crypto_saving_app/styles/colors.dart';
import 'package:flutter/material.dart';

class BoxInformation extends StatelessWidget {
  final int height;

  BoxInformation({
    Key? key,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: height.toDouble(), // Set the height of the container
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white, // Background color for the box
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: kGrey,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }
}

class CustomBoxInfo extends StatelessWidget {
  final int height;
  final int width;

  CustomBoxInfo({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.toDouble(),
      width: width.toDouble(), // Set the height of the container
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white, // Background color for the box
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: kGrey,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
    );
  }
}
