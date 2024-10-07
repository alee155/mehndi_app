// import 'dart:async';
// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:http/http.dart' as http;
// import 'package:mehndi/model/shimmar.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({
//     super.key,
//   });

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
  
//   final List<String> sliderimagePaths = [
//     'assets/images/slider1.jpeg',
//     'assets/images/slider2.jpeg',
//     'assets/images/slider3.jpg',
//   ];

//   final PageController _pageController = PageController();

//   int _currentPage = 0;
//   Future<List<Map<String, dynamic>>> fetchCategories() async {
//     final response = await http
//         .get(Uri.parse('https://mehndi.thetechnologia.com/api/Category'));
//     if (response.statusCode == 200) {
//       List<dynamic> data = jsonDecode(response.body);
//       List<Map<String, dynamic>> categories = [];

//       for (var category in data) {
//         categories.add({
//           'id': category['id'],
//           'name': category['name'],
//           'imageUrl': category['imageUrl'],
//         });
//       }

//       return categories;
//     } else {
//       throw Exception('Failed to load categories');
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     // Start the timer to change pages automatically
//     startTimer();
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFFCEFDF),
//       body: SingleChildScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         child: Padding(
//           padding: EdgeInsets.only(top: 40.h),
//           child: Column(
//             children: [
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(left: 30),
//                     child: Row(
//                       children: [
//                         const CircleAvatar(
//                           radius: 20,
//                           backgroundColor: Colors.white,
//                           backgroundImage:
//                               AssetImage('assets/images/person.png'),
//                         ),
//                         const SizedBox(width: 50),
//                         Text(
//                           'HomeScreen',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontSize: 19.sp,
//                               fontFamily: 'Lora-VariableFont_wght.ttf',
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 33, top: 10),
//                     child: Text(
//                       'Welcome Dear !! How Are You Doing?',
//                       style: TextStyle(
//                         color: const Color(0xFF74380e),
//                         fontFamily: 'Lora-VariableFont_wght.ttf',
//                         fontSize: 13.sp,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 10),
//               ClipRRect(
//                 borderRadius:
//                     BorderRadius.circular(20), // Adjust the radius as needed
//                 child: SizedBox(
//                   height: 170.h,
//                   width: 330.w,
//                   child: PageView.builder(
//                     controller: _pageController,
//                     itemCount: sliderimagePaths.length,
//                     itemBuilder: (context, index) {
//                       return Image.asset(
//                         sliderimagePaths[index],
//                         fit: BoxFit.cover,
//                       );
//                     },
//                     onPageChanged: (index) {
//                       setState(() {
//                         _currentPage = index;
//                       });
//                     },
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 10),
//               Text(
//                 'Collections',
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 19.sp,
//                     fontFamily: 'Lora-VariableFont_wght.ttf',
//                     fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               FutureBuilder<List<Map<String, dynamic>>>(
//                 future: fetchCategories(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const ShimmerGridView();
//                   } else if (snapshot.hasError) {
//                     return Center(child: Text('Error: ${snapshot.error}'));
//                   } else {
//                     return GridView.builder(
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         crossAxisSpacing: 10.0,
//                         mainAxisSpacing: 10.0,
//                         childAspectRatio: 1.0,
//                       ),
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (context, index) {
//                         return GestureDetector(
//                           onTap: () {
//                             print("<<<<<<<<<<<<<Navigate");
//                             String categoryName = snapshot.data![index]['name'];
//                             // Add your navigation logic here
//                           },
//                           child: _buildContainer(
//                             "https://mehndi.thetechnologia.com/${snapshot.data![index]['imageUrl']}",
//                             snapshot.data![index]['name'],
//                           ),
//                         );
//                       },
//                     );
//                   }
//                 },
//               ),
//               SizedBox(
//                   height: MediaQuery.of(context)
//                       .padding
//                       .bottom), // Add bottom padding to handle device's bottom padding
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildContainer(String imagePath, String text) {
//     return Column(
//       children: [
//         Container(
//           height: 65.h,
//           width: 100.w,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.5),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//                 offset: const Offset(0, 3),
//               ),
//             ],
//             border: Border.all(
//               color: const Color(0xFF74380e),
//               width: 2, // Set border width
//             ),
//             image: DecorationImage(
//               image: AssetImage(imagePath),
//               fit: BoxFit.cover,
//             ),
//           ),
//         ),
//         Text(
//           text,
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 14.sp,
//             fontFamily: 'Lora-VariableFont_wght.ttf',
//             color: const Color(0xFF74380e),
//           ),
//         ), // Add text below the image
//       ],
//     );
//   }
// }
