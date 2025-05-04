import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_project/modules/core/config/router/router.gr.dart';
import 'package:rick_and_morty_project/modules/domain/entities/characters_entity.dart';

@RoutePage()
class CharactersListViewScreen extends StatelessWidget {
  final List<CharactersEntity> characters;
  final String searchQuery;
  final bool isLoading;
  final ScrollController scrollController;

  const CharactersListViewScreen({
    super.key,
    required this.characters,
    required this.searchQuery,
    required this.isLoading,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    if (characters.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/not_found.png', width: 200),
            const SizedBox(height: 5),
            const Text(
              'Character with this \n   name not found',
              style: TextStyle(
                color: Color(0xff828282),
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      controller: scrollController,
      itemCount: characters.length + (isLoading ? 2 : 1),
      itemBuilder: (context, index) {
        if (index == 0) {
          final isSearching = searchQuery.isNotEmpty;
          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: Text(
              isSearching ? 'Search Results' : 'All Characters',
              style: const TextStyle(
                color: Color(0xff5B6975),
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        }

        if (index == characters.length + 1 && isLoading) {
          return const Padding(
            padding: EdgeInsets.all(16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final character = characters[index - 1];
        final statusColor =
            character.status.toLowerCase() == 'unknown'
                ? Colors.grey
                : character.status.toLowerCase() == 'alive'
                ? Colors.green
                : Colors.red;

        return ListTile(
          onTap: () {
            context.pushRoute(CharactersInfoRoute(character: character));
          },
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 6,
          ),
          leading: CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(character.image),
            backgroundColor: Colors.transparent,
          ),
          title: Text(
            character.status,
            style: TextStyle(
              color: statusColor,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                character.name,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                '${character.species}, ${character.gender}',
                style: const TextStyle(
                  color: Color(0xff828282),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
