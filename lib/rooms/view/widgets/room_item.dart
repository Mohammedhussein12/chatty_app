import 'package:chatty_app/chat/view/screens/chat_screen.dart';
import 'package:chatty_app/rooms/data/models/room_model.dart';
import 'package:chatty_app/shared/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_model/rooms_view_model.dart';

class RoomItem extends StatelessWidget {
  const RoomItem({super.key, required this.room});

  final RoomModel room;

  @override
  Widget build(BuildContext context) {
    final titleSmallTextTheme = Theme.of(context).textTheme.titleSmall;
    final categoryImageName = BlocProvider.of<RoomsViewModel>(context)
        .getCategoryImageName(room.categoryId);

    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(ChatScreen.routeName);
      },
      child: Material(
        borderRadius: BorderRadius.circular(16.0.r),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        elevation: 7,
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/$categoryImageName.png', height: 85.h),
              SizedBox(
                height: 10.h,
              ),
              Text(
                textAlign: TextAlign.center,
                room.name,
                style:
                    titleSmallTextTheme?.copyWith(fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 10.h,
              ),
              Text(
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                room.description,
                style: titleSmallTextTheme?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                    color: AppTheme.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
