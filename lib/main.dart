import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_tp_omar/shared/list_bloc/bloc_list.dart';
import 'package:flutter_tp_omar/shared/form_bloc/bloc_form.dart';
import 'package:flutter_tp_omar/shared/services/local_post_fakeData.dart';
import 'package:flutter_tp_omar/shared/services/posts_repository.dart';
import 'package:flutter_tp_omar/shared/services/local_data.dart';
import 'package:flutter_tp_omar/shared/services/remote_posts_fakeData.dart';
import 'package:flutter_tp_omar/shared/services/remote_data.dart';
import 'package:flutter_tp_omar/screens/posts.dart';
import 'package:flutter_tp_omar/screens/form.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PostRepository(
        localPostData: FakePostData(),  // Local data source
        remotePostData: FakeRemotePostData(),  // Remote data source
      ),
      child: MultiBlocProvider(
        providers: [
          // Providing PostFormBloc with the PostRepository
          BlocProvider(
            create: (context) => PostFormBloc(
              postRepository: context.read<PostRepository>(),
            ),
          ),
          // Providing PostListBloc with the PostRepository and loading posts
          BlocProvider(
            create: (context) => PostListBloc(postRepository: context.read<PostRepository>())
              ..add(LoadPostsEvent()),  // Loading posts when the app starts
          ),
        ],
        child: MaterialApp(
          title: 'Posts App',
          theme: ThemeData(primarySwatch: Colors.blue),
          initialRoute: '/',  // Setting the initial route to the posts page
          routes: {
            '/': (context) => const PostsPage(),  // Main page
            '/postForm': (context) => const PostFormPage(isEditing: false),  // Form page for creating posts
          },
        ),
      ),
    );
  }
}