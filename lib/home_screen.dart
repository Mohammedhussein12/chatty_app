import 'package:chatty_app/rooms/view/screens/create_room_screen.dart';
import 'package:chatty_app/rooms/view/widgets/room_item.dart';
import 'package:chatty_app/shared/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: AppTheme.white,
        ),
        onPressed: () {
          Navigator.pushNamed(context, CreateRoomScreen.routeName);
        },
      ),
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Chat App',
        ),
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('assets/images/background_image.png'),
          ),
        ),
        child: Padding(
          padding:
              EdgeInsetsDirectional.only(start: 16.w, end: 16.w, top: 32.h),
          child: GridView.builder(
            itemCount: 8,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 32.h,
                crossAxisSpacing: 32.w,
                childAspectRatio: 0.75,
                crossAxisCount: 2),
            itemBuilder: (context, index) => const RoomItem(),
          ),
        ),
      ),
    );
  }
}
