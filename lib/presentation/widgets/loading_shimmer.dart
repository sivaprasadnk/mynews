import 'package:flutter/material.dart';
import 'package:my_news/core/utils/common_colors.dart';
import 'package:shimmer/shimmer.dart';

class LoadingShimmer extends StatelessWidget {
  const LoadingShimmer({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: kGreyColor.withOpacity(0.5),
      highlightColor: kGreyColor,
      child: child,
    );
  }

  factory LoadingShimmer.rectangle({
    required double height,
    required double width,
    required BuildContext context,
  }) {
    return LoadingShimmer(
      child: Container(
        height: height,
        width: width,
        color: kGreyColor,
      ),
    );
  }
}
