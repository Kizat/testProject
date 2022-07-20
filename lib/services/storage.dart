import 'dart:developer';

import 'package:get_storage/get_storage.dart';

class MainStorage {
  final box = GetStorage();

  dynamic getKey(String key) {
    return box.read(key);
  }

  setKey(String key, dynamic value, {Function? onSuccess}) {
    box.write(key, value);
    log("key was created");
    onSuccess?.call();
  }

  deleteKey(String key, {Function? onSuccess}) {
    box.remove(key);
    log("key was deleted");
    onSuccess?.call();
  }
}
