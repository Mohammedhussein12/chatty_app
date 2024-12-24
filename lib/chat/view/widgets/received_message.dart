import 'package:chatty_app/chat/data/models/message_model.dart';
import 'package:chatty_app/shared/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class ReceivedMessage extends StatelessWidget {
  const ReceivedMessage({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final titleSmallTextTheme = Theme.of(context).textTheme.titleSmall;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          message.senderName,
          style: titleSmallTextTheme?.copyWith(
              color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 12.sp),
        ),
        SizedBox(
          height: 4.h,
        ),
        Row(
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
                  message.content,
                  style: titleSmallTextTheme?.copyWith(
                      color: AppTheme.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 15.sp),
                ),
              ),
            ),
            SizedBox(
              width: 12.w,
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                DateFormat.jm().format(message.dateTime),
                style: titleSmallTextTheme?.copyWith(
                    color: AppTheme.black.withOpacity(0.8),
                    fontWeight: FontWeight.w400,
                    fontSize: 10.sp),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
