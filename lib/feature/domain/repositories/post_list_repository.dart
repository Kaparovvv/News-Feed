import 'package:dartz/dartz.dart';
import 'package:news_feed/core/error/failure.dart';
import 'package:news_feed/feature/domain/entities/post_entity.dart';

abstract class PostListRepository {
  Future<Either<Failure, List<PostEntity>>> getPostList(
    String search,
    String tag,
    String author,
  );
}
