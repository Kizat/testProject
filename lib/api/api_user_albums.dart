import 'package:flutter/foundation.dart';
import 'package:simple_getx_with_api/simple_getx_with_api.dart';
import 'package:test_project/api/settings.dart';
import 'package:test_project/models/album.dart';

class ApiUserAlbums extends Query<List<Album>> {
  ApiUserAlbums({
    required this.userId,
  });

  final String userId;
  @override
  String get endPoint => '/users/1/albums';

  @override
  Future<List<Album>?> onSuccess(
      {required body, Function(String error)? onDataError}) async {
    return compute(albumFromJson, body);
  }

  @override
  QueryMethod get queryMethod => QueryMethod.getMethod;
}
