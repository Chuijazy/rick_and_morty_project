import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_project/modules/core/config/router/router.gr.dart';
import 'package:rick_and_morty_project/modules/presentation/bloc/characters_bloc.dart';
import 'package:rick_and_morty_project/modules/presentation/bloc/characters_event.dart';
import 'package:rick_and_morty_project/modules/presentation/bloc/characters_state.dart';
import 'package:rick_and_morty_project/modules/presentation/screens/main_screens_details/characters_list_view_screen.dart';
import 'package:rick_and_morty_project/modules/presentation/screens/main_screens_details/search_app_bar.dart';

@RoutePage()
class CharactersListScreen extends StatefulWidget {
  const CharactersListScreen({super.key});

  @override
  State<CharactersListScreen> createState() => _CharactersListScreenState();
}

class _CharactersListScreenState extends State<CharactersListScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String? _selectedStatus;
  String? _selectedGender;

  @override
  void initState() {
    super.initState();
    context.read<CharactersBloc>().add(FetchCharacters());

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        context.read<CharactersBloc>().add(FetchCharacters());
      }
    });

    _searchController.addListener(() {
      context.read<CharactersBloc>().add(
        SearchCharacters(_searchController.text),
      );
    });
  }

  void _openFilters() async {
    final result = await context.pushRoute(
      FiltersRoute(
        selectedStatus: _selectedStatus,
        selectedGender: _selectedGender,
      ),
    );

    if (result != null && mounted) {
      final data = result as Map<String, dynamic>;
      _selectedStatus = data['status'];
      _selectedGender = null;
      final List<String>? selectedGenders =
          (data['genders'] as List<dynamic>?)?.cast<String>();

      context.read<CharactersBloc>().add(
        FilterCharacters(status: _selectedStatus, genders: selectedGenders),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff0B1E2D),
      appBar: SearchAppBar(
        controller: _searchController,
        onFilterTap: _openFilters,
      ),
      body: BlocBuilder<CharactersBloc, CharactersState>(
        builder: (context, state) {
          if (state is CharactersLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CharactersLoaded) {
            return CharactersListViewScreen(
              characters: state.characters,
              scrollController: _scrollController,
              isLoading: state.hasMore,
              searchQuery: _searchController.text,
            );
          } else if (state is CharactersEmpty) {
            if (state.reason == 'filters') {
              return _buildNotFoundByFilters();
            } else {
              return _buildNotFoundBySearch();
            }
          } else if (state is CharactersError) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox.shrink();
        },
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
            style: TextStyle(fontSize: 18, color: Color(0xff5B6975)),
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
            style: TextStyle(fontSize: 18, color: Color(0xff5B6975)),
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
