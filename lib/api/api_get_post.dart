import 'package:simple_getx_with_api/simple_getx_with_api.dart';
import 'package:test_project/api/settings.dart';
import 'package:test_project/models/post.dart';

class ApiGetPost extends Query<Post> {
  ApiGetPost({required this.postId});

  final String postId;

  @override
  String get endPoint => '/posts/$postId';

  @override
  Future<Post?> onSuccess(
      {required body, Function(String error)? onDataError}) async {
    return Post.fromJson(body);
  }

  @override
  QueryMethod get queryMethod => QueryMethod.getMethod;
}
