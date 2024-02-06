import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'key_constatnt.dart';

class GlobalStorageService extends GetxService {
  Future<GlobalStorageService> init() async {
    await GetStorage.init(StorageKeyConstants.GLOBAL_STORAGE_BOX);
    return this;
  }

  void write(String key, dynamic value) async {
    await GetStorage(StorageKeyConstants.GLOBAL_STORAGE_BOX).write(key, value);
  }

  String? read(String key) {
    return GetStorage(StorageKeyConstants.GLOBAL_STORAGE_BOX).read(key);
  }

  void remove(String key) async {
    await GetStorage(StorageKeyConstants.GLOBAL_STORAGE_BOX).remove(key);
  }
  void eraseStorage() async {
    await GetStorage(StorageKeyConstants.GLOBAL_STORAGE_BOX).erase();
  }
}
