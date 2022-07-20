import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:test_project/api/api_get_user.dart';
import 'package:test_project/api/api_user_posts.dart';
import 'package:test_project/models/post.dart';
import 'package:test_project/models/user.dart';

class UserPostsController extends GetxController {
  UserPostsController({
    required this.userId,
  });

  final String userId;

  bool loading = false;

  String? errorMessage;

  User? user;

  List<Post>? postList;

  Future fetchUserPosts() async {
    loading = true;
    errorMessage = null;
    update();
    String? errorUser;
    String? errorPosts;
    await ApiGetUser(userId: userId).request(
      onSuccess: (data) => user = data,
      onError: (error) => errorUser = error,
    );
    await ApiUserPosts(userId: userId).request(
      onSuccess: (data) => postList = data,
      onError: (error) => errorPosts = error,
    );
    if (errorUser != null) {
      errorMessage = errorUser;
    }
    if (errorPosts != null) {
      errorMessage = (errorMessage ?? "") + errorPosts!;
    }
    loading = false;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchUserPosts();
  }
}
