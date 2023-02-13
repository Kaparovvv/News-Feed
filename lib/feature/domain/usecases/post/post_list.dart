import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:news_feed/core/error/failure.dart';
import 'package:news_feed/core/usecases/usecases.dart';
import 'package:news_feed/feature/domain/entities/post_entity.dart';
import 'package:news_feed/feature/domain/repositories/post_list_repository.dart';

class PostList extends UseCase<List<PostEntity>, PostListParams> {
  final PostListRepository postListRepository;

  PostList(this.postListRepository);

  @override
  Future<Either<Failure, List<PostEntity>>> call(PostListParams params) async {
    return await postListRepository.getPostList(
      params.search ?? '',
      params.tag ?? '',
      params.author ?? '',
    );
  }
}

class PostListParams extends Equatable {
  final String? search;
  final String? tag;
  final String? author;

  const PostListParams({
    this.search,
    this.tag,
    this.author,
  });

  @override
  List<Object?> get props => [
        search,
        tag,
        author,
      ];
}
