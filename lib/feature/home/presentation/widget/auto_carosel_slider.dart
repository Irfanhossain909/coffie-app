import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class AutoCarouselSlider extends StatefulWidget {
  final List<String> imageList;

  const AutoCarouselSlider({super.key, required this.imageList});

  @override
  State<AutoCarouselSlider> createState() => _AutoCarouselSliderState();
}

class _AutoCarouselSliderState extends State<AutoCarouselSlider> {
  late PageController _pageController;
  int _currentIndex = 0;
  Timer? _timer;

  final int _initialPage = 1000;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _initialPage);
    _currentIndex = _initialPage;
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      _currentIndex++;

      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );

      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  /// 🔥 Glossy Shimmer using shimmer_animation
  Widget _buildGlossShimmer() {
    return Shimmer(
      duration: const Duration(seconds: 2),
      interval: const Duration(milliseconds: 300),
      color: Colors.white,
      colorOpacity: 0.35,
      enabled: true,
      direction: const ShimmerDirection.fromLTRB(),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.grey.shade100,
              Colors.grey.shade200,
              Colors.grey.shade100,
            ],
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
    );
  }
  // Widget _buildGlossShimmer() {
  //   return Shimmer(
  //     duration: const Duration(seconds: 2),
  //     interval: const Duration(milliseconds: 300),
  //     color: Colors.white.withOpacity(0.15),
  //     colorOpacity: 0.3,
  //     enabled: true,
  //     direction: const ShimmerDirection.fromLTRB(),
  //     child: Container(
  //       width: double.infinity,
  //       height: double.infinity,
  //       decoration: BoxDecoration(
  //         color: Colors.grey.shade900, // dark base
  //         borderRadius: BorderRadius.circular(12.r),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          /// 🖼 Infinite Cached Slider
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (context, index) {
                final realIndex = index % widget.imageList.length;

                return CachedNetworkImage(
                  imageUrl: widget.imageList[realIndex],
                  fit: BoxFit.cover,
                  width: double.infinity,

                  /// ✨ Gloss Loading
                  placeholder: (context, url) => _buildGlossShimmer(),

                  /// ❌ Error fallback
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey.shade900,
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey.shade500,
                        size: 40.sp,
                      ),
                    ),
                  ),
                );
              },
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
          ),

          /// 🔵 Dot Indicator
          Positioned(
            bottom: 10.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(widget.imageList.length, (index) {
                  final realIndex = _currentIndex % widget.imageList.length;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    width: realIndex == index ? 14.w : 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: realIndex == index
                          ? AppColors.blue
                          : AppColors.black,
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
