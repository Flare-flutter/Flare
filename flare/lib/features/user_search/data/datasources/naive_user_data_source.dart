import 'package:dartz/dartz.dart';
import 'package:flare/core/error/failures.dart';
import 'package:flare/features/user_search/data/datasources/user_data_source.dart';
import 'package:flare/features/user_search/domain/entities/user.dart';

class NaiveUserDatasource implements UserDatasource {
  List<User> users = [];

  NaiveUserDatasource() {
    users.add(User("donovan", "rost", "1"));
    users.add(User("daniel", "richards", "2"));
    users.add(User("mia", "altieri", "3"));
    users.add(User("emily", "bettencourt", "4"));
    users.add(User("connor", "dunn", "5"));
    users.add(User("wael", "yadego", "6"));
    users.add(User("dana", "fryxell", "7"));
    users.add(User("david", "lawrence", "8"));
    users.add(User("anna", "cruz", "9"));
    users.add(User("scott", "albert", "10"));
  }

  Future<List<User>> search(String name) {
    return Future<List<User>>.value(users
        .where((curr) =>
            ("${curr.firstName.toLowerCase()} ${curr.lastName.toLowerCase()}")
                .contains(name.toLowerCase()))
        .toList());
  }
}
