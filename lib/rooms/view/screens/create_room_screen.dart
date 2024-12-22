import 'package:chatty_app/auth/view/widgets/default_elevated_button.dart';
import 'package:chatty_app/auth/view/widgets/default_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/app_theme.dart';
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
  String? selectedCategory;
  var formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    roomNameController.dispose();
    roomDescriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final titleMediumTextThem = Theme.of(context).textTheme.titleMedium;
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
        child: Form(
          key: formKey,
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
                  child: Flexible(
                    child: Container(
                      color: AppTheme.white,
                      padding:
                          EdgeInsets.only(left: 16.w, right: 16.h, top: 36.h),
                      margin: EdgeInsetsDirectional.symmetric(horizontal: 16.w),
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
                            'assets/images/room.png',
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
                          CategoriesDropDownButton(onCategorySelected: (category) => selectedCategory= category ,),
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
                          DefaultElevatedButton(
                            width: MediaQuery.sizeOf(context).width * 0.85,
                            borderRadiusValue: 25.r,
                            onPressed: createRoom,
                            label: 'Create',
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
    if (formKey.currentState?.validate() == true) {}
  }
}
