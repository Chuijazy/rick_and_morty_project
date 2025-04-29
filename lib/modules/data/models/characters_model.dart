import 'package:rick_and_morty_project/modules/domain/entities/characters_entity.dart';

class CharactersModel extends CharactersEntity {
  CharactersModel({
    required super.id,
    required super.name,
    required super.image,
    required super.status,
    required super.species,
    required super.gender,
    super.type,
  });

  factory CharactersModel.fromJson(Map<String, dynamic> json) {
    return CharactersModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      status: json['status'] ?? '',
      species: json['species'] ?? '',
      gender: json['gender'] ?? '',
      type: json['type'] ?? '',
    );
  }
}
