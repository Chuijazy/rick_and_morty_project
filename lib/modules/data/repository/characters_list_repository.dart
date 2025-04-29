import 'package:dio/dio.dart';
import 'package:rick_and_morty_project/modules/data/models/characters_model.dart';
import 'package:rick_and_morty_project/modules/domain/repository/characters_list_domain_repository.dart';

class CharactersListRepository implements CharactersListDomainRepository {
  final _dio = Dio();

  @override
  Future<List<CharactersModel>> getAllCharacters() async {
    final result = await _dio.get('https://rickandmortyapi.com/api/character');
    final List<dynamic> allCharacters = result.data['results'];
    return allCharacters.map((e) => CharactersModel.fromJson(e)).toList();
  }
}
