import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rick_and_morty_project/modules/core/services/rick_and_morty_api.dart';

@RoutePage()
class EpisodesScreen extends StatefulWidget {
  const EpisodesScreen({super.key});

  @override
  _EpisodesScreenState createState() => _EpisodesScreenState();
}

class _EpisodesScreenState extends State<EpisodesScreen> {
  late Future<List<Map<String, dynamic>>> _episodesFuture;

  @override
  void initState() {
    super.initState();
    _episodesFuture = RickAndMortyApi().fetchAllEpisodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Episodes')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _episodesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет доступных эпизодов.'));
          }

          final episodes = snapshot.data!;

          return ListView.builder(
            itemCount: episodes.length,
            itemBuilder: (context, index) {
              final episode = episodes[index];
              return ListTile(
                title: Text(episode['name'] ?? 'Без названия'),
                subtitle: Text(episode['air_date'] ?? 'Без даты'),
                leading: const Icon(Icons.movie),
              );
            },
          );
        },
      ),
    );
  }
}
