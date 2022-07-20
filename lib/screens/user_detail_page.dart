import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/controllers/user_detail_controller.dart';
import 'package:test_project/routes/main_routes.dart';
import 'package:test_project/services/strings.dart';
import 'package:test_project/widgets/error.dart';
import 'package:test_project/widgets/loading.dart';

class UserDetialPage extends StatelessWidget {
  UserDetialPage(this.userId, {Key? key}) : super(key: key);

  final String userId;

  final ScrollController scrollController = ScrollController();

  final titleStyle = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 18.0,
  );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserDetailController>(
      init: UserDetailController(userId: userId),
      builder: (userDetailController) {
        return Scaffold(
          appBar: AppBar(
            title: Text(userDetailController.user?.username ?? ""),
          ),
          body: Builder(
            builder: (context) {
              if (userDetailController.loading) {
                return const CircularLoading();
              }
              if (userDetailController.errorMessage != null) {
                return ErrorMessage(
                  error: userDetailController.errorMessage,
                  onRefresh: userDetailController.fetchUser,
                );
              }
              return userInfo(context);
            },
          ),
        );
      },
    );
  }

  Widget userInfo(context) {
    return Scrollbar(
      controller: scrollController,
      thumbVisibility: true,
      child: ListView(
        controller: scrollController,
        padding: const EdgeInsets.all(8.0),
        children: [
          user(),
          userCompany(),
          userAddress(context),
          userPosts(context),
          userAlbums(context),
        ],
      ),
    );
  }

  Widget user() {
    final userDetailController = Get.find<UserDetailController>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              Strings.user,
              style: titleStyle,
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: Text(
                userDetailController.user?.name ?? "",
              ),
            ),
            ListTile(
              leading: const Icon(Icons.email),
              title: Text(
                userDetailController.user?.email ?? "",
              ),
            ),
            ListTile(
              leading: const Icon(Icons.phone),
              title: Text(
                userDetailController.user?.phone ?? "",
              ),
            ),
            ListTile(
              leading: const Icon(Icons.south_america_outlined),
              title: Text(
                userDetailController.user?.website ?? "",
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userCompany() {
    final userDetailController = Get.find<UserDetailController>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Builder(
          builder: (context) {
            final company = userDetailController.user?.company;
            return Column(
              children: [
                Text(
                  Strings.company,
                  style: titleStyle,
                ),
                ListTile(
                  leading: const Icon(Icons.corporate_fare),
                  title: Text(
                    company?.name ?? "",
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.badge_sharp),
                  title: Text(
                    company?.bs ?? "",
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.comment),
                  title: Text(
                    company?.catchPhrase ?? "",
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget userAddress(BuildContext context) {
    final UserDetailController userDetailController =
        Get.find<UserDetailController>();
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Builder(
          builder: (context) {
            final address = userDetailController.user?.address;
            return Column(
              children: [
                Text(
                  Strings.address,
                  style: titleStyle,
                ),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: Strings.city,
                        ),
                        TextSpan(
                          text: address?.city ?? "",
                        ),
                        const TextSpan(
                          text: ", ",
                        ),
                        TextSpan(
                          text: Strings.street,
                        ),
                        TextSpan(
                          text: address?.street ?? "",
                        ),
                        const TextSpan(
                          text: ", ",
                        ),
                        TextSpan(
                          text: address?.suite ?? "",
                        ),
                      ],
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }

  Widget userPosts(BuildContext context) {
    final userDetailController = Get.find<UserDetailController>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              Strings.posts,
              style: titleStyle,
            ),
            ...List.generate(
              userDetailController.postsLenght,
              (index) {
                return ListTile(
                  title: Text(
                    userDetailController.postList![index].title,
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => MainRoutes.navigate(
                  context: context,
                  routeName: MainRoutes.userPosts,
                  arguments: '${userDetailController.user?.id}',
                ),
                child: Text(Strings.more),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget userAlbums(BuildContext context) {
    final userDetailController = Get.find<UserDetailController>();
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              Strings.albums,
              style: titleStyle,
            ),
            ...List.generate(
              userDetailController.albumsLenght,
              (index) {
                return ListTile(
                  title: Text(
                    userDetailController.albumList![index].title,
                  ),
                );
              },
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => MainRoutes.navigate(
                  context: context,
                  routeName: MainRoutes.userAlbums,
                  arguments: '${userDetailController.user?.id}',
                ),
                child: Text(Strings.more),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
