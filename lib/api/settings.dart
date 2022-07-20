import 'package:simple_getx_with_api/simple_getx_with_api.dart';

abstract class Query<T> extends QUERY<T> {

  @override
  String get host => 'https://jsonplaceholder.typicode.com';

  @override
  String handleError(int? statusCode, error) {
    String errorMessage = (error['text'] ?? error['message'] ?? error).toString();
    switch (statusCode) {
      case 400:
        return '$errorMessage\n\nAPI: "$endPoint"';
      case 404:
        return error["message"] ??
            error['text'] ??
            error + '\n\nAPI: "$endPoint"';
      case 500:
        return 'Внутренняя ошибка сервера\n\nAPI: "$endPoint"';
      default:
        return 'Упс! Что-то пошло не так\n\nAPI: "$endPoint"';
    }
  }

  @override
  String get dioErrorTypeOther => "Нет подключения в интернету";
}
