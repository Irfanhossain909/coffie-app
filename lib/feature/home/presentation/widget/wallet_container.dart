import 'dart:async';
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_assets.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletContainer extends StatefulWidget {
  final double amount;

  const WalletContainer({super.key, required this.amount});

  @override
  State<WalletContainer> createState() => _WalletContainerState();
}

class _WalletContainerState extends State<WalletContainer> {
  bool isExpanded = false;

  void _handleTap() {
    setState(() {
      isExpanded = true;
    });

    /// Auto return after 2 seconds
    Timer(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isExpanded = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: isExpanded ? 100.w : 100.w,
        height: 28.h,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.yellow),
          borderRadius: BorderRadius.circular(18.r),
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.3, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            );
          },
          child: isExpanded
              ? Row(
                  key: const ValueKey("amount"),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText(
                      data: "\$${widget.amount.toStringAsFixed(2)}",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: 6.w),
                    SvgPicture.asset(
                      AppAssets.wallet,
                      width: 18.w,
                      height: 18.h,
                    ),
                  ],
                )
              : Row(
                  key: const ValueKey("wallet"),
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AppAssets.wallet,
                      width: 18.w,
                      height: 18.h,
                    ),
                    SizedBox(width: 8.w),
                    AppText(
                      data: "Wallet",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
