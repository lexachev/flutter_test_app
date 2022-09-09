import 'package:rick_and_morty/feature/data/models/location_model.dart';
import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';
//import 'package:meta/meta.dart';

//Если есть доп поля, то лучше добавить их тут, а логику преобразования вынести в отдельный клас Mapper

class PersonModel extends PersonEntity {
  const PersonModel({
    id,
    name,
    status,
    spacies,
    type,
    gender,
    origin,
    location,
    image,
    episode,
    created,
  }) : super(
          id: id,
          name: name,
          status: status,
          spacies: spacies,
          type: type,
          gender: gender,
          origin: origin,
          location: location,
          image: image,
          episode: episode,
          created: created,
        );

  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      spacies: json['spacies'] ?? '',
      type: json['type'],
      gender: json['gender'],
      origin: json['origin'] != null
          ? LocationModel.fromJson(json['origin'])
          : null,
      location: json['location'] != null
          ? LocationModel.fromJson(json['location'])
          : null,
      image: json['image'],
      episode:
          (json['episode'] as List<dynamic>).map((e) => (e as String)).toList(),
      created: DateTime.parse(json['created'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'spacies': spacies,
      'type': type,
      'gender': gender,
      'origin': origin,
      'location': location,
      'image': image,
      'episode': episode,
      'created': created.toIso8601String(),
    };
  }
}
