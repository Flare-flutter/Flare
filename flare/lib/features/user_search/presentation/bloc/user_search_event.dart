import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class UserSearchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SearchForUsersEvent extends UserSearchEvent {
  final String name;

  SearchForUsersEvent(this.name);

  @override
  List<Object> get props => [name];
}
