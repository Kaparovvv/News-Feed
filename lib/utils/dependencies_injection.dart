import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:news_feed/core/error/failure_to_message.dart';
import 'package:news_feed/core/platform/network_info.dart';
import 'package:news_feed/feature/data/data_sources/post_list/post_list_local_data_source.dart';
import 'package:news_feed/feature/data/data_sources/post_list/post_list_remote_data_source.dart';
import 'package:news_feed/feature/data/repositories/post_list_repository_ext.dart';
import 'package:news_feed/feature/domain/usecases/post/post_list.dart';
import 'package:news_feed/feature/presentation/blocs/post_list_bloc/post_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../feature/domain/repositories/post_list_repository.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  ///Blocs
  getIt.registerFactory(
    () => PostBloc(
      postList: getIt(),
    ),
  );

  ///UseCases
  getIt.registerFactory(
    () => PostList(getIt()),
  );

  ///Repository
  getIt.registerFactory<PostListRepository>(() => PostListRepositoryImpl(
        localDataSource: getIt(),
        remoteDataSource: getIt(),
        networkInfo: getIt(),
      ));

  ///Data_Source
  getIt.registerFactory<PostListRemoteDataSource>(
    () => PostListRemoteDataSourceImpl(),
  );
  getIt.registerFactory<PostListLocalDataSource>(
    () => PostListLocalDataSourceImpl(sharedPreferences: getIt()),
  );

  ///Core
  getIt.registerFactory<NetworkInfo>(
    () => NetworkInfoImpl(),
  );

  ///External
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerLazySingleton(() => sharedPreferences);
  getIt.registerFactory(() => Connectivity());

//FailureToMessage
  getIt.registerFactory<FailureToMessage>(() => FailureToMessage());
}
