import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupportBaristaWidget extends StatefulWidget {
  final List<int> defaultValues;
  final double totalAmount;

  /// API / external value (optional initial amount)
  final double? initialAmount;

  final Function(int percent, double finalAmount)? onApply;

  const SupportBaristaWidget({
    super.key,
    required this.defaultValues,
    required this.totalAmount,
    this.initialAmount,
    this.onApply,
  });

  @override
  State<SupportBaristaWidget> createState() => _SupportBaristaWidgetState();
}

class _SupportBaristaWidgetState extends State<SupportBaristaWidget> {
  late List<int> values;

  int? selectedValue;
  final TextEditingController controller = TextEditingController();

  bool isProgrammaticUpdate = false;

  @override
  void initState() {
    super.initState();

    values = List.from(widget.defaultValues);

    /// set initial value or 0.0
    controller.text = (widget.initialAmount ?? 0.0).toStringAsFixed(2);
  }

  @override
  void didUpdateWidget(covariant SupportBaristaWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.initialAmount != oldWidget.initialAmount) {
      isProgrammaticUpdate = true;

      controller.text = (widget.initialAmount ?? 0.0).toStringAsFixed(2);

      isProgrammaticUpdate = false;
    }
  }

  /// percentage select → just helper fill (NOT final)
  void onSelectValue(int value) {
    setState(() {
      selectedValue = value;
    });

    double calculatedAmount = (widget.totalAmount * value) / 100;

    /// fill but user can still edit
    isProgrammaticUpdate = true;
    controller.text = calculatedAmount.toStringAsFixed(2);
    isProgrammaticUpdate = false;
  }

  void onApply() {
    double? amount = double.tryParse(controller.text);

    if (amount == null) return;

    /// percent derived from final amount
    int percent = ((amount / widget.totalAmount) * 100).round();

    widget.onApply?.call(percent, amount);
  }

  Widget buildItem(int value) {
    final isSelected = selectedValue == value;

    return GestureDetector(
      onTap: () => onSelectValue(value),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.yellow : Colors.transparent,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: isSelected ? Colors.white : AppColors.yellow,
          ),
        ),
        child: Center(
          child: AppText(
            data: "$value%",
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: isSelected ? Colors.white : AppColors.black,
          ),
        ),
      ),
    );
  }

  Widget horizontalList() {
    return SizedBox(
      height: 32.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: values.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (_, index) => buildItem(values[index]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.yellow),
      ),
      width: double.infinity,
      child: Column(
        children: [
          /// HEADER
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppText(
                data: "Support the Baristas",
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
              InkWell(
                onTap: onApply,
                child: Text(
                  "Apply",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.yellow,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          /// PERCENT SELECT (helper only)
          horizontalList(),

          SizedBox(height: 12.h),

          /// USER EDITABLE INPUT (FINAL VALUE)
          AppInputWidgetTwo(
            controller: controller,
            borderColor: AppColors.yellow,
            hintText: "Enter amount",
            keyboardType: TextInputType.number,
          ),
        ],
      ),
    );
  }
}
