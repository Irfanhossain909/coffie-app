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
  Timer? _timer;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _startAutoScroll();
  }

  // 🔥 Auto Scroll Logic (Safe)
  void _startAutoScroll() {
    _timer?.cancel(); // prevent multiple timers

    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!mounted || !_pageController.hasClients) return;

      final nextPage = (_pageController.page ?? 0).toInt() + 1;

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  // 🔥 VERY IMPORTANT (Get.to() fix)
  @override
  void deactivate() {
    _timer?.cancel(); // stop when leaving screen
    super.deactivate();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  // ✨ Gloss Shimmer
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

  @override
  Widget build(BuildContext context) {
    if (widget.imageList.isEmpty) {
      return const SizedBox();
    }

    return SizedBox(
      height: 230.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          /// 🖼 Infinite Slider
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                final realIndex = index % widget.imageList.length;

                return CachedNetworkImage(
                  imageUrl: widget.imageList[realIndex],
                  fit: BoxFit.cover,
                  width: double.infinity,

                  /// ✨ Loading
                  placeholder: (context, url) => _buildGlossShimmer(),

                  /// ❌ Error
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey.shade300,
                    child: Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        color: Colors.grey.shade600,
                        size: 40.sp,
                      ),
                    ),
                  ),
                );
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
                children: List.generate(widget.imageList.length, (dotIndex) {
                  final realIndex = _currentIndex % widget.imageList.length;

                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: EdgeInsets.symmetric(horizontal: 3.w),
                    width: realIndex == dotIndex ? 14.w : 8.w,
                    height: 8.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: realIndex == dotIndex
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

