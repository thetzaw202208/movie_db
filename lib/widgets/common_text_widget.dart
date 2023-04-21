import 'package:flutter/material.dart';

import '../constant/colors.dart';

class CommonTextWidget extends StatelessWidget {
  const CommonTextWidget({Key? key, required this.text, this.color})
      : super(key: key);
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(color: color ?? kDefaultTextColor),
    );
  }
}
