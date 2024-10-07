import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:mehndi_app/Screens/SelectionScreen/Online/Onlinedisplayscreen.dart';
import 'package:mehndi_app/model/SliderWidget.dart';
import 'package:mehndi_app/model/shimmar.dart';

class OnlineHomeScreen extends StatefulWidget {
  const OnlineHomeScreen({super.key});

  @override
  State<OnlineHomeScreen> createState() => _OnlineHomeScreenState();
}

class _OnlineHomeScreenState extends State<OnlineHomeScreen>
    with AutomaticKeepAliveClientMixin<OnlineHomeScreen> {
  final List<String> sliderImages = [
    'assets/images/slider1.jpeg',
    'assets/images/slider2.jpeg',
    'assets/images/slider3.jpg',
  ];
  @override
  bool get wantKeepAlive => true;
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
    _timer.cancel(); // Dispose the timer to prevent memory leaks
    _pageController.dispose();
    super.dispose();
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

  Widget _buildContainer(String imagePath, String text) {
    return Column(
      children: [
        Container(
          height: 65,
          width: 100,
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
              width: 2,
            ),
            image: DecorationImage(
              image: NetworkImage(imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            fontFamily: 'Lora-VariableFont_wght.ttf',
            color: Color(0xFF74380e),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchCategories(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const ShimmerGridView();
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return NestedScrollView(
              headerSliverBuilder: (context, _) {
                return [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 340.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  10), // Adjust the radius as needed
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
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
                          const SizedBox(
                            height: 30,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child:
                                SliderWidget(pageController: _pageController),
                          ),
                          const SizedBox(height: 10),
                          Center(
                            child: Text(
                              'Collections',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19.sp,
                                  fontFamily: 'Lora-VariableFont_wght.ttf',
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ];
              },
              body: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          print("<<<<<<<<<<<<<Navigate");
                          String categoryName = snapshot.data![index]['name'];
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  OnlineDisplayScreen(categoryName),
                            ),
                          );
                        },
                        child: _buildContainer(
                          "https://mehndi.thetechnologia.com/${snapshot.data![index]['imageUrl']}",
                          snapshot.data![index]['name'],
                        ),
                      );
                    },
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
