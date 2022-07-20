import 'package:simple_getx_with_api/simple_getx_with_api.dart';
import 'package:test_project/api/settings.dart';
import 'package:test_project/models/album.dart';

class ApiGetAlbum extends Query<Album> {
  ApiGetAlbum({required this.albumId});

  final String albumId;

  @override
  String get endPoint => '/albums/$albumId';

  @override
  Future<Album?> onSuccess(
      {required body, Function(String error)? onDataError}) async {
    return Album.fromJson(body);
  }

  @override
  QueryMethod get queryMethod => QueryMethod.getMethod;
}
