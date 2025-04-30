import 'package:flutter/material.dart';
import 'package:rick_and_morty_project/modules/domain/entities/characters_entity.dart';

class CharactersInfoItem extends StatelessWidget {
  const CharactersInfoItem({super.key, required this.character});
  final CharactersEntity character;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text(
                  'Gender',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff828282),
                  ),
                ),
                Text(
                  character.gender,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff0B1E2D),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Text(
                  'Species',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff828282),
                  ),
                ),
                Text(
                  character.species,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff0B1E2D),
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Origin',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff828282),
                  ),
                ),
                Text(
                  character.originName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff0B1E2D),
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Location',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff828282),
                  ),
                ),
                Text(
                  character.locationName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Color(0xff0B1E2D),
                  ),
                ),
              ],
            ),
            const Icon(Icons.arrow_forward_ios_rounded),
          ],
        ),
      ],
    );
  }
}
