import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileRowCard extends StatelessWidget {
  final String? title;
  final String? icon;
  final VoidCallback? onTap;
  const ProfileRowCard({super.key, this.title, this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 18.r),
      child: InkWell(
        hoverColor: Colors.transparent,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Row(
          children: [
            SvgPicture.asset(
              icon!,
              width: 24.w,
              height: 24.h,
              color: AppColors.black.withValues(alpha: 0.9),
            ),
            SizedBox(width: 15.w),
            AppText(
              data: title!,

              style: GoogleFonts.outfit(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Icon(Icons.arrow_forward_ios_rounded, size: 18.w),
          ],
        ),
      ),
    );
  }
}
