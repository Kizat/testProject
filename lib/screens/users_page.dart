import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_project/controllers/users_controller.dart';
import 'package:test_project/models/user.dart';
import 'package:test_project/routes/main_routes.dart';
import 'package:test_project/services/strings.dart';
import 'package:test_project/widgets/error.dart';
import 'package:test_project/widgets/loading.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UsersController>(
      init: UsersController(),
      builder: (usersController) {
        return Scaffold(
          appBar: AppBar(
            title: Text(Strings.userList),
          ),
          body: Builder(
            builder: (context) {
              if (usersController.loading && usersController.userList != null) {
                return Column(
                  children: [
                    const LinearProgressIndicator(),
                    Expanded(
                      child: userTiles(context, usersController.userList!),
                    )
                  ],
                );
              }
              if (usersController.loading) {
                return const CircularLoading();
              }
              if (usersController.errorMessage != null) {
                return ErrorMessage(
                  error: usersController.errorMessage,
                  onRefresh: usersController.fetchUserList,
                );
              }
              final users = usersController.userList ?? [];
              return RefreshIndicator(
                onRefresh: () => usersController.fetchUserList(),
                child: userTiles(context, users),
              );
            },
          ),
        );
      },
    );
  }

  Widget userTiles(BuildContext context, List<User> users) {
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          child: ListTile(
            onTap: () => MainRoutes.navigate(
              context: context,
              routeName: '/userDetail',
              arguments: '${user.id}',
            ),
            title: Text(user.username),
            subtitle: Text(user.name),
          ),
        );
      },
    );
  }
}
