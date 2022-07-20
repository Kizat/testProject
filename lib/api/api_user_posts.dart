import 'package:flutter/foundation.dart';
import 'package:simple_getx_with_api/simple_getx_with_api.dart';
import 'package:test_project/api/settings.dart';
import 'package:test_project/models/post.dart';

class ApiUserPosts extends Query<List<Post>> {
  ApiUserPosts({required this.userId});

  final String userId;

  @override
  String get endPoint => '/users/$userId/posts';

  @override
  Future<List<Post>> onSuccess(
      {required body, Function(String error)? onDataError}) async {
    return await compute(postFromJson, body);
  }

  @override
  QueryMethod get queryMethod => QueryMethod.getMethod;
}
