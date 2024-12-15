import './remote_data.dart';
import '../model/post.dart';


abstract class LocalPostData extends RemotePostData {

  Future<void> save(List<Post> posts);

}