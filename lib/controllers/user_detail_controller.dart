import 'package:get/get.dart';
import 'package:test_project/api/api_get_user.dart';
import 'package:test_project/api/api_user_albums.dart';
import 'package:test_project/api/api_user_posts.dart';
import 'package:test_project/models/album.dart';
import 'package:test_project/models/post.dart';
import 'package:test_project/models/user.dart';

class UserDetailController extends GetxController {
  UserDetailController({
    required this.userId,
  });

  final String userId;

  bool loading = false;

  String? errorMessage;

  User? user;

  List<Post>? postList;

  List<Album>? albumList;

  int get postsLenght {
    if (postList == null) {
      return 0;
    }
    if (postList!.length > 3) {
      return 3;
    }
    return postList!.length;
  }

  int get albumsLenght {
    if (albumList == null) {
      return 0;
    }
    if (albumList!.length > 3) {
      return 3;
    }
    return albumList!.length;
  }

  Future fetchUser() async {
    loading = true;
    errorMessage = null;
    update();
    String? errorUser;
    String? errorPosts;
    String? errorAlbums;
    await ApiGetUser(userId: userId).request(
      onSuccess: (data) => user = data,
      onError: (error) => errorUser = error,
    );
    await ApiUserPosts(userId: userId).request(
      onSuccess: (data) => postList = data,
      onError: (error) => errorPosts = error,
    );
    await ApiUserAlbums(userId: userId).request(
      onSuccess: (data) => albumList = data,
      onError: (error) => errorAlbums = error,
    );
    if (errorUser != null) {
      errorMessage = errorUser;
    }
    if (errorPosts != null) {
      errorMessage = (errorMessage ?? "") + errorPosts!;
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
    fetchUser();
  }
}
