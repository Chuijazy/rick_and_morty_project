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
  final ScrollController _scrollController = ScrollController();

  String _searchCharacter = '';
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    _fetchCharacters();
    _searchController.addListener(() {
      setState(() {
        _searchCharacter = _searchController.text.toLowerCase();
      });
    });
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        !_isLoading &&
        _hasMore) {
      _fetchCharacters();
    }
  }

  Future<void> _fetchCharacters() async {
    setState(() => _isLoading = true);
    final repo = CharactersListRepository();
    final newCharacters = await repo.getAllCharacters(page: _currentPage);

    setState(() {
      _currentPage++;
      _isLoading = false;
      if (newCharacters.isEmpty) {
        _hasMore = false;
      } else {
        charactersList.addAll(newCharacters);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredCharacters =
        charactersList
            .where(
              (character) =>
                  character.name.toLowerCase().contains(_searchCharacter),
            )
            .toList();

    return Scaffold(
      backgroundColor: const Color(0xff0B1E2D),
      appBar: SearchAppBar(controller: _searchController),
      body: SafeArea(
        child: CharactersListView(
          characters: filteredCharacters,
          searchQuery: _searchCharacter,
          isLoading: _isLoading,
          scrollController: _scrollController,
        ),
      ),
      bottomNavigationBar: CustomBottomNavigatorBar(),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
