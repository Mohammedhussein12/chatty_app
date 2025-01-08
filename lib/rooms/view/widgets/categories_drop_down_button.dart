import 'package:chatty_app/rooms/data/models/category_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/app_theme.dart';

class CategoriesDropDownButton extends StatefulWidget {
  const CategoriesDropDownButton({
    super.key,
    required this.onCategorySelected,
  });

  final void Function(String?) onCategorySelected;

  @override
  State<CategoriesDropDownButton> createState() =>
      _CategoriesDropDownButtonState();
}

class _CategoriesDropDownButtonState extends State<CategoriesDropDownButton> {
  String? selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    final titleMediumTextTheme = Theme.of(context).textTheme.titleMedium;
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
        decoration: const InputDecoration(
          border: UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.primary),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.black),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.primary),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: AppTheme.red),
          ),
        ),
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null) {
            return 'Please select a category';
          }
          return null;
        },
        isExpanded: true,
        hint: Text(
          'Select Room Category',
          style: titleMediumTextTheme?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 16.sp,
            color: AppTheme.grey.withOpacity(0.9),
          ),
        ),
        value: selectedCategoryId,
        items: CategoryModel.categories
            .map((category) => DropdownMenuItem(
                value: category.id,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/${category.imageName}.png',
                      height: 30.h,
                    ),
                     SizedBox(width: 15.w,),
                    Text(category.name,
                        style: titleMediumTextTheme?.copyWith(
                          fontWeight: FontWeight.w400,
                          fontSize: 16.sp,
                          color: AppTheme.grey.withOpacity(0.9),
                        )),
                  ],
                )))
            .toList(),
        onChanged: (categoryId) {
          selectedCategoryId = categoryId;
          widget.onCategorySelected(selectedCategoryId);
          setState(() {});
        },
      ),
    );
  }
}
