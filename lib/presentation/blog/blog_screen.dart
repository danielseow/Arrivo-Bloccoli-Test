import 'package:arrivo_test/application/bloc/post_bloc/post_bloc.dart';
import 'package:arrivo_test/application/bloc/user_bloc/user_bloc.dart';
import 'package:arrivo_test/presentation/widgets/custom_search_field.dart';
import 'package:arrivo_test/presentation/widgets/page_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogPostScreen extends StatefulWidget {
  const BlogPostScreen({super.key});

  @override
  State<BlogPostScreen> createState() => _BlogPostScreenState();
}

class _BlogPostScreenState extends State<BlogPostScreen> {
  int entriesAmount = 10;
  int currentPage = 1;
  int totalPage = 1;
  @override
  void initState() {
    super.initState();
    // Load posts when the screen is initialized
    context.read<PostBloc>().add(FetchPosts());
    context.read<UserBloc>().add(FetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              "Server Side",
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Text(
                  "show",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  width: 8,
                ),

                /// Dropdown button for selecting number of posts to be shown
                SizedBox(
                  width: 70,
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                      isDense: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      filled: true,
                      fillColor: Colors.transparent,
                    ),
                    items: List.generate(
                      20,
                      (index) => DropdownMenuItem<int>(
                        value: index + 1,
                        child: Text("${index + 1}"),
                      ),
                    ),
                    value: entriesAmount,
                    onChanged: (int? value) {
                      setState(() {
                        entriesAmount = value!;
                        currentPage = 1;
                      });
                    },
                    focusColor: Colors.transparent,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  "entries",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const Spacer(),
                Text(
                  "Search",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: 200,
                  child: CustomSearchField(
                    onChanged: (value) {
                      currentPage = 1;
                      totalPage = 1;
                      context.read<PostBloc>().add(
                            SearchPosts(
                              value.toLowerCase(),
                            ),
                          );
                    }, // Trigger the search event when the text changes
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, stateUser) {
                if (stateUser is UserError) {
                  return Center(child: Text('Error: ${stateUser.message}'));
                } else if (stateUser is UsersLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (stateUser is UsersLoaded) {
                  return BlocBuilder<PostBloc, PostState>(
                    builder: (context, statePost) {
                      if (statePost is PostError) {
                        return Center(child: Text('Error: ${statePost.message}'));
                      } else if (statePost is PostLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (statePost is PostsLoaded) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: DataTable(
                                  showCheckboxColumn: false,
                                  headingRowColor: WidgetStateColor.resolveWith((states) => const Color(0xfff1f0f5)),
                                  border: const TableBorder(
                                    top: BorderSide(
                                      color: Color(
                                        0xffdcdcdc,
                                      ),
                                      width: 1.5,
                                    ),
                                    horizontalInside: BorderSide(
                                      color: Color(0xffdcdcdc),
                                    ),
                                  ),
                                  columns: const [
                                    DataColumn(
                                      label: Text('ID'),
                                      // numeric: true,
                                    ),
                                    DataColumn(label: Text('User')),
                                    DataColumn(label: Text('Title')),
                                    DataColumn(label: Text('Body')),
                                  ],
                                  dataRowMaxHeight: 100,
                                  rows: statePost.posts.skip(currentPage == 1 ? 0 : currentPage * entriesAmount).take(entriesAmount).map((post) {
                                    final userName = stateUser.users.firstWhere((element) => element.id == post.userId).name.toString();
                                    return DataRow(
                                      onSelectChanged: (selected) {
                                        Navigator.pushNamed(
                                          context,
                                          '/comment',
                                          arguments: {
                                            'post': post,
                                            'userName': userName,
                                          },
                                        );
                                      },
                                      cells: [
                                        DataCell(
                                          Text(
                                            post.id.toString(),
                                          ),
                                        ),
                                        DataCell(
                                          Text(userName),
                                        ),
                                        DataCell(
                                          Text(
                                            post.title.toString(),
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            post.body.toString(),
                                          ),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state is PostError) {
                    return Center(child: Text('Error: ${state.message}'));
                  } else if (state is PostLoading) {
                    return const SizedBox.shrink();
                  } else if (state is PostsLoaded) {
                    totalPage = (state.posts.length - 1) ~/ entriesAmount;
                    return CustomNumberPagination(
                      totalPages: totalPage,
                      currentPage: currentPage,
                      onPageChanged: (value) {
                        setState(() {
                          currentPage = value;
                        });
                      },
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
