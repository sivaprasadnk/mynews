import 'package:flutter/material.dart';
import 'package:my_news/core/utils/common_colors.dart';

class TextfieldContainer extends StatelessWidget {
  const TextfieldContainer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: child,
    );
  }
}
