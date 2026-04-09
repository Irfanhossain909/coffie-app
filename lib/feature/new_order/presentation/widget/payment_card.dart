import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_assets.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class PaymentCard extends StatefulWidget {
  final double walletAmount;
  final double giftCardAmount;
  final double totalPrice;

  final Function(String value)? onSelected;

  const PaymentCard({
    super.key,
    required this.walletAmount,
    required this.giftCardAmount,
    required this.totalPrice,
    this.onSelected,
  });

  @override
  State<PaymentCard> createState() => _PaymentCardState();
}

class _PaymentCardState extends State<PaymentCard> {
  String selectedType = "";

  /// 🔥 control snackbar spam
  bool _isShowingError = false;

  void _handleSelection(String type) {
    if (type == "wallet") {
      if (widget.walletAmount < widget.totalPrice) {
        _showError("Wallet balance is not enough");
        return;
      }
    }

    if (type == "gift_card") {
      if (widget.giftCardAmount < widget.totalPrice) {
        _showError("Gift card balance is not enough");
        return;
      }
    }

    setState(() {
      selectedType = type;
    });

    widget.onSelected?.call(type);
  }

  void _showError(String msg) {
    if (_isShowingError) return; // 🔥 prevent multiple show

    _isShowingError = true;

    final messenger = ScaffoldMessenger.of(context);

    /// remove previous snackbar
    messenger.clearSnackBars();

    messenger.showSnackBar(
      SnackBar(
        content: Text(msg),
        duration: const Duration(milliseconds: 1200), // 🔥 short time
      ),
    );

    /// reset flag after delay
    Future.delayed(const Duration(milliseconds: 1300), () {
      _isShowingError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.yellow),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            data: "Select Payment Method",
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(height: 12.h),

          /// Wallet
          _buildPaymentItem(
            type: "wallet",
            icon: AppAssets.wallet,
            title: "COFFECITO Wallet Balance",
            value: "-\$${widget.walletAmount}",
          ),

          SizedBox(height: 12.h),

          /// Gift Card
          _buildPaymentItem(
            type: "gift_card",
            icon: AppAssets.giftBox,
            title: "Digital Gift Card",
            value: "-\$${widget.giftCardAmount}",
          ),

          SizedBox(height: 12.h),

          /// Stripe
          _buildPaymentItem(
            type: "stripe",
            proceShow: false,
            icon: AppAssets.stripe,
            title: "Continue With Stripe",
            value: "",
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentItem({
    required String type,
    required String icon,
    required String title,
    required String value,
    bool proceShow = true,
  }) {
    final isSelected = selectedType == type;

    return GestureDetector(
      onTap: () => _handleSelection(type),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.yellow.withOpacity(.1) : Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          border: Border.all(
            color: AppColors.yellow,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(icon, width: 20.w, height: 20.h),
            SizedBox(width: 8.w),
            AppText(data: title, fontSize: 14.sp, fontWeight: FontWeight.w400),
            Spacer(),
            if (proceShow)
              AppText(
                data: value,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
          ],
        ),
      ),
    );
  }
}

// import 'package:coffie/core/component/app_text/app_text.dart';
// import 'package:coffie/core/const/app_assets.dart';
// import 'package:coffie/core/const/app_color.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';

// class PaymentCard extends StatefulWidget {
//   final double walletAmount;
//   final double giftCardAmount;
//   final double totalPrice;

//   final Function(String value)? onSelected;

//   const PaymentCard({
//     super.key,
//     required this.walletAmount,
//     required this.giftCardAmount,
//     required this.totalPrice,
//     this.onSelected,
//   });

//   @override
//   State<PaymentCard> createState() => _PaymentCardState();
// }

// class _PaymentCardState extends State<PaymentCard> {
//   String selectedType = "";

//   void _handleSelection(String type) {
//     if (type == "wallet") {
//       if (widget.walletAmount < widget.totalPrice) {
//         _showError("Wallet balance is not enough");
//         return;
//       }
//     }

//     if (type == "gift_card") {
//       if (widget.giftCardAmount < widget.totalPrice) {
//         _showError("Gift card balance is not enough");
//         return;
//       }
//     }

//     setState(() {
//       selectedType = type;
//     });

//     widget.onSelected?.call(type);
//   }

//   void _showError(String msg) {
//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.r),
//         border: Border.all(color: AppColors.yellow),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           AppText(
//             data: "Select Payment Method",
//             fontSize: 16.sp,
//             fontWeight: FontWeight.w600,
//           ),
//           SizedBox(height: 12.h),

//           /// Wallet
//           _buildPaymentItem(
//             type: "wallet",
//             icon: AppAssets.wallet,
//             title: "COFFECITO Wallet Balance",
//             value: "-\$${widget.walletAmount}",
//           ),

//           SizedBox(height: 12.h),

//           /// Gift Card
//           _buildPaymentItem(
//             type: "gift_card",
//             icon: AppAssets.giftBox,
//             title: "Digital Gift Card",
//             value: "-\$${widget.giftCardAmount}",
//           ),

//           SizedBox(height: 12.h),

//           /// Stripe
//           _buildPaymentItem(
//             type: "stripe",
//             proceShow: false,
//             icon: AppAssets.stripe,
//             title: "Continue With Stripe",
//             value: "",
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentItem({
//     required String type,
//     required String icon,
//     required String title,
//     required String value,
//     bool proceShow = true,
//   }) {
//     final isSelected = selectedType == type;

//     return GestureDetector(
//       onTap: () => _handleSelection(type),
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//         decoration: BoxDecoration(
//           color: isSelected ? AppColors.yellow.withOpacity(.1) : Colors.white,
//           borderRadius: BorderRadius.circular(8.r),
//           border: Border.all(
//             color: isSelected ? AppColors.yellow : AppColors.yellow,
//             width: isSelected ? 2 : 1,
//           ),
//         ),
//         child: Row(
//           children: [
//             SvgPicture.asset(icon, width: 20.w, height: 20.h),
//             SizedBox(width: 8.w),
//             AppText(data: title, fontSize: 14.sp, fontWeight: FontWeight.w400),
//             Spacer(),
//             if (proceShow)
//               AppText(
//                 data: value,
//                 fontSize: 14.sp,
//                 fontWeight: FontWeight.w400,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
