import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/controllers/user_posts_controller.dart';
import 'package:test_project/models/post_detail_argument.dart';
import 'package:test_project/routes/main_routes.dart';
import 'package:test_project/services/strings.dart';
import 'package:test_project/widgets/error.dart';
import 'package:test_project/widgets/loading.dart';

class UserPostsPage extends StatelessWidget {
  UserPostsPage(this.userId, {Key? key}) : super(key: key);

  final String userId;

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder<UserPostsController>(
      init: UserPostsController(userId: userId),
      builder: (userPostsController) {
        return Scaffold(
          appBar: AppBar(
            title: Builder(builder: (context) {
              if (userPostsController.user?.name != null) {
                return RichText(
                  text: TextSpan(
                    text: userPostsController.user?.name ?? "",
                    children: [
                      TextSpan(
                        text: '\n${Strings.posts}',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          color: theme.colorScheme.onPrimary,
                        ),
                      ),
                    ],
                  ),
                );
              }
              return Container();
            }),
          ),
          body: Builder(builder: (context) {
            if (userPostsController.loading) {
              return const CircularLoading();
            }
            if (userPostsController.errorMessage != null) {
              return ErrorMessage(
                error: userPostsController.errorMessage,
                onRefresh: userPostsController.fetchUserPosts,
              );
            }
            return posts();
          }),
        );
      },
    );
  }

  Widget posts() {
    final postList = Get.find<UserPostsController>().postList;
    return Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.all(8.0),
        itemCount: postList?.length ?? 0,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () => MainRoutes.navigate(
                context: context,
                routeName: MainRoutes.postDetail,
                arguments: PostDetailArgument(
                  userId,
                  '${postList![index].id}',
                ),
              ),
              title: Text(
                postList![index].title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              subtitle: Text(
                postList[index].body,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          );
        },
      ),
    );
  }
}
