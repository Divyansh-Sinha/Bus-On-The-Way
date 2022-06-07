import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        border: Border.all(
          width: 4,
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        boxShadow: [
          BoxShadow(
            spreadRadius: 2,
            blurRadius: 2,
            color: Colors.black.withOpacity(0.5),
            offset: Offset(0, 7),
          ),
        ],
        shape: BoxShape.circle,
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('images/profile.jpg'),
        ),
      ),
    );
  }
}
