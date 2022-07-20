import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:test_project/api/api_get_album.dart';
import 'package:test_project/api/api_get_photos.dart';
import 'package:test_project/models/album.dart';
import 'package:test_project/models/photo.dart';

class AlbumDetailsController extends GetxController {
  AlbumDetailsController({
    required this.albumId,
  });

  final String albumId;

  bool loading = false;

  String? errorMessage;

  Album? album;

  List<Photo>? photos;

  Future fetchPost() async {
    loading = true;
    errorMessage = null;
    update();
    String? errorUser, errorAlbums, errorPhotos;
    await ApiGetAlbum(albumId: albumId).request(
      onSuccess: (data) => album = data,
      onError: (error) => errorAlbums = error,
    );
    await ApiGetPhotos(albumId: albumId).request(
      onSuccess: (data) => photos = data,
      onError: (error) => errorMessage = errorPhotos = error,
    );
    if (errorUser != null) {
      errorMessage = errorUser;
    }
    if (errorAlbums != null) {
      errorMessage = (errorMessage ?? "") + errorAlbums!;
    }
    if (errorPhotos != null) {
      errorMessage = (errorMessage ?? "") + errorPhotos!;
    }
    loading = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchPost();
  }
}
