import 'package:flutter/material.dart';
import 'package:test_project/models/post_detail_argument.dart';
import 'package:test_project/screens/album_detail_page.dart';
import 'package:test_project/screens/post_detail_page.dart';
import 'package:test_project/screens/user_albums_page.dart';
import 'package:test_project/screens/user_detail_page.dart';
import 'package:test_project/screens/user_posts_page.dart';
import 'package:test_project/screens/users_page.dart';

class MainRoutes {
  //route names
  static const String users = "/";
  static const String userDetail = "/userDetail";
  static const String userPosts = "/posts";
  static const String userAlbums = "/albums";
  static const String postDetail = "/postDetail";
  static const String albumDetail = "/albumDetail";

// controller our page route flow
  static Route<dynamic> navigationController(RouteSettings settings) {
    switch (settings.name) {
      // case root:
      //   return MaterialPageRoute(builder: (context) => const Scaffold());
      case users:
        return MaterialPageRoute(builder: (context) => const UsersPage());
      case userDetail:
        return MaterialPageRoute(
          builder: (context) => UserDetialPage(
            settings.arguments as String,
          ),
        );
      case userPosts:
        return MaterialPageRoute(
          builder: (context) => UserPostsPage(
            settings.arguments as String,
          ),
        );
      case userAlbums:
        return MaterialPageRoute(
          builder: (context) => UserAlbumsPage(
            settings.arguments as String,
          ),
        );
      case postDetail:
        return MaterialPageRoute(
          builder: (context) {
            final PostDetailArgument postDetailArgument =
                settings.arguments as PostDetailArgument;
            return PostDetailPage(
              userId: postDetailArgument.userId,
              postId: postDetailArgument.postId,
            );
          },
        );
      case albumDetail:
        return MaterialPageRoute(
          builder: (context) => AlbumDetailPage(
            settings.arguments as String,
          ),
        );
      default:
        throw ("route error");
    }
  }

  static navigate(
      {required BuildContext context,
      Widget? widget,
      String? routeName,
      Object? arguments,
      bool rootNavigator = false}) async {
    if (routeName == null && widget != null) {
      return Navigator.of(
        context,
        rootNavigator: rootNavigator,
      ).push(MaterialPageRoute(builder: (context) => widget));
    } else {
      return Navigator.of(
        context,
        rootNavigator: rootNavigator,
      ).pushNamed(
        routeName!,
        arguments: arguments,
      );
    }
  }
}
