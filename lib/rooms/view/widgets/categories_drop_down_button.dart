import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/app_theme.dart';

class CategoriesDropDownButton extends StatefulWidget {
  const CategoriesDropDownButton({
    super.key, required this.onCategorySelected,
  });
  final void Function (String?) onCategorySelected;

  @override
  State<CategoriesDropDownButton> createState() =>
      _CategoriesDropDownButtonState();
}

class _CategoriesDropDownButtonState extends State<CategoriesDropDownButton> {
  String? selectedCategory;

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
        value: selectedCategory,
        items: ['Sports', 'Movies', 'Music']
            .map((category) => DropdownMenuItem(
                value: category,
                child: Text(category,
                    style: titleMediumTextTheme?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: AppTheme.grey.withOpacity(0.9),
                    ))))
            .toList(),
        onChanged: (category) {
          selectedCategory = category;
          widget.onCategorySelected(selectedCategory);
          setState(() {});
        },
      ),
    );
  }
}
