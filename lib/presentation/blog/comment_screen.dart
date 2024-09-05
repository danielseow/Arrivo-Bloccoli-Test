import 'package:arrivo_test/application/bloc/comment_bloc/comment_bloc.dart';
import 'package:arrivo_test/application/usecases/get_posts.dart';
import 'package:arrivo_test/domain/entities/post.dart';
import 'package:arrivo_test/infrastructure/api/base_api.dart';
import 'package:arrivo_test/infrastructure/api/post_api.dart';
import 'package:arrivo_test/infrastructure/repositories/post_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final postRepository = PostRepositoryImpl(
      PostAPI(
        BaseAPI('https://jsonplaceholder.typicode.com'),
      ),
    );
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final post = args['post'] as Post;
    final userName = args['userName'] as String;
    return BlocProvider(
      create: (context) => CommentBloc(postUseCases: PostUseCases(postRepository))..add(FetchComments(post.id)),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// back button to '/'
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              Text(
                post.title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
               Text(
                'By $userName',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.body,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 10),
                      BlocBuilder<CommentBloc, CommentState>(
                        builder: (context, state) {
                          if (state is CommentsError) {
                            return Center(child: Text('Error: ${state.message}'));
                          } else if (state is CommentsLoading) {
                            return const Padding(
                              padding: EdgeInsets.all(50.0),
                              child: Center(child: CircularProgressIndicator()),
                            );
                          } else if (state is CommentsLoaded) {
                            return ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (context, index) => Card(
                                margin: const EdgeInsets.all(8.0),
                                color: Colors.grey[200],
                                elevation: 2,
                                borderOnForeground: true,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.comments[index].email,
                                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        state.comments[index].body,
                                        style: Theme.of(context).textTheme.bodySmall,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              itemCount: state.comments.length,
                            );
                          }

                          return const SizedBox.shrink();
                        },
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
