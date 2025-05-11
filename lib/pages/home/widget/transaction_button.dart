import 'package:flutter/material.dart';

import '../../../styles/colors.dart';
import '../../../styles/text_style.dart';

class TransactionButton extends StatelessWidget {
  final String icon;
  final String text;

  const TransactionButton({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        constraints: BoxConstraints.expand(
          height: 60,
        ),
        decoration: BoxDecoration(
          color: kNightBlack,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              icon,
              width: 24,
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              text,
              style: kBody1.copyWith(
                color: kWhite,
              ),
            )
          ],
        ),
      ),
    );
  }
}
