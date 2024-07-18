import 'package:flutter/material.dart';
import 'package:news_app/core/utils/common_colors.dart';

class CommonBtn extends StatelessWidget {
  const CommonBtn({
    super.key,
    required this.onTap,
    required this.isLoading,
    required this.title,
  });
  final VoidCallback onTap;
  final bool isLoading;
  final String title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
          color: kBlueColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: !isLoading
              ? Text(
                  // "Signup",
                  title,
                  style: TextStyle(
                    color: kWhiteColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                    color: kWhiteColor,
                  ),
                ),
        ),
      ),
    );
  }
}
