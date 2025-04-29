import 'package:flutter/material.dart';
import 'package:rick_and_morty_project/modules/presentation/screens/characters_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0B1E2D),
      body: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CharactersListScreen()),
          );
        },
        child: Stack(
          children: [
            SizedBox.expand(
              child: Image.asset('assets/main_bg.png', fit: BoxFit.cover),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Image.asset(
                  'assets/main_bg_image.png',
                  width: 340,
                  height: 760,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
