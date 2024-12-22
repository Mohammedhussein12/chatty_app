import 'package:chatty_app/rooms/view/screens/create_room_screen.dart';
import 'package:chatty_app/rooms/view/widgets/room_item.dart';
import 'package:chatty_app/rooms/view_model/rooms_state.dart';
import 'package:chatty_app/rooms/view_model/rooms_view_model.dart';
import 'package:chatty_app/shared/app_theme.dart';
import 'package:chatty_app/shared/error_indicator.dart';
import 'package:chatty_app/shared/loading_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final roomsViewModel = RoomsViewModel();

  @override
  void initState() {
    roomsViewModel.getRooms();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => roomsViewModel,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(
            Icons.add,
            color: AppTheme.white,
          ),
          onPressed: () {
            Navigator.pushNamed(context, CreateRoomScreen.routeName).then((value) {
              roomsViewModel.getRooms();
            },);
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
            child: BlocBuilder<RoomsViewModel, RoomsStates>(
              builder: (context, state) {
                if (state is GetRoomsLoading) {
                  return const LoadingIndicator();
                } else if (state is GetRoomsError) {
                  return ErrorIndicator(
                    message: state.error,
                  );
                } else if (state is GetRoomsSuccess) {
                  return GridView.builder(
                    itemCount: roomsViewModel.rooms.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 32.h,
                        crossAxisSpacing: 32.w,
                        childAspectRatio: 0.75,
                        crossAxisCount: 2),
                    itemBuilder: (context, index) => RoomItem(
                      room: roomsViewModel.rooms[index],
                    ),
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
