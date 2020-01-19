// import 'package:flare/features/number_trivia/domain/entities/number_trivia.dart';
import 'package:equatable/equatable.dart';
import 'package:flare/features/user_search/domain/entities/user.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserSearchState extends Equatable {
  @override
  List<Object> get props => [];
}

class Empty extends UserSearchState {}

class Loading extends UserSearchState {}

class Loaded extends UserSearchState {
  final List<User> result;

  Loaded({@required this.result});

  @override
  List<Object> get props => [result];
}

class Error extends UserSearchState {
  final String message;

  Error({@required this.message});

  @override
  List<Object> get props => [message];
}
