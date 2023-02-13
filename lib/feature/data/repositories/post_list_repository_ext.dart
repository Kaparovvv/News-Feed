import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:news_feed/feature/data/models/post_model.dart';

import '../../../core/error/exception.dart';
import '../../../core/error/failure.dart';
import '../../../core/platform/network_info.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/post_list_repository.dart';
import '../data_sources/post_list/post_list_local_data_source.dart';
import '../data_sources/post_list/post_list_remote_data_source.dart';

class PostListRepositoryImpl extends PostListRepository {
  final PostListLocalDataSource localDataSource;
  final PostListRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  PostListRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<PostEntity>>> getPostList(
    String search,
    String tag,
    String author,
  ) async {
    return await _getPostList(
      () => remoteDataSource.getPostList(
        search,
        tag,
        author,
      ),
    );
  }

  Future<Either<Failure, List<PostEntity>>> _getPostList(
    Future<List<PostModel>> Function() getPostList,
  ) async {
    if (await networkInfo.isConnected == ConnectivityResult.mobile ||
        await networkInfo.isConnected == ConnectivityResult.wifi) {
      try {
        final remotePostList = await getPostList();
        localDataSource.postListDataToCache(remotePostList);
        return Right(remotePostList);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPostList = await localDataSource.getPostListDataFromCache();
        return Right(localPostList);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
