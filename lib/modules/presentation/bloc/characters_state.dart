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

abstract class EpisodesState {}

class EpisodesInitial extends EpisodesState {}

class EpisodesLoading extends EpisodesState {
  get episodes => null;
}

class EpisodesLoaded extends EpisodesState {
  final List<Map<String, dynamic>> episodes;
  final bool hasMore;

  EpisodesLoaded({required this.episodes, required this.hasMore});
}

class EpisodesError extends EpisodesState {
  final String message;

  EpisodesError({required this.message});
}
