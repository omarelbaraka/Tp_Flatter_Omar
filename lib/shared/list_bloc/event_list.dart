part of 'bloc_list.dart';

@immutable
abstract class PostListEvent {}

class LoadPostsEvent extends PostListEvent {}

class AddPostEvent extends PostListEvent {
  final Post newPost;

  AddPostEvent({required this.newPost});
}

class UpdatePostEvent extends PostListEvent {
  final Post updatedPost;

  UpdatePostEvent({required this.updatedPost});
}