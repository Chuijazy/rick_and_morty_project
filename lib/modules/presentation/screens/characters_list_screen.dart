import 'package:flutter/material.dart';
import 'package:rick_and_morty_project/modules/data/repository/characters_list_repository.dart';
import 'package:rick_and_morty_project/modules/domain/entities/characters_entity.dart';
import 'package:rick_and_morty_project/modules/presentation/screens/filters_screen.dart';
import 'package:rick_and_morty_project/modules/presentation/screens/main_screens_details/characters_list_view.dart';
import 'package:rick_and_morty_project/modules/presentation/screens/main_screens_details/search_app_bar.dart';

class CharactersListScreen extends StatefulWidget {
  const CharactersListScreen({super.key});

  @override
  State<CharactersListScreen> createState() => _CharactersListScreenState();
}

class _CharactersListScreenState extends State<CharactersListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<CharactersEntity> charactersList = [];
  String _searchCharacter = '';
  String? _selectedStatus;
  String? _selectedGender;

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

  List<CharactersEntity> _applyFilters() {
    return charactersList.where((character) {
      final matchesName = character.name.toLowerCase().contains(
        _searchCharacter,
      );
      final matchesStatus =
          _selectedStatus == null ||
          character.status.toLowerCase() == _selectedStatus!.toLowerCase();
      final matchesGender =
          _selectedGender == null ||
          character.gender.toLowerCase() == _selectedGender!.toLowerCase();
      return matchesName && matchesStatus && matchesGender;
    }).toList();
  }

  void _openFilters() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => FiltersScreen(
              selectedStatus: _selectedStatus,
              selectedGender: _selectedGender,
            ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _selectedStatus = result['status'];
        _selectedGender = result['gender'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final filteredCharacters = _applyFilters();

    final bool isFiltered = _selectedStatus != null || _selectedGender != null;
    final bool isSearchActive = _searchCharacter.isNotEmpty;

    final bool showNotFoundBySearch =
        !_isLoading &&
        charactersList.isNotEmpty &&
        filteredCharacters.isEmpty &&
        isSearchActive &&
        !isFiltered;

    final bool showNotFoundByFilters =
        !_isLoading &&
        charactersList.isNotEmpty &&
        filteredCharacters.isEmpty &&
        isFiltered;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: SearchAppBar(
        controller: _searchController,
        onFilterTap: _openFilters,
      ),
      body: SafeArea(
        child:
            showNotFoundBySearch
                ? _buildNotFoundBySearch()
                : showNotFoundByFilters
                ? _buildNotFoundByFilters()
                : CharactersListView(
                  characters: filteredCharacters,
                  searchQuery: _searchCharacter,
                  isLoading: _isLoading,
                  scrollController: _scrollController,
                ),
      ),
    );
  }

  Widget _buildNotFoundBySearch() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/not_found.png', width: 200, height: 200),
          const SizedBox(height: 20),
          const Text(
            'No characters found with this name',
            style: TextStyle(fontSize: 18, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNotFoundByFilters() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/filters_not_found.png', width: 200, height: 200),
          const SizedBox(height: 20),
          const Text(
            'No characters found for these filters',
            style: TextStyle(fontSize: 18, color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
