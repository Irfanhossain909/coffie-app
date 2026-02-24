import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategorySelector extends StatelessWidget {
  final List<String> items;
  final RxString selectedItem;
  final Function(String) onTap;

  const CategorySelector({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Wrap(
        spacing: 16.w,
        runSpacing: 10.h,
        children: items.map((item) {
          final bool isSelected = selectedItem.value == item;

          return GestureDetector(
            onTap: () => onTap(item),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: isSelected ? Colors.transparent : AppColors.yellow,
                ),
                color: isSelected ? AppColors.blue : Colors.transparent,
              ),
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
              child: Text(
                item,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: isSelected ? Colors.white : AppColors.black,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
