import 'package:flutter/material.dart';
import 'package:mehndi_app/Screens/Catagories/Fingers/fingers.dart';
import 'package:mehndi_app/Screens/Catagories/Foot/foots.dart';
import 'package:mehndi_app/Screens/Catagories/Hands/hands.dart';
import 'package:mehndi_app/Screens/Catagories/Head/head.dart';
import 'package:mehndi_app/Screens/Catagories/Legs/legs.dart';
import 'package:mehndi_app/Screens/Catagories/Nails/nail.dart';

void navigateToScreen(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HandsScreen()),
      );
      break;
    case 1:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FingersScreen()),
      );
      break;
    case 2:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const FootsScreen()),
      );
      break;
    case 3:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HandsScreen()),
      );
      break;
    case 4:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HeadsScreen()),
      );
      break;
    case 5:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LegsScreen()),
      );
      break;
    case 6:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NailsScreen()),
      );
      break;
    case 7:
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NailsScreen()),
      );
      break;
    // Add cases for other indices here if you have more screens to navigate
    default:
      // Handle default case if necessary
      break;
  }
}
