import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tp_omar/shared/list_bloc/bloc_list.dart';
import 'form.dart';
import '../card.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts List'),
        backgroundColor: Colors.blueAccent,
        elevation: 4,
      ),
      body: BlocBuilder<PostListBloc, PostListState>(
        builder: (context, state) {
          if (state.status == PostListStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state.status == PostListStatus.success) {
            final posts = state.posts;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  final post = posts[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: PostCard(
                      title: post.title,
                      description: post.description,
                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PostFormPage(
                              isEditing: true,
                              postId: post.id,
                              postTitle: post.title,
                              postDescription: post.description,
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            );
          } else if (state.status == PostListStatus.error) {
            return Center(child: Text(state.exception?.message ?? 'Error occurred'));
          }
          return const Center(child: Text('No posts available'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PostFormPage(isEditing: false),
            ),
          );
        },
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
