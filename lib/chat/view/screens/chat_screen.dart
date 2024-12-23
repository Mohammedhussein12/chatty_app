import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/app_theme.dart';
import '../widgets/sent_message.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = '/ChatScreen';

  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat App',
        ),
      ),
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/background_image.png'),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100.h),
            Padding(
              padding: EdgeInsetsDirectional.symmetric(horizontal: 12.w),
              child: Material(
                borderRadius: BorderRadius.circular(16.0.r),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 12,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  color: AppTheme.white,
                  padding: EdgeInsets.all(16.sp),
                  margin: EdgeInsetsDirectional.symmetric(horizontal: 0.w),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) => const SendMessage(),
                          itemCount: 2,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: TextField(
                              cursorColor: AppTheme.primary,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.only(left: 8),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(color: AppTheme.grey),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: AppTheme.grey),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: AppTheme.grey),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(8),
                                  ),
                                ),
                                hintText: 'Type a message',
                                hintStyle: TextStyle(
                                  color: AppTheme.grey,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 8.w,
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 12.h),
                              backgroundColor: AppTheme.primary,
                              foregroundColor: AppTheme.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () {},
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Send',
                                  style: TextStyle(
                                    color: AppTheme.white,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Icon(
                                  Icons.send,
                                  color: AppTheme.white,
                                  size: 22.sp,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
