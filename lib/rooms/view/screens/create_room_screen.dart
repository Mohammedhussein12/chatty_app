import 'package:chatty_app/auth/view/widgets/default_elevated_button.dart';
import 'package:chatty_app/auth/view/widgets/default_text_form_field.dart';
import 'package:chatty_app/rooms/view_model/rooms_state.dart';
import 'package:chatty_app/rooms/view_model/rooms_view_model.dart';
import 'package:chatty_app/shared/ui_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/app_theme.dart';
import '../../data/models/room_model.dart';
import '../widgets/categories_drop_down_button.dart';

class CreateRoomScreen extends StatefulWidget {
  static const String routeName = '/CreateRoomScreen';

  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final roomNameController = TextEditingController();
  final roomDescriptionController = TextEditingController();
  String? selectedCategoryId;
  var formKey = GlobalKey<FormState>();
  final roomsViewModel = RoomsViewModel();

  @override
  void dispose() {
    roomNameController.dispose();
    roomDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titleMediumTextThem = Theme.of(context).textTheme.titleMedium;
    return BlocProvider(
      create: (context) => roomsViewModel,
      child: Scaffold(
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
                padding: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
                child: Material(
                  borderRadius: BorderRadius.circular(16.0.r),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 12,
                  child: Container(
                    color: AppTheme.white,
                    padding:
                        EdgeInsets.only(left: 16.w, right: 16.h, top: 36.h),
                    margin: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Create New Room',
                            style: titleMediumTextThem,
                          ),
                          SizedBox(height: 25.h),
                          Image.asset(
                            'assets/images/room_details.png',
                            height: 80.h,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(height: 45.h),
                          DefaultTextFormField(
                            controller: roomNameController,
                            hintText: 'Enter Room Name',
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.length < 3) {
                                return 'Room Name cannot be less than 3 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 24.h),
                          CategoriesDropDownButton(
                            onCategorySelected: (categoryId) =>
                                selectedCategoryId = categoryId,
                          ),
                          SizedBox(height: 24.h),
                          DefaultTextFormField(
                            maxLines: 2,
                            controller: roomDescriptionController,
                            hintText: 'Enter Room Description',
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value == null ||
                                  value.trim().isEmpty ||
                                  value.length < 10) {
                                return 'Description cannot be less than 10 characters';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: 40.h),
                          BlocListener<RoomsViewModel, RoomsStates>(
                            listener: (context, state) {
                              if (state is CreateRoomLoading) {
                                UiUtils.showLoading(context);
                              } else if (state is CreateRoomError) {
                                UiUtils.hideLoading(context);
                                UiUtils.showMessage(state.error, AppTheme.red);
                              } else if (state is CreateRoomSuccess) {
                                UiUtils.hideLoading(context);
                                UiUtils.showMessage('Room created successfully',
                                    AppTheme.primary);
                                Navigator.pop(context);
                              }
                            },
                            child: DefaultElevatedButton(
                              width: MediaQuery.sizeOf(context).width * 0.85,
                              borderRadiusValue: 25.r,
                              onPressed: createRoom,
                              label: 'Create',
                            ),
                          ),
                          SizedBox(height: 28.h),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void createRoom() {
    if (formKey.currentState?.validate() == true) {
      final room = RoomModel(
        name: roomNameController.text,
        description: roomDescriptionController.text,
        categoryId: selectedCategoryId!,
      );
      roomsViewModel.createRoom(room);
    }
  }
}
