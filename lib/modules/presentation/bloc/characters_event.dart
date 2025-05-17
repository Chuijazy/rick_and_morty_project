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
