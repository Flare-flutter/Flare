import 'package:dartz/dartz.dart';
import 'package:flare/core/error/failures.dart';
import 'package:flare/features/user_search/data/datasources/user_data_source.dart';
import 'package:flare/features/user_search/domain/entities/user.dart';
import 'package:flare/features/user_search/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDatasource userDatasource;

  UserRepositoryImpl(this.userDatasource);

  @override
  Future<Either<Failure, List<User>>> search(String name) async {
    try {
      List<User> results = await userDatasource.search(name);
      return Right(results);
    } on Exception {
      return Left(ServerFailure());
    }
  }
}
