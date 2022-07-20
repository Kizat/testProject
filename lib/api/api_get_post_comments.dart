import 'package:flutter/foundation.dart';
import 'package:simple_getx_with_api/simple_getx_with_api.dart';
import 'package:test_project/api/settings.dart';
import 'package:test_project/models/comment.dart';

class ApiGetPostComments extends Query<List<Comment>> {
  ApiGetPostComments({
    required this.postId,
  });

  final String postId;
  @override
  String get endPoint => '/posts/1/comments';

  @override
  Future<List<Comment>> onSuccess(
      {required body, Function(String error)? onDataError}) async {
    return await compute(commentFromJson, body);
  }

  @override
  QueryMethod get queryMethod => QueryMethod.getMethod;
}
