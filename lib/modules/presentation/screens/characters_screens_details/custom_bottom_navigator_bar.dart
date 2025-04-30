import 'package:flutter/material.dart';

class CustomBottomNavigatorBar extends StatelessWidget {
  const CustomBottomNavigatorBar({
    super.key,
    required Null Function() onHomeTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.white,
      selectedItemColor: const Color(0xff43D049),
      unselectedItemColor: const Color(0xff5B6975),
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset('assets/ghost.png', width: 20, height: 18.8),
          label: 'Characters',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/planet.png', width: 20, height: 18.8),
          label: 'Locations',
        ),
        BottomNavigationBarItem(
          icon: Image.asset('assets/episode.png', width: 20, height: 18.8),
          label: 'Episodes',
        ),
      ],
    );
  }
}
