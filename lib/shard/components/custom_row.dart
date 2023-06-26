

import 'package:flutter/material.dart';

import '../../resources/app_colors.dart';
import '../../resources/styles.dart';

class CustomRow extends StatelessWidget {
  final String text;
  final String image;
  final VoidCallback function;
  final Color imageColor;
  final Color textColor;

  const CustomRow({
    super.key,
    required this.text,
    required this.image,
    required this.function,
    this.imageColor = AppColors.kBorderColor,
    this.textColor = AppColors.kTitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Row(
          children: [
            ImageIcon(
              AssetImage(image),
              color: imageColor,
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              text,
              style: Styles.textStyle14.copyWith(
                fontSize: 15,
                color: textColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
