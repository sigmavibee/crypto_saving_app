import 'package:flutter/material.dart';

import '../../../styles/colors.dart';
import '../../../styles/text_style.dart';

class TransactionList extends StatelessWidget {
  final Color bgColor;
  final String icon;
  final String title;
  final String sub;
  final String amount;

  const TransactionList({
    super.key,
    required this.bgColor,
    required this.icon,
    required this.title,
    required this.sub,
    required this.amount,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          SizedBox(
            height: 30,
            width: 30,
            child: CircleAvatar(
              backgroundColor: bgColor,
              child: Image(
                image: AssetImage(icon),
                width: 14,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: kBody1.copyWith(color: kLuckyBlue),
              ),
              Text(
                sub,
                style: kCaption.copyWith(
                  color: kLightGray,
                ),
              )
            ],
          ),
          Spacer(),
          Text(
            amount,
            style: kBody1.copyWith(
              color: kLuckyBlue,
            ),
          )
        ],
      ),
    );
  }
}
