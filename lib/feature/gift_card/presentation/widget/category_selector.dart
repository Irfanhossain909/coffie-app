import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategorySelector extends StatelessWidget {
  final List<String> items;
  final RxString selectedItem;
  final Function(String) onTap;

  // ✅ NEW: display formatter
  final String Function(String)? labelBuilder;

  const CategorySelector({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onTap,
    this.labelBuilder, // ✅ optional
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: items.map((item) {
            final bool isSelected = selectedItem.value == item;

            return Padding(
              padding: EdgeInsets.only(right: 12.w),
              child: GestureDetector(
                onTap: () => onTap(item),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isSelected ? Colors.transparent : AppColors.yellow,
                    ),
                    color: isSelected ? AppColors.blue : Colors.transparent,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 6.h,
                    horizontal: 12.w,
                  ),
                  child: Text(
                    // ✅ এখানে formatting apply হবে
                    labelBuilder != null ? labelBuilder!(item) : item,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: isSelected ? Colors.white : AppColors.black,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
