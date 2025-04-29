import 'package:flutter/material.dart';
import 'package:rick_and_morty_project/modules/data/repository/characters_list_repository.dart';
import 'package:rick_and_morty_project/modules/domain/entities/characters_entity.dart';
import 'package:rick_and_morty_project/modules/presentation/screens/screens_details/characters_list_view.dart';
import 'package:rick_and_morty_project/modules/presentation/screens/screens_details/custom_bottom_navigator_bar.dart';
import 'package:rick_and_morty_project/modules/presentation/screens/screens_details/search_app_bar.dart';

class CharactersListScreen extends StatefulWidget {
  const CharactersListScreen({super.key});

  @override
  State<CharactersListScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<CharactersListScreen> {
  List<CharactersEntity> charactersList = [];
  final TextEditingController _searchController = TextEditingController();
  String _searchCharacter = '';

  @override
  void initState() {
    super.initState();
    getAllCharacters();
    _searchController.addListener(() {
      setState(() {
        _searchCharacter = _searchController.text.toLowerCase();
      });
    });
  }

  Future<void> getAllCharacters() async {
    final repo = CharactersListRepository();
    charactersList = await repo.getAllCharacters();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final filteredCharacters =
        charactersList.where((character) {
          return character.name.toLowerCase().contains(_searchCharacter);
        }).toList();

    return Scaffold(
      backgroundColor: const Color(0xff0B1E2D),
      appBar: SearchAppBar(controller: _searchController),
      body: SafeArea(
        child: CharactersListView(
          characters: filteredCharacters,
          searchQuery: _searchCharacter,
        ),
      ),
      bottomNavigationBar: CustomBottomNavigatorBar(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
