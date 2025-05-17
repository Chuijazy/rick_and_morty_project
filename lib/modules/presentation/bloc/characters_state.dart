import 'package:rick_and_morty_project/modules/domain/entities/characters_entity.dart';

abstract class CharactersState {}

class CharactersInitial extends CharactersState {}

class CharactersLoading extends CharactersState {}

class CharactersLoaded extends CharactersState {
  final List<CharactersEntity> characters;
  final bool hasMore;

  CharactersLoaded({required this.characters, required this.hasMore});
}

class CharactersEmpty extends CharactersState {
  final String reason;

  CharactersEmpty({required this.reason});
}

class CharactersError extends CharactersState {
  final String message;

  CharactersError(String string, {required this.message});
}
