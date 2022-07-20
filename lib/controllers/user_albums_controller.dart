import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:test_project/api/api_get_user.dart';
import 'package:test_project/api/api_user_albums.dart';
import 'package:test_project/models/album.dart';
import 'package:test_project/models/user.dart';

class UserAlbumsController extends GetxController {
  UserAlbumsController({
    required this.userId,
  });

  final String userId;

  bool loading = false;

  String? errorMessage;

  User? user;

  List<Album>? albumList;

  Future fetchUserAlbums() async {
    loading = true;
    errorMessage = null;
    update();
    String? errorUser;
    String? errorAlbums;
    await ApiGetUser(userId: userId).request(
      onSuccess: (data) => user = data,
      onError: (error) => errorUser = error,
    );
    await ApiUserAlbums(userId: userId).request(
      onSuccess: (data) => albumList = data,
      onError: (error) => errorAlbums = error,
    );
    if (errorUser != null) {
      errorMessage = errorUser;
    }
    if (errorAlbums != null) {
      errorMessage = (errorMessage ?? "") + errorAlbums!;
    }
    loading = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserAlbums();
  }
}
