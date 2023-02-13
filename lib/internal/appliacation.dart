import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_feed/commons/theme_helper.dart';
import 'package:news_feed/feature/presentation/blocs/post_list_bloc/post_bloc.dart';
import 'package:news_feed/feature/presentation/screens/news_feed_screen.dart';

import '../feature/presentation/state_blocs/cubit/typeoffeed_cubit.dart';
import '../utils/dependencies_injection.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme:
            const AppBarTheme(backgroundColor: ThemeHelper.white, elevation: 0),
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => TypeoffeedCubit(),
          ),
          BlocProvider(
            create: (context) => PostBloc(
              postList: getIt(),
            ),
          ),
        ],
        child: const NewsFeedScreen(),
      ),
    );
  }
}
