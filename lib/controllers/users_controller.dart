import 'dart:convert';

import 'package:get/get.dart';
import 'package:test_project/api/api_users.dart';
import 'package:test_project/models/user.dart';
import 'package:test_project/services/storage.dart';

class UsersController extends GetxController {
  bool loading = false;

  List<User>? userList;

  String? errorMessage;

  Future fetchUserList() async {
    loading = true;
    errorMessage = null;
    update();
    await ApiUsers().request(
      onSuccess: (data) {
        userList = data;
        if (userList != null) {
          MainStorage().setKey(
            "users",
            userToJson(userList!),
          );
        }
      },
      onError: (error) {
        errorMessage = error;
      },
    );
    loading = false;
    update();
  }

  @override
  void onInit() async {
    super.onInit();
    final usersCache = await MainStorage().getKey("users");
    if (usersCache != null) {
      userList = userFromJson(jsonDecode(usersCache));
    }
    await fetchUserList();
  }
}
