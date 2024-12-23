import 'package:chatty_app/shared/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SendMessage extends StatelessWidget {
  const SendMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleSmallTextTheme = Theme.of(context).textTheme.titleSmall;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(12.sp),
            decoration: const BoxDecoration(
              color: AppTheme.lightGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: Text(
              'Lorem ipsum dolor sit amet,',
              style: titleSmallTextTheme?.copyWith(
                  color: AppTheme.grey, fontWeight: FontWeight.w400,fontSize: 15.sp),
            ),
          ),
        ),
         SizedBox(width: 12.w,),
         Align(alignment: Alignment.bottomRight,
           child: Text(
            '3:15 PM',
             style: titleSmallTextTheme?.copyWith(
                 color: AppTheme.black, fontWeight: FontWeight.w400,fontSize: 10.sp),
                   ),
         ),
      ],
    );
  }
}
