import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_project/modules/domain/entities/characters_entity.dart';
import 'package:rick_and_morty_project/modules/presentation/screens/characters_info_screen_details/characters_info_item.dart';
import 'package:rick_and_morty_project/modules/presentation/screens/characters_info_screen_details/episodes_widget.dart';

class CharactersInfoScreen extends StatelessWidget {
  final CharactersEntity character;

  const CharactersInfoScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    final statusColor =
        character.status.toLowerCase() == 'unknown'
            ? Colors.grey
            : character.status.toLowerCase() == 'alive'
            ? Colors.green
            : Colors.red;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  child: Stack(
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 250,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.network(character.image, fit: BoxFit.cover),
                            Positioned.fill(
                              child: BackdropFilter(
                                filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                                child: Container(
                                  color: Colors.black.withOpacity(0.3),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 5),
                              image: DecorationImage(
                                image: NetworkImage(character.image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          children: [
                            const SizedBox(height: 20),
                            Text(
                              character.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              character.status,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: statusColor,
                                fontSize: 18,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            const SizedBox(height: 16),
                            CharactersInfoItem(character: character),
                            const SizedBox(height: 40),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                'Episodes:',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            EpisodesWidget(characterId: character.id),
                            const SizedBox(height: 10),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Кнопка назад
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 10,
            child: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
                size: 24,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }
}
