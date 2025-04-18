import 'package:flutter/material.dart';

class FriendProfilePict extends StatelessWidget {
  final String assetImage;

  const FriendProfilePict(
    this.assetImage, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: Colors.white, width: 2), // adjust the width as needed
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 20,
        backgroundImage: AssetImage(assetImage),
      ),
    );
  }
}
