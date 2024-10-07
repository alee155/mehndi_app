import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliderWidget extends StatelessWidget {
  SliderWidget({
    super.key,
    required this.pageController,
  });

  final PageController pageController;
  final List<String> sliderImages = [
    'assets/images/slider1.jpeg',
    'assets/images/slider2.jpeg',
    'assets/images/slider3.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150.h,
      width: 350.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: PageView.builder(
          controller: pageController,
          itemCount: sliderImages.length,
          itemBuilder: (context, index) {
            return Image.asset(
              sliderImages[index],
              fit: BoxFit.cover,
            );
          },
          onPageChanged: (index) {
            // Handle page change if needed
          },
        ),
      ),
    );
  }
}
