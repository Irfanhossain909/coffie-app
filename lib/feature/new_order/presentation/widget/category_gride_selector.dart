import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CategoryGridSelector extends StatelessWidget {
  final String title;
  final List<String> items;
  /// Parallel to [items]; selection state uses these ids.
  final List<String> itemIds;
  final RxString selectedItemId;
  final ValueChanged<String> onTap;

  const CategoryGridSelector({
    super.key,
    required this.title,
    required this.items,
    required this.itemIds,
    required this.selectedItemId,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 🔹 Title
        AppText(
          data: title,
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
        ),

        SizedBox(height: 8.h),

        /// 🔹 Grid
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.w,
            mainAxisSpacing: 10.h,
            childAspectRatio: 3.5,
          ),
          itemBuilder: (context, index) {
            final label = items[index];
            final id = itemIds[index];

            return Obx(() {
              final bool isSelected = selectedItemId.value == id;

              return GestureDetector(
                onTap: () => onTap(id),
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                    vertical: 6.h,
                    horizontal: 12.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isSelected
                          ? Colors.transparent
                          : AppColors.yellow,
                    ),
                    color: isSelected
                        ? AppColors.blue
                        : Colors.transparent,
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: isSelected
                          ? Colors.white
                          : AppColors.black,
                    ),
                  ),
                ),
              );
            });
          },
        ),
      ],
    );
  }
}