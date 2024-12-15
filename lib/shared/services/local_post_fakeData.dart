import 'local_data.dart';
import '../model/post.dart';



class FakePostData extends LocalPostData {
  final List<Post> _fakePosts = [
    Post(id: '1', title: 'Post 1', description: 'Description Post 1'),
    Post(id: '2', title: 'Post 2', description: 'Description Post 2'),
    Post(id: '3', title: 'Post 3', description: 'Description Post 3'),
  ];

  @override
  Future<Post> createPost(Post postToAdd) async {
    await Future.delayed(const Duration(seconds: 1));
    _fakePosts.add(postToAdd);
    return postToAdd;
  }

  @override
  Future<List<Post>> getAllPost() async {
    await Future.delayed(const Duration(seconds: 1));
    return _fakePosts;
  }


  @override
  Future<Post> updatePost(Post updatedPost) async {
    await Future.delayed(const Duration(seconds: 1));
    final index = _fakePosts.indexWhere((p) => p.id == updatedPost.id);
    if (index != -1) {
      _fakePosts[index] = updatedPost;
      return updatedPost;
    } else {
      throw Exception('Post not found');
    }
  }

  @override
  Future<void> save(List<Post> posts) async{
    return;
  }

}