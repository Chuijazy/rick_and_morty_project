import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rick_and_morty_project/modules/data/repository/characters_list_repository.dart';
import 'package:rick_and_morty_project/modules/presentation/bloc/characters_event.dart';
import 'package:rick_and_morty_project/modules/presentation/bloc/characters_state.dart';

class CharactersBloc extends Bloc<CharactersEvent, CharactersState> {
  final CharactersListRepository repository;

  CharactersBloc(this.repository) : super(CharactersInitial()) {
    on<LoadCharacters>(_onLoadCharacters);
    on<LoadMoreCharacters>(_onLoadMoreCharacters);
  }

  Future<void> _onLoadCharacters(
    LoadCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    emit(CharactersLoading());
    try {
      final characters = await repository.getAllCharacters(page: 1);
      emit(CharactersLoaded(characters, currentPage: 1));
    } catch (e) {
      emit(CharactersError('Error loading characters: $e'));
    }
  }

  Future<void> _onLoadMoreCharacters(
    LoadMoreCharacters event,
    Emitter<CharactersState> emit,
  ) async {
    if (state is CharactersLoaded) {
      final currentState = state as CharactersLoaded;
      final nextPage = currentState.currentPage + 1;

      try {
        final newCharacters = await repository.getAllCharacters(page: nextPage);

        if (newCharacters.isEmpty) {
          emit(
            CharactersLoaded(
              currentState.characters,
              hasReachedMax: true,
              currentPage: currentState.currentPage,
            ),
          );
        } else {
          emit(
            CharactersLoaded(
              [...currentState.characters, ...newCharacters],
              hasReachedMax: false,
              currentPage: nextPage,
            ),
          );
        }
      } catch (e) {
        emit(CharactersError('Error loading more characters: $e'));
      }
    }
  }
}
