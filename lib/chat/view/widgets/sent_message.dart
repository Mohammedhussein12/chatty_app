import 'package:chatty_app/chat/data/models/message_model.dart';
import 'package:chatty_app/shared/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class SentMessage extends StatelessWidget {
  const SentMessage({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final titleSmallTextTheme = Theme.of(context).textTheme.titleSmall;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Align(
          alignment: Alignment.bottomRight,
          child: Text(
            DateFormat.jm().format(message.dateTime),
            style: titleSmallTextTheme?.copyWith(
                color: AppTheme.black,
                fontWeight: FontWeight.w400,
                fontSize: 10.sp),
          ),
        ),
        SizedBox(
          width: 12.w,
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(12.sp),
            decoration: const BoxDecoration(
              color: AppTheme.primary,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
            child: Text(
              message.content,
              style: titleSmallTextTheme?.copyWith(
                  color: AppTheme.white,
                  fontWeight: FontWeight.w400,
                  fontSize: 15.sp),
            ),
          ),
        ),
      ],
    );
  }
}
