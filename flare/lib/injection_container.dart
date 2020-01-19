// import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// import 'core/network/network_info.dart';
// import 'core/util/input_converter.dart';
import 'features/user_search/data/datasources/naive_user_data_source.dart';
import 'features/user_search/data/datasources/user_data_source.dart';
import 'features/user_search/data/repositories/user_repository_impl.dart';
import 'features/user_search/domain/repositories/user_repository.dart';
import 'features/user_search/domain/usecases/search_for_user.dart';
import 'features/user_search/presentation/bloc/user_search_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - UserSearch
  // Bloc
  sl.registerFactory(
    () => UserSearchBloc(
      searchForUser: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => SearchForUser(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<UserDatasource>(
    () => NaiveUserDatasource(),
  );

  //! Core

  //! External
}
