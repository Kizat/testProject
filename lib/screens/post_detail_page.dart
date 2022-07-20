import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/controllers/post_detail_controller.dart';
import 'package:test_project/services/strings.dart';
import 'package:test_project/widgets/add_comment.dart';
import 'package:test_project/widgets/error.dart';
import 'package:test_project/widgets/loading.dart';

class PostDetailPage extends StatelessWidget {
  PostDetailPage({
    required this.userId,
    required this.postId,
    Key? key,
  }) : super(key: key);

  final String userId;
  final String postId;

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostDetailsController>(
      init: PostDetailsController(userId: userId, postId: postId),
      builder: (postDetailsController) {
        return Scaffold(
          appBar: AppBar(),
          body: SafeArea(
            child: Builder(
              builder: (context) {
                if (postDetailsController.loading) {
                  return const CircularLoading();
                }
                if (postDetailsController.errorMessage != null) {
                  return ErrorMessage(
                    error: postDetailsController.errorMessage,
                    onRefresh: postDetailsController.fetchPost,
                  );
                }
                return Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  child: ListView(
                    padding: const EdgeInsets.all(8.0),
                    controller: scrollController,
                    children: [
                      post(context),
                      comments(context),
                      addComment(context),
                    ],
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget post(BuildContext context) {
    final postDetailsController = Get.find<PostDetailsController>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(postDetailsController.user!.name),
              subtitle: Text(postDetailsController.user!.email),
            ),
            ListTile(
              title: Text(
                postDetailsController.post!.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ListTile(
              title: Text(postDetailsController.post!.body),
            ),
          ],
        ),
      ),
    );
  }

  Widget comments(BuildContext context) {
    final postDetailsController = Get.find<PostDetailsController>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              Strings.comments,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8.0),
            ...List.generate(
              postDetailsController.comments?.length ?? 0,
              (index) {
                final comment = postDetailsController.comments![index];
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ListTile(
                        title: Text(comment.email),
                        subtitle: ListTile(
                          leading: const VerticalDivider(
                            thickness: 2.0,
                            width: 0.0,
                          ),
                          title: Text(comment.name),
                          subtitle: Text(comment.body),
                        )),
                    const Divider(),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget addComment(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
        onPressed: () => onAddComment(context),
        child: Center(child: Text(Strings.addComment)),
      ),
    );
  }

  onAddComment(BuildContext context) async {
    final postDetailsController = Get.find<PostDetailsController>();
    postDetailsController
        .addComment(await AddComment(postId: postId).show(context));
  }
}
