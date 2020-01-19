import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flare/core/error/failures.dart';
// import 'package:flare/core/usecases/usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flare/features/user_search/domain/entities/user.dart';
import 'package:meta/meta.dart';

import './bloc.dart';
// import '../../../../core/util/input_converter.dart';
import '../../domain/usecases/search_for_user.dart';

const String SERVER_FAILURE_MESSAGE = 'Server Failure';
const String CACHE_FAILURE_MESSAGE = 'Cache Failure';
const String INVALID_INPUT_FAILURE_MESSAGE =
    'Invalid Input - The number must be a positive integer or zero.';

class UserSearchBloc extends Bloc<UserSearchEvent, UserSearchState> {
  final SearchForUser searchForUser;

  UserSearchBloc({
    @required this.searchForUser,
  });

  @override
  UserSearchState get initialState => Empty();

  @override
  Stream<UserSearchState> mapEventToState(
    UserSearchEvent event,
  ) async* {
    if (event is SearchForUsersEvent) {
      yield Loading();
      final failureOrResult =
          await searchForUser(SearchForUserParams(name: event.name));
      yield* _eitherLoadedOrErrorState(failureOrResult);
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return SERVER_FAILURE_MESSAGE;
      case CacheFailure:
        return CACHE_FAILURE_MESSAGE;
      default:
        return 'Unexpected error';
    }
  }

  Stream<UserSearchState> _eitherLoadedOrErrorState(
    Either<Failure, List<User>> failureOrResult,
  ) async* {
    yield failureOrResult.fold(
      (failure) => Error(message: _mapFailureToMessage(failure)),
      (result) => Loaded(result: result),
    );
  }
}
