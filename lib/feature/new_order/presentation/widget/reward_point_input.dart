import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/const/app_assets.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RewardPointWidget extends StatefulWidget {
  final int points;
  final int pointGiven;
  final int minimumPoint; // ✅ NEW
  final Function(int value) onApply;

  const RewardPointWidget({
    super.key,
    required this.points,
    required this.pointGiven,
    required this.onApply,
    this.minimumPoint = 1, // ✅ default 1$
  });

  @override
  State<RewardPointWidget> createState() => _RewardPointWidgetState();
}

class _RewardPointWidgetState extends State<RewardPointWidget> {
  late TextEditingController _controller;
  String? errorText;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.pointGiven.toString());
  }

  @override
  void didUpdateWidget(covariant RewardPointWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.pointGiven != widget.pointGiven) {
      _controller.text = widget.pointGiven.toString();
    }
  }

  void _apply() {
    final text = _controller.text.trim();
    final value = int.tryParse(text);

    if (value == null) {
      setState(() {
        errorText = "Enter valid number";
      });
      return;
    }

    /// ❌ Minimum validation
    if (value < widget.minimumPoint) {
      setState(() {
        errorText = "Minimum ${widget.minimumPoint}p = \$1.00 can redeem";
      });
      return;
    }

    /// ❌ Max validation
    if (value > widget.points) {
      setState(() {
        errorText = "You don't have enough points";
      });
      return;
    }

    setState(() {
      errorText = null;
    });

    widget.onApply(value);
  }

  @override
  Widget build(BuildContext context) {
    final inputValue = int.tryParse(_controller.text) ?? 0;
    final remainingPoints = widget.points - inputValue;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.yellow),
      ),
      width: double.infinity,
      child: Column(
        children: [
          /// Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Rewards & Loyalty",
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
              ),
              InkWell(
                onTap: _apply,
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

          /// Input Field
          AppInputWidgetTwo(
            borderColor: AppColors.yellow,
            controller: _controller,
            prefix: SvgPicture.asset(AppAssets.rewardBox),

            suffixIcon: Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: Text(
                "${remainingPoints}p",
                style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
              ),
            ),

            hintText: "Reward Point",
          ),

          /// Error Text
          if (errorText != null) ...[
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                errorText!,
                style: TextStyle(color: Colors.red, fontSize: 12.sp),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
