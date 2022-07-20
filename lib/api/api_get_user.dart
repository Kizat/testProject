import 'package:simple_getx_with_api/simple_getx_with_api.dart';
import 'package:test_project/api/settings.dart';
import 'package:test_project/models/user.dart';

class ApiGetUser extends Query<User> {
  ApiGetUser({required this.userId});

  final String userId;

  @override
  String get endPoint => '/users/$userId';

  @override
  Future<User?> onSuccess(
      {required body, Function(String error)? onDataError}) async {
    return User.fromJson(body);
  }

  @override
  QueryMethod get queryMethod => QueryMethod.getMethod;
}
