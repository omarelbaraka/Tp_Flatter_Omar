import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tp_omar/shared/model/post.dart';
import 'package:flutter_tp_omar/shared/form_bloc/bloc_form.dart';
import 'package:flutter_tp_omar/shared/list_bloc/bloc_list.dart' as list;

class PostFormPage extends StatelessWidget {
  final bool isEditing;
  final String? postId;
  final String? postTitle;
  final String? postDescription;

  const PostFormPage({
    Key? key,
    required this.isEditing,
    this.postId,
    this.postTitle,
    this.postDescription,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: postTitle);
    final descriptionController = TextEditingController(text: postDescription);

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Post' : 'Create Post'),
        backgroundColor: Colors.blueAccent,
        elevation: 4,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title Input
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Post Title',
                hintText: 'Enter your post title here',
                prefixIcon: Icon(Icons.title, color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Description Input
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                labelText: 'Post Description',
                hintText: 'Enter the post description here',
                prefixIcon: Icon(Icons.description, color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.5),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2),
                ),
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 20),

            BlocListener<PostFormBloc, PostFormState>(
              listener: (context, state) {
                if (state.status == PostFormStatus.success) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Success'),
                      content: Text(isEditing
                          ? 'Post updated successfully!'
                          : 'Post created successfully!'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pop(context);
                            context.read<list.PostListBloc>().add(list.LoadPostsEvent());
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                } else if (state.status == PostFormStatus.error) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.exception?.message ?? 'An error occurred')),
                  );
                }
              },
              child: BlocBuilder<PostFormBloc, PostFormState>(
                builder: (context, state) {
                  if (state.status == PostFormStatus.submitting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return ElevatedButton(
                    onPressed: () {
                      final postTitle = titleController.text;
                      final postDescription = descriptionController.text;
                      if (postTitle.isEmpty || postDescription.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Both title and description are required!')),
                        );
                        return;
                      }
                      if (isEditing) {
                        context.read<PostFormBloc>().add(
                          UpdatePostEvent(
                            updatedPost: Post(
                              id: postId ?? '1',
                              title: postTitle,
                              description: postDescription,
                            ),
                          ),
                        );
                      } else {
                        final newPostId = getNextPostId();
                        context.read<PostFormBloc>().add(
                          CreatePostEvent(
                            newPost: Post(
                              id: newPostId,
                              title: postTitle,
                              description: postDescription,
                            ),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      isEditing ? 'Update Post' : 'Create Post',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getNextPostId() {
    int currentMaxId = 3;
    return (currentMaxId + 1).toString();
  }
}
