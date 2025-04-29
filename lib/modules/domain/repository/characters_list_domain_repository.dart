import 'package:rick_and_morty_project/modules/domain/entities/characters_entity.dart';

abstract class CharactersListDomainRepository {
  Future<List<CharactersEntity>> getAllCharacters();
}
