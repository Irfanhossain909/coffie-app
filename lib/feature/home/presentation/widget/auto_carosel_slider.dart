import 'dart:async';
import 'package:coffie/core/const/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  /// 🔥 Very large number for infinite effect
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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 230.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          /// 🖼 Infinite Image Slider
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: PageView.builder(
              controller: _pageController,
              itemBuilder: (context, index) {
                final realIndex =
                    index % widget.imageList.length; // 🔥 magic line

                return Image.network(
                  widget.imageList[realIndex],
                  fit: BoxFit.fill,
                  width: double.infinity,
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
