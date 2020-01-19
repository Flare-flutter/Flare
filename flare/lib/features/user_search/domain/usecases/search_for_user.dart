import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class SearchForUser implements UseCase<List<User>, SearchForUserParams> {
  final UserRepository repository;

  SearchForUser(this.repository);

  @override
  Future<Either<Failure, List<User>>> call(SearchForUserParams params) async {
    print('[usecase]');
    return await repository.search(params.name);
  }
}

class SearchForUserParams extends Equatable {
  final String name;
  SearchForUserParams({@required this.name});

  @override
  List<Object> get props => [name];
}
