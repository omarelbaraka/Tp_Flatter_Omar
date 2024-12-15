import '../model/post.dart';

abstract class RemotePostData{

    Future<List<Post>> getAllPost();
    Future<Post> createPost(Post postToAdd);
    Future<Post> updatePost(Post updatedPost);

}