import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../auth_service.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/common_function.dart';
import '../../../utils/helper_widget.dart';
import '../../../utils/key_constatnt.dart';
import '../../../utils/services.dart';
import '../model/cart_model.dart';
import '../providers/home_provider.dart';

class HomeController extends GetxController with GetSingleTickerProviderStateMixin {
  //TODO: Implement HomeController
  // GlobalStorageService storageService = Get.find<GlobalStorageService>();
  final count = 0.obs;
  RxBool isLoading = false.obs;
  RxBool isListLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxInt selectedIndex = 0.obs;
  Restaurant? restaurant;
  int selectedDishIndex = 0;
  int qty=0;
  List<CategoryDish> cartList = [];
  List<CategoryDish> cat = [];
  late TabController tabController;
  HomeProvider provider = Get.isRegistered<HomeProvider>()
      ? Get.find<HomeProvider>()
      : Get.put(HomeProvider());
  String? name = FirebaseAuth.instance.currentUser!.displayName;
  String? number = FirebaseAuth.instance.currentUser!.phoneNumber;
  String? id = FirebaseAuth.instance.currentUser!.tenantId;
  String? url = FirebaseAuth.instance.currentUser!.photoURL;
  @override
  void onInit() {
    initialLoad();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    tabController.dispose();
    super.onClose();
  }

  void increment() => count.value++;

  Future<void> initialLoad() async {
    isLoading.value = true;
    update();
    await fetchRestaurant();
    tabController = TabController(
      length: restaurant!.tableMenuList!.length,
      vsync: this,
    );
    tabController.animation?.addListener(() {
      // TAP //
      if (tabController.indexIsChanging) {
        // pageNo.value = 1;
        if (selectedIndex.value != tabController.index) {
          selectedIndex.value =int.parse(restaurant!.tableMenuList![0].menuCategoryId!);
          handleSwipe();
        }
        // SWIPE //
      } else {
        final int temp = tabController.animation!.value.round();
        if (selectedIndex.value != temp) {
          selectedIndex.value = temp;
          // this will make the tab bar animation to happen right away instead at the end of the swipe animation
          tabController.animateTo(selectedIndex.value);
          debugPrint(selectedIndex.value.toString());
          handleSwipe();
        }
      }
    });

    await getList(selectedIndex.value);
    isLoading.value = false;
    update();
  }

  handleSwipe() async {
    isListLoading.value = true;
    update();
    // categoryDishes.clear();
    await getList(selectedIndex.value);
    isListLoading.value = false;
    update();
  }

  void setDishIndex(index){
    index=selectedDishIndex;
    update();
  }

  clearCart(){
    cartList.clear();
    cat.clear();
    restaurant?.tableMenuList!.clear();
    update();
  }

  setQty(int quantity,String id){
    final index = cartList.indexWhere((element) => element.dishId == id);
    if(index>-1) {
      qty=cartList[index].count=quantity;
      cartList[index].total=cartList[index].dishPrice!*double.parse(quantity.toString());
      update();
    }


  }

  addDish(CategoryDish dish){
    cartList.add(dish);
    update();
  }

  removeDish(CategoryDish dish){
    cartList.remove(dish);
    update();
  }


  void setIndex(index){
    index=selectedIndex;
    update();
  }

  String grandTotal() {
    double grantTotal = 0;
    for (var e in cartList) {

      grantTotal += double.parse(e.total.toString());
    }
    return '$grantTotal';
  }


  Future<Restaurant?> fetchRestaurant() async {
    final data = await provider.fetchRestaurant();
    if (data != null) {
      restaurant=data;
      selectedIndex.value =int.parse(restaurant!.tableMenuList![0].menuCategoryId!);
      update();
    }
    return data;
  }

  reload()async{
    clearCart();
    isLoading.value =true;
    debugPrint( isLoading.value.toString());
    update();
    await fetchRestaurant();
    await getList(selectedIndex.value);
    isLoading.value =false;
    update();
  }
  reload2()async{
    isLoading.value =true;
    debugPrint( isLoading.value.toString());
    update();
    isLoading.value =false;
    update();
  }
  signOut()async{
    isLoading.value =true;
    update();
    // storageService.remove(StorageKeyConstants.tokenEmail);
    removeToken();
    AuthService().signOut();
    Get.offAllNamed(Routes.SIGN_UP);
    isLoading.value =false;
    update();
  }


  Future getList(int index) async {
    isListLoading.value = true;
    update();
    restaurant!.tableMenuList!.forEach((element) {
            if(element.menuCategoryId==index.toString()){
              cat.addAll(element.categoryDishes!);
            }
          });
    isListLoading.value = false;
    update();
  }



}
