import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_project/modules/core/services/rick_and_morty_api.dart';
import 'package:rick_and_morty_project/modules/data/repository/characters_list_repository.dart';
import 'package:rick_and_morty_project/modules/domain/entities/characters_entity.dart';
import 'package:rick_and_morty_project/modules/presentation/bloc/characters_event.dart';
import 'package:rick_and_morty_project/modules/presentation/bloc/characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersListRepository repository;
  List<CharactersEntity> _allCharacters = [];
  int _currentPage = 1;
  bool _hasMore = true;

  CharactersBloc(this.repository) : super(CharactersInitial()) {
    on<FetchCharacters>(_onFetchCharacters);
    on<FilterCharacters>(_onFilterCharacters);
    on<SearchCharacters>(_onSearchCharacters);
  }

  Future<void> _onFetchCharacters(
    FetchCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    if (!_hasMore) return;

    try {
      if (_currentPage == 1) emit(CharactersLoading());
      final newCharacters = await repository.getAllCharacters(
        page: _currentPage,
      );
      if (newCharacters.isEmpty) {
        _hasMore = false;
        if (_allCharacters.isEmpty) {
          emit(CharactersEmpty(reason: 'initial'));
        }
      } else {
        _allCharacters.addAll(newCharacters);
        _currentPage++;
        emit(
          CharactersLoaded(
            characters: List.from(_allCharacters),
            hasMore: _hasMore,
          ),
        );
      }
    } catch (e) {
      emit(CharactersError(e.toString(), message: ''));
    }
  }

  void _onSearchCharacters(
    SearchCharacters event,
    Emitter<CharactersState> emit,
  ) {
    if (event.query.isEmpty) {
      emit(
        CharactersLoaded(
          characters: List.from(_allCharacters),
          hasMore: _hasMore,
        ),
      );
      return;
    }

    final searched =
        _allCharacters
            .where(
              (char) =>
                  char.name.toLowerCase().contains(event.query.toLowerCase()),
            )
            .toList();

    if (searched.isEmpty) {
      emit(CharactersEmpty(reason: 'search'));
    } else {
      emit(CharactersLoaded(characters: searched, hasMore: _hasMore));
    }
  }

  void _onFilterCharacters(
    FilterCharacters event,
    Emitter<CharactersState> emit,
  ) {
    final filtered =
        _allCharacters.where((char) {
          final matchesStatus =
              event.status == null ||
              char.status.toLowerCase() == event.status!.toLowerCase();

          final matchesGender =
              event.genders == null || event.genders!.isEmpty
                  ? true
                  : event.genders!.any(
                    (gender) =>
                        gender.toLowerCase() == char.gender.toLowerCase(),
                  );

          return matchesStatus && matchesGender;
        }).toList();

    if (filtered.isEmpty) {
      emit(CharactersEmpty(reason: 'filters'));
    } else {
      emit(CharactersLoaded(characters: filtered, hasMore: _hasMore));
    }
  }
}

class EpisodesBloc extends Bloc<EpisodesEvent, EpisodesState> {
  final RickAndMortyApi api;

  EpisodesBloc(this.api) : super(EpisodesInitial()) {
    on<FetchEpisodes>(_onFetchEpisodes);
  }

  int _currentPage = 1;
  bool _hasMore = true;
  final List<Map<String, dynamic>> _allEpisodes = [];

  int get currentPage => _currentPage;
  bool get hasMore => _hasMore;

  Future<void> _onFetchEpisodes(
    FetchEpisodes event,
    Emitter<EpisodesState> emit,
  ) async {
    if (!_hasMore && event.page != 1) return;

    try {
      if (event.page == 1) {
        _allEpisodes.clear();
        _currentPage = 1;
        _hasMore = true;
        emit(EpisodesLoading());
      }

      final episodeUrls = await api.fetchCharacterEpisodes(event.characterId);

      final pageSize = 10;
      final start = (event.page - 1) * pageSize;
      final end =
          (start + pageSize) > episodeUrls.length
              ? episodeUrls.length
              : (start + pageSize);
      if (start >= episodeUrls.length) {
        _hasMore = false;
        emit(
          EpisodesLoaded(episodes: List.from(_allEpisodes), hasMore: _hasMore),
        );
        return;
      }

      final currentPageUrls = episodeUrls.sublist(start, end);

      final episodesDetails = await api.fetchEpisodeDetails(currentPageUrls);

      _allEpisodes.addAll(episodesDetails);

      _hasMore = end < episodeUrls.length;
      _currentPage = event.page + 1;

      emit(
        EpisodesLoaded(episodes: List.from(_allEpisodes), hasMore: _hasMore),
      );
    } catch (e) {
      emit(EpisodesError(message: e.toString()));
    }
  }
}
