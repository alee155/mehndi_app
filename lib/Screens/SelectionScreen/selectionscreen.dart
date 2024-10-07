import 'package:flutter/material.dart';
import 'package:mehndi_app/Screens/SelectionScreen/Offline/Offlinewelcomescreen.dart';
import 'package:mehndi_app/Screens/SelectionScreen/Online/Onlinewelcomescreen.dart';
import 'package:mehndi_app/model/Rating/show_rating_dialog.dart';

class SelectionScreen extends StatefulWidget {
  const SelectionScreen({
    super.key,
  });

  @override
  State<SelectionScreen> createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        RatingDialogManager.showRatingDialog(context);
        return false;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color.fromARGB(255, 238, 162, 70),
                    Colors.brown,
                    Colors.lime,
                  ],
                ),
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const OnlineWelcomeScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        minimumSize: const Size(120.0, 50.0),
                      ),
                      icon: const Icon(
                        Icons.online_prediction,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'ON-LINE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const OfflineWelcomeScreen()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.brown,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        minimumSize: const Size(120.0, 50.0),
                      ),
                      icon: const Icon(
                        Icons.offline_bolt,
                        color: Colors.white,
                      ),
                      label: const Text(
                        'OFF-LINE',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 20,
              child: Container(
                width: 350,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 10,
                      blurRadius: 10,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                  image: const DecorationImage(
                    image: AssetImage(
                        'assets/images/group.png'), // Replace with your image asset path
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 270,
              left: 30,
              child: Text(
                "Choose between offline and online base\non your preferences, convenience, and\nspecific needs.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Image.asset(
                'assets/images/choose.gif', // Replace 'your_image.png' with your asset image path
                width: 400,
                height: 400,
                // Adjust width and height as needed
              ),
            ),
          ],
        ),
      ),
    );
  }
}
