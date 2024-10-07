import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart'; // Import Flutter Downloader
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mehndi_app/Screens/SplashScreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FlutterDownloader.initialize(
      debug: true); // Initialize Flutter Downloader
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      // Use builder only if you need to use library outside ScreenUtilInit context
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: const SplashScreen(),
    );
  }
}
