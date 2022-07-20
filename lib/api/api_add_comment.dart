import 'package:simple_getx_with_api/simple_getx_with_api.dart';
import 'package:test_project/api/settings.dart';
import 'package:test_project/models/add_comment_model.dart';
import 'package:test_project/models/comment.dart';

class ApiAddComment extends Query<Comment> {
  ApiAddComment({
    required this.postId,
    required this.addCommentModel,
  });

  final String postId;
  final AddCommentModel addCommentModel;

  @override
  String get endPoint => '/posts/$postId/comments';

  @override
  Future<Comment?> onSuccess(
      {required body, Function(String error)? onDataError}) async {
    return Comment.fromJson(body);
  }

  @override
  get body => {
        "postId": int.parse(postId),
        "name": addCommentModel.name,
        "email": addCommentModel.email,
        "body": addCommentModel.comment,
      };

  @override
  QueryMethod get queryMethod => QueryMethod.postMethod;
}
