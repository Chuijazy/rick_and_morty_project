import 'package:rick_and_morty_project/modules/domain/entities/characters_entity.dart';

abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<CharactersEntity> characters;
  final bool hasReachedMax;
  final int currentPage;

  CharactersLoaded(
    this.characters, {
    this.hasReachedMax = false,
    this.currentPage = 1,
  });
}

class CharactersError extends CharactersState {
  final String message;
  CharactersError(this.message);
}
