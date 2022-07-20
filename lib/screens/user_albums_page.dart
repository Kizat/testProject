import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/controllers/user_albums_controller.dart';
import 'package:test_project/routes/main_routes.dart';
import 'package:test_project/services/strings.dart';
import 'package:test_project/widgets/error.dart';
import 'package:test_project/widgets/loading.dart';

class UserAlbumsPage extends StatelessWidget {
  UserAlbumsPage(this.userId, {Key? key}) : super(key: key);

  final String userId;

  final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GetBuilder<UserAlbumsController>(
      init: UserAlbumsController(userId: userId),
      builder: (userAlbumsController) {
        return Scaffold(
          appBar: AppBar(
            title: Builder(builder: (context) {
              if (userAlbumsController.user?.name != null) {
                return RichText(
                  text: TextSpan(
                    text: userAlbumsController.user?.name ?? "",
                    children: [
                      TextSpan(
                        text: '\n${Strings.albums}',
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
            if (userAlbumsController.loading) {
              return const CircularLoading();
            }
            if (userAlbumsController.errorMessage != null) {
              return ErrorMessage(
                error: userAlbumsController.errorMessage,
                onRefresh: userAlbumsController.fetchUserAlbums,
              );
            }
            return posts();
          }),
        );
      },
    );
  }

  Widget posts() {
    final albumList = Get.find<UserAlbumsController>().albumList;
    return Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.all(8.0),
        itemCount: albumList?.length ?? 0,
        itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              onTap: () => MainRoutes.navigate(
                context: context,
                routeName: MainRoutes.albumDetail,
                arguments: "${albumList![index].id}",
              ),
              title: Text(
                albumList![index].title,
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
