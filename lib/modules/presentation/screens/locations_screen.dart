import 'package:flutter/material.dart';
import 'package:rick_and_morty_project/modules/core/services/rick_and_morty_api.dart';

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
      backgroundColor: const Color(0xff0B1E2D),
      appBar: AppBar(
        backgroundColor: const Color(0xff0B1E2D),
        title: const Text(
          'All Locations',
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _locationsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Ошибка: ${snapshot.error}',
                style: const TextStyle(color: Colors.white),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'Нет доступных локаций.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          final locations = snapshot.data!;

          return ListView.builder(
            itemCount: locations.length,
            itemBuilder: (context, index) {
              final location = locations[index];
              return ListTile(
                title: Text(
                  location['name'] ?? 'Без названия',
                  style: const TextStyle(color: Colors.white),
                ),
                subtitle: Text(
                  location['type'] ?? 'Без типа',
                  style: const TextStyle(color: Colors.white70),
                ),
                leading: const Icon(Icons.place, color: Colors.white70),
              );
            },
          );
        },
      ),
    );
  }
}
