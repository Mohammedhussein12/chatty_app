import 'package:chatty_app/shared/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoomItem extends StatelessWidget {
  const RoomItem({super.key});

  @override
  Widget build(BuildContext context) {
    final titleSmallTextTheme = Theme.of(context).textTheme.titleSmall;

    return Material(
      borderRadius: BorderRadius.circular(16.0.r),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      elevation: 7,
      child: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/movies.png', height: 85.h),
            SizedBox(
              height: 10.h,
            ),
            Text(
              textAlign: TextAlign.center,
              'The Movies Zone',
              style: titleSmallTextTheme?.copyWith(fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 10.h,
            ),
            Text(
              '13 Members',
              style: titleSmallTextTheme?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 12.sp,
                  color: AppTheme.grey),
            ),
          ],
        ),
      ),
    );
  }
}
