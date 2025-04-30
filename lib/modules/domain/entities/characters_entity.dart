class CharactersEntity {
  final int id;
  final String name;
  final String image;
  final String status;
  final String species;
  final String gender;
  final String originName;
  final String locationName;
  final String? type;

  var episode;

  CharactersEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.status,
    required this.species,
    required this.gender,
    required this.originName,
    required this.locationName,
    this.type,
  });
}
