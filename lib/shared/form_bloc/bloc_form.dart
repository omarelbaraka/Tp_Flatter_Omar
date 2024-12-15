import 'package:flutter_tp_omar/shared/model/post.dart';
import 'package:flutter_tp_omar/shared/services/posts_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../app_exception.dart';
import 'dart:developer' as developer;


part 'event_form.dart';
part 'state_form.dart';

class PostFormBloc extends Bloc<PostFormEvent, PostFormState> {
  final PostRepository postRepository;

  PostFormBloc({required this.postRepository}) : super(const PostFormState()) {
    on<CreatePostEvent>((event, emit) async {
      emit(state.copyWith(status: PostFormStatus.submitting));

      try {
        await postRepository.createPost(event.newPost);
        developer.log(event.newPost.description);

        emit(state.copyWith(status: PostFormStatus.success));
      } catch (error) {
        final appException = AppException.from(error);
        emit(state.copyWith(
          status: PostFormStatus.error,
          exception: appException,
        ));
      }
    });

    on<UpdatePostEvent>((event, emit) async {
      emit(state.copyWith(status: PostFormStatus.submitting));

      try {
        await postRepository.updatePost(event.updatedPost);
        emit(state.copyWith(status: PostFormStatus.success));
      } catch (error) {
        final appException = AppException.from(error);
        emit(state.copyWith(
          status: PostFormStatus.error,
          exception: appException,
        ));
      }
    });
  }
}