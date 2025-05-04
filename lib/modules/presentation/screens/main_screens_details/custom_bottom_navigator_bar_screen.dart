import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_project/modules/presentation/screens/characters_list_screen.dart';
import 'package:rick_and_morty_project/modules/presentation/screens/episodes_screen.dart';
import 'package:rick_and_morty_project/modules/presentation/screens/locations_screen.dart';

@RoutePage()
class CustomBottomNavigatorBarScreen extends StatefulWidget {
  const CustomBottomNavigatorBarScreen({super.key});

  @override
  State<CustomBottomNavigatorBarScreen> createState() =>
      _CustomBottomNavigatorBarState();
}

class _CustomBottomNavigatorBarState
    extends State<CustomBottomNavigatorBarScreen> {
  int myIndex = 0;

  final List<Widget> screens = [
    const CharactersListScreen(),
    const LocationsScreen(),
    const EpisodesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[myIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(fontSize: 14),
        unselectedLabelStyle: const TextStyle(fontSize: 14),
        selectedItemColor: const Color(0xff22A2BD),
        unselectedItemColor: const Color(0xffBDBDBD),
        type: BottomNavigationBarType.fixed,
        currentIndex: myIndex,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/ghost.png')),
            label: 'Characters',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/planet.png')),
            label: 'Locations',
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/episode.png')),
            label: 'Episodes',
          ),
        ],
      ),
    );
  }
}
