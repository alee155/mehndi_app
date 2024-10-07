import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:mehndi_app/Screens/OnboardingScreen/bordingscreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const OnboardingScreen(),
        ),
      );
    });
  }

  Future<List<Map<String, dynamic>>> fetchCategories() async {
    final response = await http
        .get(Uri.parse('https://mehndi.thetechnologia.com/api/Category'));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      List<Map<String, dynamic>> categories = [];

      for (var category in data) {
        categories.add({
          'id': category['id'],
          'name': category['name'],
          'imageUrl': category['imageUrl'],
        });
      }

      return categories;
    } else {
      throw Exception('Failed to load categories');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil in the build method
    ScreenUtil.init(context);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 238, 162, 70),
                  Colors.brown,
                  Colors.lime
                ],
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil().setHeight(70),
            left: ScreenUtil().setWidth(10),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Embrace",
                    style: TextStyle(
                      color: Colors.lime, // Set blue color for "Embrace"
                      fontSize: ScreenUtil().setSp(40),
                      fontFamily: 'Oswald-VariableFont_wght.ttf',
                    ),
                  ),
                  TextSpan(
                    text: " the Artistry,\nUnveil the ",
                    style: TextStyle(
                      color: const Color(0xFFFCEFDF),
                      fontSize: ScreenUtil().setSp(40),
                      fontFamily: 'Oswald-VariableFont_wght.ttf',
                    ),
                  ),
                  TextSpan(
                    text: "Beauty",
                    style: TextStyle(
                      color: Colors.lime, // Set blue color for "Beauty"
                      fontSize: ScreenUtil().setSp(40),
                      fontFamily: 'Oswald-VariableFont_wght.ttf',
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: ScreenUtil().setHeight(200),
            right: ScreenUtil().setWidth(10),
            child: Text(
              "Welcome to Mehndi App",
              style: TextStyle(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(16),
                fontFamily:
                    'KaushanScript-Regular.ttf', // Using ScreenUtil for font size
              ),
            ),
          ),
          Positioned(
            bottom: ScreenUtil().setHeight(0),
            left: 0,
            child: Container(
              width: ScreenUtil().setWidth(380),
              height: ScreenUtil().setHeight(450),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/spic.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: ScreenUtil().setHeight(80),
            right: ScreenUtil().setWidth(150),
            child: SizedBox(
              width: ScreenUtil().setWidth(80),
              height: ScreenUtil().setHeight(80),
              child: LoadingAnimationWidget.dotsTriangle(
                color: Colors.lime,
                size: 55,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
