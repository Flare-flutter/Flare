import 'package:flare/features/user_search/domain/entities/user.dart';

abstract class UserDatasource {
  Future<List<User>> search(String name);
}
