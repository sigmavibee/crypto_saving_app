import 'package:flutter/material.dart';

import '../styles/colors.dart';

class ProfilePicture extends StatelessWidget {
  const ProfilePicture({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(
        height: 100,
        width: 100,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
        image: DecorationImage(
          image: AssetImage('assets/images/profile.jpg'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: kGrey,
            blurRadius: 5,
            offset: Offset.fromDirection(2),
          ),
        ],
      ),
    );
  }
}
