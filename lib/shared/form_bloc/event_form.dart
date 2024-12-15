part of 'bloc_form.dart';

@immutable
abstract class PostFormEvent {}

class CreatePostEvent extends PostFormEvent {
  final Post newPost;

  CreatePostEvent({required this.newPost});
}

class UpdatePostEvent extends PostFormEvent {
  final Post updatedPost;

   UpdatePostEvent({required this.updatedPost});
}