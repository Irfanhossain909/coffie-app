
import 'package:coffie/core/component/app_text/app_text.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class Branding extends StatelessWidget {
  const Branding({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppText(
          data: 'COFFECITO',
    
          style: GoogleFonts.questrial(
            fontSize: 65.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.blue,
          ),
        ),
        Text(
          "WELL - MADE",
          style: GoogleFonts.questrial(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.5,
            color: AppColors.blue,
          ),
        ),
        Text(
          "COFFEE FOR YOU",
          style: GoogleFonts.questrial(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 2.5,
            color: AppColors.blue,
          ),
        ),
      ],
    );
  }
}
