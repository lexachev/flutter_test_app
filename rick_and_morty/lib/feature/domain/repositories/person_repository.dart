import 'package:rick_and_morty/feature/domain/entities/person_entity.dart';

// Для обработки ошибок, чтобы возвращать либо нужный тип Future<List<PersonEntity>>, либо ошибочный тип (как generic в swift)
import 'package:dartz/dartz.dart';

import '../../../core/error/failure.dart';

//Future - для ассинхронности методов
abstract class PersonRepository {
  Future<Either<Failure, List<PersonEntity>>> getAllPerson(int page);
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query);
}
