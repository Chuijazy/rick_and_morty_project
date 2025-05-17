abstract class CharactersEvent {}

class FetchCharacters extends CharactersEvent {
  final int page;

  FetchCharacters({this.page = 1});
}

class FilterCharacters extends CharactersEvent {
  final String? status;
  final List<String>? genders;

  FilterCharacters({this.status, this.genders, String? gender});
}

class SearchCharacters extends CharactersEvent {
  final String query;

  SearchCharacters(this.query);
}

abstract class EpisodesEvent {}

class FetchEpisodes extends EpisodesEvent {
  final int characterId;
  final int page;

  FetchEpisodes({required this.characterId, this.page = 1});
}
