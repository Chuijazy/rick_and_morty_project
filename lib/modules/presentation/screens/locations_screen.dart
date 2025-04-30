import 'package:flutter/material.dart';
import 'package:rick_and_morty_project/modules/services/rick_and_morty_api.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  _LocationsScreenState createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  late Future<List<Map<String, dynamic>>> _locationsFuture;

  @override
  void initState() {
    super.initState();
    _locationsFuture = RickAndMortyApi().fetchAllLocations();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Locations')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _locationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Ошибка: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Нет доступных локаций.'));
          }

          final locations = snapshot.data!;

          return ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              final location = locations[index];
              return ListTile(
                title: Text(location['name'] ?? 'Без названия'),
                subtitle: Text(location['type'] ?? 'Без типа'),
                leading: const Icon(Icons.place),
              );
            },
          );
        },
      ),
    );
  }
}
