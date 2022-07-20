import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:test_project/api/api_add_comment.dart';
import 'package:test_project/api/api_get_post.dart';
import 'package:test_project/api/api_get_post_comments.dart';
import 'package:test_project/api/api_get_user.dart';
import 'package:test_project/models/add_comment_model.dart';
import 'package:test_project/models/comment.dart';
import 'package:test_project/models/post.dart';
import 'package:test_project/models/user.dart';

class PostDetailsController extends GetxController {
  PostDetailsController({
    required this.userId,
    required this.postId,
  });

  final String userId;
  final String postId;

  bool loading = false;

  String? errorMessage;

  User? user;

  Post? post;

  List<Comment>? comments;

  Future fetchPost() async {
    loading = true;
    errorMessage = null;
    update();
    String? errorUser, errorPost, errorComments;
    await ApiGetUser(userId: userId).request(
      onSuccess: (data) => user = data,
      onError: (error) => errorUser = error,
    );
    await ApiGetPost(postId: postId).request(
      onSuccess: (data) => post = data,
      onError: (error) => errorPost = error,
    );
    await ApiGetPostComments(postId: postId).request(
      onSuccess: (data) => comments = data,
      onError: (error) => errorMessage = errorComments = error,
    );

    if (errorUser != null) {
      errorMessage = errorUser;
    }
    if (errorPost != null) {
      errorMessage = (errorMessage ?? "") + errorPost!;
    }
    if (errorComments != null) {
      errorMessage = (errorMessage ?? "") + errorComments!;
    }
    loading = false;
    update();
  }

  Future addComment(AddCommentModel? addCommentModel) async {
    if (addCommentModel != null) {
      loading = true;
      errorMessage = null;
      update();
      await ApiAddComment(postId: postId, addCommentModel: addCommentModel)
          .request(
        onSuccess: (data) {
          if (data != null) {
            comments?.insert(0, data);
          }
        },
        onError: (error) => errorMessage = error,
      );
      loading = false;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchPost();
  }
}
