import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoryGridSelector extends StatelessWidget {
  final List<String> items;
  final RxString selectedItem;
  final ValueChanged<String> onTap;

  const CategoryGridSelector({
    super.key,
    required this.items,
    required this.selectedItem,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: items.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // 👈 per row 2 item
        crossAxisSpacing: 12.w,
        mainAxisSpacing: 10.h,
        childAspectRatio: 3.5, // 👈 height control (adjust if needed)
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return Obx(() {
          final bool isSelected = selectedItem.value == item;
          return GestureDetector(
            onTap: () => onTap(item),
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: isSelected ? Colors.transparent : AppColors.yellow,
                ),
                color: isSelected ? AppColors.blue : Colors.transparent,
              ),
              padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 12.w),
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
        });
      },
    );
  }
}
