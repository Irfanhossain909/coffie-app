import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
import 'package:coffie/core/const/app_assets.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RewardPointWidget extends StatefulWidget {
  final int points;
  final int pointGiven;
  final Function(int value) onApply;

  const RewardPointWidget({
    super.key,
    required this.points,
    required this.pointGiven,
    required this.onApply,
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

  /// ✅ Sync when parent value changes
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

    if (value < 0 || value > widget.points) {
      setState(() {
        errorText = "Invalid reward point";
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

// import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
// import 'package:coffie/core/const/app_assets.dart';
// import 'package:coffie/core/const/app_color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class RewardPointWidget extends StatefulWidget {
//   final int points;
//   final int pointGiven; // ✅ NEW PARAM
//   final Function(int value) onApply;

//   const RewardPointWidget({
//     super.key,
//     required this.points,
//     required this.pointGiven,
//     required this.onApply,
//   });

//   @override
//   State<RewardPointWidget> createState() => _RewardPointWidgetState();
// }

// class _RewardPointWidgetState extends State<RewardPointWidget> {
//   late TextEditingController _controller;
//   String? errorText;

//   @override
//   void initState() {
//     super.initState();

//     // ✅ default value = pointGiven
//     _controller = TextEditingController(text: widget.pointGiven.toString());
//   }

//   void _apply() {
//     final text = _controller.text.trim();
//     final value = int.tryParse(text);

//     if (value == null) {
//       setState(() {
//         errorText = "Enter valid number";
//       });
//       return;
//     }

//     // remaining points check
//     if (value < 0 || value > widget.points) {
//       setState(() {
//         errorText = "Invalid reward point";
//       });
//       return;
//     }

//     setState(() {
//       errorText = null;
//     });

//     widget.onApply(value);
//   }

//   @override
//   Widget build(BuildContext context) {
//     final remainingPoints =
//         widget.points - (int.tryParse(_controller.text) ?? 0);

//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.r),
//         border: Border.all(color: AppColors.yellow),
//       ),
//       width: double.infinity,
//       child: Column(
//         children: [
//           /// Header
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Rewards & Loyalty",
//                 style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
//               ),

//               InkWell(
//                 onTap: _apply,
//                 child: Text(
//                   "Apply",
//                   style: TextStyle(
//                     fontSize: 14.sp,
//                     fontWeight: FontWeight.w600,
//                     color: AppColors.yellow,
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           SizedBox(height: 16.h),

//           /// Input Field
//           AppInputWidgetTwo(
//             borderColor: AppColors.yellow,
//             controller: _controller,
//             prefix: SvgPicture.asset(AppAssets.rewardBox),

//             suffixIcon: Padding(
//               padding: EdgeInsets.only(right: 8.w),
//               child: Text(
//                 "${remainingPoints}p", // ✅ dynamic remaining points
//                 style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
//               ),
//             ),

//             hintText: "Reward Point",
//           ),

//           /// Error Text
//           if (errorText != null) ...[
//             SizedBox(height: 8.h),
//             Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 errorText!,
//                 style: TextStyle(color: Colors.red, fontSize: 12.sp),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }

// // import 'package:coffie/core/component/app_input/app_input_widget_two.dart';
// // import 'package:coffie/core/const/app_assets.dart';
// // import 'package:coffie/core/const/app_color.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:flutter_svg/flutter_svg.dart';

// // class RewardPointWidget extends StatefulWidget {
// //   final int points;
// //   final Function(int value) onApply;

// //   const RewardPointWidget({
// //     super.key,
// //     required this.points,
// //     required this.onApply,
// //   });

// //   @override
// //   State<RewardPointWidget> createState() => _RewardPointWidgetState();
// // }

// // class _RewardPointWidgetState extends State<RewardPointWidget> {
// //   final TextEditingController _controller = TextEditingController();
// //   String? errorText;

// //   void _apply() {
// //     final text = _controller.text.trim();
// //     final value = int.tryParse(text);

// //     if (value == null) {
// //       setState(() {
// //         errorText = "Enter valid number";
// //       });
// //       return;
// //     }

// //     if (value < 1 || value > widget.points) {
// //       setState(() {
// //         errorText = "you don't have enough points";
// //       });
// //       return;
// //     }

// //     setState(() {
// //       errorText = null;
// //     });

// //     widget.onApply(value);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
// //       decoration: BoxDecoration(
// //         borderRadius: BorderRadius.circular(8.r),
// //         border: Border.all(color: AppColors.yellow),
// //       ),
// //       width: double.infinity,
// //       child: Column(
// //         children: [
// //           /// Header
// //           Row(
// //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //             children: [
// //               Text(
// //                 "Rewards & Loyalty",
// //                 style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
// //               ),

// //               /// Apply Button (replaces edit icon)
// //               InkWell(
// //                 onTap: _apply,
// //                 child: Text(
// //                   "Apply",
// //                   style: TextStyle(
// //                     fontSize: 14.sp,
// //                     fontWeight: FontWeight.w600,
// //                     color: AppColors.yellow,
// //                   ),
// //                 ),
// //               ),
// //             ],
// //           ),

// //           SizedBox(height: 16.h),

// //           /// Input Field (your AppInputWidgetTwo)
// //           AppInputWidgetTwo(
// //             borderColor: AppColors.yellow,
// //             controller: _controller,

// //             prefix: SvgPicture.asset(AppAssets.rewardBox),
// //             suffixIcon: Padding(
// //               padding: EdgeInsets.only(right: 8.w),
// //               child: Text(
// //                 "${widget.points}p",
// //                 style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500),
// //               ),
// //             ),
// //             hintText: "Reward Point",
// //           ),

// //           /// Error Text
// //           if (errorText != null) ...[
// //             SizedBox(height: 8.h),
// //             Align(
// //               alignment: Alignment.centerLeft,
// //               child: Text(
// //                 errorText!,
// //                 style: TextStyle(color: Colors.red, fontSize: 12.sp),
// //               ),
// //             ),
// //           ],
// //         ],
// //       ),
// //     );
// //   }
// // }
