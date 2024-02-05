import 'package:get/get.dart';

import '../model/cart_model.dart';

class HomeProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl ='https://run.mocky.io/v3/';
    httpClient.defaultContentType = 'application/json';
    httpClient.maxAuthRetries = 3;
    httpClient.timeout = const Duration(seconds: 60);
    // var headers = {
    //   'Authorization': "Bearer ${getAccessToken()}"};
    // httpClient.addRequestModifier<dynamic>((request) {
    //   request.headers.addAll(headers);
    //   return request;
    // });
    httpClient.addRequestModifier<dynamic>((request) async => request);
  }

  // Future<Response> getHomeData() =>get("4d116e3e-808c-43ab-93ed-6c70540d4e18");
  Future<Restaurant?> fetchRestaurant() async {
    try {
      final response = await get("4d116e3e-808c-43ab-93ed-6c70540d4e18");

      if (response != null) {
        return Restaurant.convertToList(response.body)[0];
      }
      return null;
    } catch (err) {
      print("Fetching  error: $err");

      return null;
    }
  }
}
