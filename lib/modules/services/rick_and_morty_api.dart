import 'package:dio/dio.dart';

class RickAndMortyApi {
  final Dio _dio = Dio();

  Future<List<String>> fetchCharacterEpisodes(int characterId) async {
    try {
      final response = await _dio.get(
        'https://rickandmortyapi.com/api/character/$characterId',
      );
      List<dynamic> episodes = response.data['episode'];
      return List<String>.from(episodes);
    } catch (e) {
      print('Ошибка при получении эпизодов: $e');
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> fetchEpisodeDetails(
    List<String> episodeUrls,
  ) async {
    try {
      List<Map<String, dynamic>> episodeDetails = [];
      for (var url in episodeUrls) {
        final response = await _dio.get(url);
        episodeDetails.add(response.data);
      }
      return episodeDetails;
    } catch (e) {
      print('Ошибка при получении данных эпизодов: $e');
      return [];
    }
  }
}
