import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_feed/commons/textStyle_helper.dart';
import 'package:news_feed/commons/theme_helper.dart';
import 'package:news_feed/feature/presentation/state_blocs/cubit/typeoffeed_cubit.dart';
import 'package:news_feed/feature/presentation/widgets/custom_icon_button_widget.dart';
import 'package:news_feed/feature/presentation/widgets/news_card_widget.dart';
import 'package:news_feed/feature/presentation/widgets/news_tile_widget.dart';

import '../blocs/post_list_bloc/post_bloc.dart';

class NewsFeedScreen extends StatefulWidget {
  const NewsFeedScreen({super.key});

  @override
  State<NewsFeedScreen> createState() => _NewsFeedScreenState();
}

class _NewsFeedScreenState extends State<NewsFeedScreen> {
  ScrollController? _scrollController;
  late TypeoffeedCubit _cubit;
  late PostBloc _postBloc;

  @override
  void initState() {
    _cubit = BlocProvider.of(context);
    _cubit.feedViewList();
    _postBloc = BlocProvider.of(context);
    _postBloc.add(GetPostListEvent());
    _scrollController = ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'НОВОСТИ',
          style: TextStyleHelper.f30w500.copyWith(
            color: ThemeHelper.color7E5BC2,
            letterSpacing: 10,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async => _postBloc.add(GetPostListEvent()),
        child: BlocConsumer<PostBloc, PostState>(
          bloc: _postBloc,
          listener: (context, state) {
            if (state is ErrorPostListState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    state.message.toString(),
                  ),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is LoadingPostListState) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is LoadedPostListState) {
              var post = state.postList;
              return BlocBuilder<TypeoffeedCubit, TypeoffeedState>(
                bloc: _cubit,
                builder: (context, state) {
                  if (state is TypeOfFeedTileState) {
                    return CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverToBoxAdapter(
                          child: CustomIconButton(
                            icon: Icons.view_module,
                            onPressed: () => _cubit.feedViewList(),
                          ),
                        ),
                        SliverGrid(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200.0,
                            mainAxisSpacing: 10.0,
                            crossAxisSpacing: 10.0,
                          ),
                          delegate: SliverChildBuilderDelegate(
                            (BuildContext context, int index) {
                              return NewsTileWidget(
                                width: width,
                                height: height,
                                imageUrl: post[index].image,
                                text: post[index].shortDesc,
                              );
                            },
                            childCount: post.length,
                          ),
                        )
                      ],
                    );
                  }
                  if (state is TypeOfFeedListState) {
                    return CustomScrollView(
                      controller: _scrollController,
                      slivers: [
                        SliverToBoxAdapter(
                          child: CustomIconButton(
                            icon: Icons.menu,
                            onPressed: () => _cubit.feedViewTile(),
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(
                                  top: 20,
                                  left: 15,
                                  right: 15,
                                ),
                                child: NewsCardWidget(
                                  height: height,
                                  width: width,
                                  imageUrl: post[index].image,
                                  text: post[index].shortDesc,
                                ),
                              );
                            },
                            childCount: post.length,
                          ),
                        ),
                      ],
                    );
                  }
                  return const SizedBox();
                },
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
