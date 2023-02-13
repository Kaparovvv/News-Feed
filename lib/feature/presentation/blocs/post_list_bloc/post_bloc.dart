import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_feed/feature/domain/entities/post_entity.dart';
import 'package:news_feed/feature/domain/usecases/post/post_list.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostList postList;
  PostBloc({
    required this.postList,
  }) : super(PostInitial()) {
    on<GetPostListEvent>((event, emit) async {
      emit(LoadingPostListState());
      final result = await postList(
        const PostListParams(),
      );

      result.fold(
        (failure) => emit(
          const ErrorPostListState(
            message: '',
            // message: getIt.get<FailureToMessage>().mapFailureToMessage(failure),
          ),
        ),
        (postList) => emit(
          LoadedPostListState(postList: postList),
        ),
      );
    });
  }
}
