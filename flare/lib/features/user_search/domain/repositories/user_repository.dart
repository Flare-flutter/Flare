import 'package:dartz/dartz.dart';
import 'package:flare/core/error/failures.dart';
import 'package:flare/features/user_search/domain/entities/user.dart';

abstract class UserRepository {
  Future<Either<Failure, List<User>>> search(String name);
}
