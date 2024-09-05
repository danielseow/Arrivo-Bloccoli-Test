import 'package:arrivo_test/application/bloc/post_bloc/post_bloc.dart';
import 'package:arrivo_test/application/bloc/user_bloc/user_bloc.dart';
import 'package:arrivo_test/application/usecases/get_posts.dart';
import 'package:arrivo_test/application/usecases/get_users.dart';
import 'package:arrivo_test/infrastructure/api/base_api.dart';
import 'package:arrivo_test/infrastructure/api/post_api.dart';
import 'package:arrivo_test/infrastructure/api/user_api.dart';
import 'package:arrivo_test/infrastructure/repositories/post_repository_impl.dart';
import 'package:arrivo_test/infrastructure/repositories/users_repository_impl.dart';
import 'package:arrivo_test/presentation/blog/blog_screen.dart';
import 'package:arrivo_test/presentation/blog/comment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final postRepository = PostRepositoryImpl(
      PostAPI(
        BaseAPI('https://jsonplaceholder.typicode.com'),
      ),
    );

    final userRepository = UsersRepositoryImpl(
      UserAPI(
        BaseAPI('https://jsonplaceholder.typicode.com'),
      ),
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => PostBloc(postUseCases: PostUseCases(postRepository)),
        ),
        BlocProvider(
          create: (context) => UserBloc(usersUseCases: UsersUseCases(userRepository)),
        ),
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const BlogPostScreen(),
          '/comment': (context) => const CommentScreen(),
        },
      ),
    );
  }
}
