import 'package:cart_app/app/utils/services.dart';
import 'package:get/get.dart';

import 'key_constatnt.dart';

GlobalStorageService storageService = Get.find<GlobalStorageService>();

setToken(String token) {
  storageService.write(StorageKeyConstants.tokenEmail,token);
}
setSetup() {
  storageService.write(StorageKeyConstants.BASE_URL,'0');
}
String? getToken() {
 return storageService.read(StorageKeyConstants.tokenEmail);
}
 removeToken() {
  storageService.remove(StorageKeyConstants.tokenEmail);
}
