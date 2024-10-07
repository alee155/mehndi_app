import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import 'package:mehndi_app/Screens/SelectionScreen/selectionscreen.dart';
import 'package:page_transition/page_transition.dart';


class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  @override
  // ignore: override_on_non_overriding_member
  final pages = [
    //White Page
    Container(
      color: const Color(0xFFa76b2f),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 60),
                  child: Text(
                    "Welcome to Mehndi",
                    style: TextStyle(
                      fontSize: 24,
                      fontFamily: 'Lora-VariableFont_wght.ttf',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Center(
                child: Image.asset(
                  "assets/images/boarding2two.png",
                  height: 300,
                  width: 300, // Set the width as desired
                ),
              ),
              const Column(
                children: [
                  Center(
                    child: Text(
                      "Embark on a journey ",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Lora-VariableFont_wght.ttf',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "into the captivating world",
                      style: TextStyle(
                        fontFamily: 'Lora-VariableFont_wght.ttf',
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "of intricate Mehndi designs",
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Lora-VariableFont_wght.ttf',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Text(
                      'Experience the beauty and tradition ',
                      style: TextStyle(
                        fontFamily: 'Sora-VariableFont_wght.ttf',
                        fontSize: 15,
                        color: Color.fromARGB(255, 253, 250, 218),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'of Mehndi right at your fingertips.',
                      style: TextStyle(
                        fontFamily: 'Sora-VariableFont_wght.ttf',
                        fontSize: 15,
                        color: Color.fromARGB(255, 253, 250, 218),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          const Positioned(
            top: 30.0,
            right: 10.0,
            child: SkipButton(),
          ),
        ],
      ),
    ),

    Container(
      color: const Color(0xFF694332),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Text(
                    "Discover Stunning Designs",
                    style: TextStyle(
                      fontSize: 21,
                      fontFamily: 'Lora-VariableFont_wght.ttf',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Center(
                child: Image.asset(
                  "assets/images/bordingone1.png",
                  height: 300,
                  width: 300, // Set the width as desired
                ),
              ),
              const Column(
                children: [
                  Center(
                    child: Text(
                      "Browse through a vast",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Lora-VariableFont_wght.ttf',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "collection of traditional and",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Lora-VariableFont_wght.ttf',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "contemporary Mehndi designs.",
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Lora-VariableFont_wght.ttf',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Text(
                      'Explore different styles and techniques',
                      style: TextStyle(
                        fontSize: 15,
                        fontFamily: 'Sora-VariableFont_wght.ttf',
                        color: Color.fromARGB(255, 253, 250, 218),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'to find the perfect Mehndi design for you.',
                      style: TextStyle(
                        fontFamily: 'Sora-VariableFont_wght.ttf',
                        fontSize: 15,
                        color: Color.fromARGB(255, 253, 250, 218),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          const Positioned(
            top: 30.0,
            right: 10.0,
            child: SkipButton(),
          ),
        ],
      ),
    ),

    //Orange Page
    Container(
      color: const Color(0xFF2e0f0c),
      child: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: Text(
                    "Start Your Mehndi Journey",
                    style: TextStyle(
                      fontFamily: 'Sora-VariableFont_wght.ttf',
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Center(
                child: Image.asset(
                  "assets/images/bording3three.png",
                  height: 300,
                  width: 300, // Set the width as desired
                ),
              ),
              const Column(
                children: [
                  Center(
                    child: Text(
                      "Begin your Mehndi ",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Sora-VariableFont_wght.ttf',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      "adventure today",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: 'Sora-VariableFont_wght.ttf',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Text(
                    "and unleash your creativity",
                    style: TextStyle(
                      fontSize: 22,
                      fontFamily: 'Sora-VariableFont_wght.ttf',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Text(
                      'Join our community of Mehndi enthusiasts and share ',
                      style: TextStyle(
                        fontFamily: 'Sora-VariableFont_wght.ttf',
                        fontSize: 14,
                        color: Color.fromARGB(255, 253, 250, 218),
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      'your passion for beautiful designs',
                      style: TextStyle(
                        fontFamily: 'Sora-VariableFont_wght.ttf',
                        fontSize: 14,
                        color: Color.fromARGB(255, 253, 250, 218),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Center(child: GoToHomeButton()),
                ],
              )
            ],
          ),
          const Positioned(
            top: 30.0,
            right: 10.0,
            child: SkipButton(),
          ),
        ],
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
        pages: pages,
        fullTransitionValue: 300,
        // slideIconWidget: Lottie.asset(
        //   'assets/images/animated_leftarrow.json',
        //   width: 64,
        // ),
        positionSlideIcon: 0.5,
        enableLoop: false,
        waveType: WaveType.liquidReveal,
        onPageChangeCallback: (int page) {
          // Check if the last page is reached
          if (page == pages.length - 1) {
            // Show the "Get Started" button
            // You can customize this part according to your UI
            // For example, you might want to display a button at the bottom of the screen
            // or add a delay before showing the button to guide the user.
          }
        },
      ),
    );
  }
}

//Class for Go To Home Button
class GoToHomeButton extends StatelessWidget {
  const GoToHomeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () async {
          Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: const SelectionScreen(),
            ),
          );
        },
        child: Container(
          height: 40,
          width: 150,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 2), // changes position of shadow
              ),
            ],
            border: Border.all(
              color: Colors.black,
              width: 2,
            ),
          ),
          child: const Center(
            child: Text(
              'Start',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 22,
                color: Colors.black,
              ),
            ),
          ),
        ));
  }
}

// Class for Skip Button
class SkipButton extends StatelessWidget {
  const SkipButton({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SelectionScreen()));
      },
      child: const Text(
        'Skip',
        style: TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 253, 250, 218),
        ),
      ),
    );
  }
}
