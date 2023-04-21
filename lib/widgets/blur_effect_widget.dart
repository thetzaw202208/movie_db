import 'package:flutter/material.dart';

import '../constant/colors.dart';

class BottomBlurEffect extends StatelessWidget {
  const BottomBlurEffect({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            stops: const [
              0.0,
              0.6
            ],
            colors: [
              kPrimaryColor.withOpacity(1.0),
              kPrimaryColor.withOpacity(0.0)
            ]),
      ),
    );
  }
}
