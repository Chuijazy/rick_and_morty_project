import 'package:dio/dio.dart';
import 'package:rick_and_morty_project/modules/data/models/characters_model.dart';
import 'package:rick_and_morty_project/modules/domain/repository/characters_list_domain_repository.dart';

class CharactersListRepository implements CharactersListDomainRepository {
  final Dio _dio = Dio();

  @override
  Future<List<CharactersModel>> getAllCharacters({int page = 1}) async {
    final response = await _dio.get(
      'https://rickandmortyapi.com/api/character',
      queryParameters: {'page': page},
    );
    final List<dynamic> results = response.data['results'];
    return results.map((e) => CharactersModel.fromJson(e)).toList();
  }
}
