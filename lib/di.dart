import 'package:flutter_dev_task/features%20/github_repositories/data/repositories/github_repositories.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features /github_repositories/data/datasources/local_data_source.dart';
import 'features /github_repositories/data/datasources/remote_date_source.dart';
import 'features /github_repositories/presentation/cubit/github_repos_cubit.dart';


import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

Future<void> init() async {

  // Cubits

  getIt.registerFactory(() => GithubReposCubit(repository: getIt()));

  // Repository

  getIt.registerLazySingleton<GithubRepository>(() => GithubRepositoryImpl(
      remoteDataSource: getIt(), localDataSource: getIt(), networkInfo: getIt()));

  // Data sources

  getIt.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl( client: getIt()));
  getIt.registerLazySingleton<LocalDataSource>(
      () => LocalDataSourceImpl(sharedPreferences: getIt()));

  //! Core

  getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(getIt()));

  //! External

  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  // getIt.registerLazySingleton(() => dio.Dio(BaseOptions(
  //   baseUrl: BASE_URL,
  //   receiveDataWhenStatusError: true,
  // ),));
  getIt.registerLazySingleton(() => InternetConnectionChecker());

  getIt.registerLazySingleton(() => http.Client());

}
