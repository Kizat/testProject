import 'package:flutter/foundation.dart';
import 'package:simple_getx_with_api/simple_getx_with_api.dart';
import 'package:test_project/api/settings.dart';
import 'package:test_project/models/user.dart';

class ApiUsers extends Query<List<User>> {
  @override
  String get endPoint => '/users';

  @override
  Future<List<User>> onSuccess(
      {required body, Function(String error)? onDataError}) async {
    return await compute(userFromJson, body);
  }

  @override
  QueryMethod get queryMethod => QueryMethod.getMethod;
}
