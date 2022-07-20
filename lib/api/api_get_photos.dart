import 'package:flutter/foundation.dart';
import 'package:simple_getx_with_api/simple_getx_with_api.dart';
import 'package:test_project/api/settings.dart';
import 'package:test_project/models/photo.dart';

class ApiGetPhotos extends Query<List<Photo>> {
  ApiGetPhotos({required this.albumId});

  final String albumId;

  @override
  String get endPoint => '/albums/$albumId/photos';

  @override
  Future<List<Photo>?> onSuccess(
      {required body, Function(String error)? onDataError}) async {
    return await compute(photoFromJson, body);
  }

  @override
  QueryMethod get queryMethod => QueryMethod.getMethod;
}
