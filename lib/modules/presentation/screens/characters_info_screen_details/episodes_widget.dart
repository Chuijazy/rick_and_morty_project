import 'package:flutter/material.dart';
import 'package:rick_and_morty_project/modules/services/rick_and_morty_api.dart';

class EpisodesWidget extends StatelessWidget {
  final int characterId;
  final RickAndMortyApi api = RickAndMortyApi();

  EpisodesWidget({super.key, required this.characterId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: FutureBuilder<List<String>>(
        future: api.fetchCharacterEpisodes(characterId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: const CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Ошибка: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Text('Нет эпизодов');
          } else {
            return FutureBuilder<List<Map<String, dynamic>>>(
              future: api.fetchEpisodeDetails(snapshot.data!),
              builder: (context, episodeSnapshot) {
                if (episodeSnapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (episodeSnapshot.hasError) {
                  return Text(
                    'Ошибка при загрузке эпизодов: ${episodeSnapshot.error}',
                  );
                } else if (!episodeSnapshot.hasData ||
                    episodeSnapshot.data!.isEmpty) {
                  return const Text('Нет подробной информации о эпизодах');
                } else {
                  return SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:
                          episodeSnapshot.data!.map((episode) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      episode['name'],
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    episode['air_date'],
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                    ),
                  );
                }
              },
            );
          }
        },
      ),
    );
  }
}
