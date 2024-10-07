import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mehndi_app/model/SliderWidget.dart';

import 'Offlinenavigation.dart'; // Import the navigation.dart file

class OfflineHomeScreen extends StatefulWidget {
  const OfflineHomeScreen({
    super.key,
  });

  @override
  State<OfflineHomeScreen> createState() => _OfflineHomeScreenState();
}

class _OfflineHomeScreenState extends State<OfflineHomeScreen> {
  final List<String> imagePaths = [
    'assets/images/arm.jpeg',
    'assets/images/finger.jpeg',
    'assets/images/foot.jpeg',
    'assets/images/hand.jpeg',
    'assets/images/legs.jpeg',
    'assets/images/nails.jpg',
  ];

  final List<String> imageTexts = [
    'Arms',
    'Fingers',
    'Foots',
    'Hands',
    'Legs',
    'Nails',
  ];

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startSlider();
    });
  }

  void _startSlider() {
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < sliderImages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  final List<String> sliderImages = [
    'assets/images/slider1.jpeg',
    'assets/images/slider2.jpeg',
    'assets/images/slider3.jpg',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'HomeScreen',
          style: TextStyle(
              color: Colors.black,
              fontSize: 19.sp,
              fontFamily: 'Lora-VariableFont_wght.ttf',
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFCEFDF),
      ),
      backgroundColor: const Color(0xFFFCEFDF),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Container(
                    width: 340,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                          10), // Adjust the radius as needed
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              AssetImage('assets/images/person.png'),
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'Welcome Dear !! How Are You Doing?',
                          style: TextStyle(
                            color: const Color(0xFF74380e),
                            fontFamily: 'Lora-VariableFont_wght.ttf',
                            fontSize: 13.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SliderWidget(pageController: _pageController),
            ),
            const SizedBox(height: 10),
            Text(
              'Collections',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 19.sp,
                  fontFamily: 'Lora-VariableFont_wght.ttf',
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: List.generate(
                imagePaths.length,
                (index) => GestureDetector(
                  onTap: () {
                    navigateToScreen(
                        context, index); // Use the navigation function
                  },
                  child: _buildContainer(imagePaths[index], imageTexts[index]),
                ),
              ),
            ),
            SizedBox(
                height: MediaQuery.of(context)
                    .padding
                    .bottom), // Add bottom padding to handle device's bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildContainer(String imagePath, String text) {
    return Column(
      children: [
        Container(
          height: 65.h,
          width: 100.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
            border: Border.all(
              color: const Color(0xFF74380e),
              width: 2, // Set border width
            ),
            image: DecorationImage(
              image: AssetImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
            fontFamily: 'Lora-VariableFont_wght.ttf',
            color: const Color(0xFF74380e),
          ),
        ), // Add text below the image
      ],
    );
  }
}
