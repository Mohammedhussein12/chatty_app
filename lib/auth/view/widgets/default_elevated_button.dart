import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../shared/app_theme.dart';

class DefaultElevatedButton extends StatelessWidget {
  const DefaultElevatedButton(
      {super.key,
      required this.onPressed,
      required this.label,
      this.width,
      this.borderRadiusValue = 6});

  final VoidCallback onPressed;
  final String label;
  final double borderRadiusValue;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadiusValue),
        ),
        fixedSize: Size(width ?? MediaQuery.sizeOf(context).width, 52),
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontSize: 18.sp,
              color: AppTheme.white,
            ),
      ),
    );
  }
}
