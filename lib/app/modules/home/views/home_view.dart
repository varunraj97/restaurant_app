import 'package:cart_app/app/modules/home/views/widget/card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../auth_service.dart';
import '../../../routes/app_pages.dart';
import '../../../utils/ColorRes.dart';
import '../../../utils/helper_widget.dart';
import '../controllers/home_controller.dart';
import '../model/cart_model.dart';

class HomView extends StatefulWidget {
  const HomView({super.key});

  @override
  State<HomView> createState() => _HomViewState();
}

class _HomViewState extends State<HomView> {
  late HomeController controller;

  @override
  void initState() {
    controller = Get.put(HomeController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverLayoutBuilder(
                builder: (context, constraints) {
                  final scrolled = constraints.scrollOffset > 57;
                  return SliverAppBar(
                    elevation: 0,
                    backgroundColor: ColorRes.white,
                    scrolledUnderElevation: 0.0,
                    toolbarHeight: 57,
                    leading: Builder(
                      builder: (context) => IconButton(
                        icon: Icon(
                          Icons.menu,
                          color: ColorRes.grey,
                          size: 40,
                        ),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        tooltip: MaterialLocalizations.of(context)
                            .openAppDrawerTooltip,
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(Routes.CART_PAGE)!.then((value) {
                              if(value=='true'){
                                controller.reload();
                              }else if(value=='done'){
                                controller.reload2();
                              }
                            });
                          },
                          child: Stack(
                            children: [
                              Icon(
                                Icons.shopping_cart,
                                size: 35,
                                color: Colors.grey,
                              ),
                              Positioned(
                                bottom: 15,
                                right: 0,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: ColorRes.soldColor,
                                      borderRadius: BorderRadius.circular(50)),
                                  child: Center(
                                      child: Text(
                                    controller.cartList.length.toString(),
                                    style: TextStyle(color: ColorRes.white),
                                  )),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                    centerTitle: false,
                    pinned: true,
                    floating: true,
                    bottom: controller.isLoading.value
                        ? null
                        : TabBar(
                            labelColor: ColorRes.soldColor,
                            indicatorColor: ColorRes.soldColor,
                            controller: controller.tabController,
                            isScrollable: true,
                            tabAlignment: TabAlignment.start,
                            tabs: controller.restaurant!.tableMenuList!
                                .map((e) => Tab(text: e.menuCategory))
                                .toList(),
                          ),
                  );
                },
              )
            ];
          },
          body: controller.isLoading.value==true || controller.isListLoading.value==true
              ? const Center(
                  child: CircularProgressIndicator(
                  color: ColorRes.green,
                ))
              : MediaQuery.removePadding(
                  removeTop: true,
                  context: context,
                  removeBottom: true,
                  child: TabBarView(
                    controller: controller.tabController,
                    children: controller.restaurant!.tableMenuList!.map(
                      (e) {
                        return NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification is ScrollEndNotification) {
                              if (notification.metrics.pixels ==
                                  notification.metrics.maxScrollExtent) {
                                return true;
                              }
                            }
                            return true;
                          },
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.isLoadingMore.value == true
                                ? controller.cat.length + 1
                                : controller.cat.length,
                            itemBuilder: (context, index) {
                              if (index < controller.cat.length) {
                                return CardWidget(
                                  dishType: controller.cat[index].dishType,
                                  dishName: controller.cat[index].dishName,
                                  dishPrice: controller.cat[index].dishPrice
                                      .toString(),
                                  dishCalories: controller
                                      .cat[index].dishCalories
                                      .toString(),
                                  discription: controller
                                      .cat[index].dishDescription
                                      .toString(),
                                  image: controller.cat[index].dishImage
                                      .toString(),
                                  button: Container(
                                    height: 35,
                                    width: fullWidth(context) / 3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: ColorRes.green),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () async {
                                              decrementQty(
                                                  controller.cat[index]);
                                            },
                                            icon: const Icon(
                                              Icons.remove,
                                              color: ColorRes.white,
                                              size: 20,
                                            )),
                                        Text(
                                          controller.cat[index].count
                                              .toString(),
                                          style: const TextStyle(
                                              color: ColorRes.white,
                                              fontSize: 16),
                                        ),
                                        IconButton(
                                            onPressed: () async {
                                              incrementQty(
                                                  controller.cat[index]);
                                            },
                                            icon: const Icon(
                                              Icons.add,
                                              color: ColorRes.white,
                                              size: 20,
                                            ))
                                      ],
                                    ),
                                  ),
                                  isAvailable:
                                      controller.cat[index].addonCat!.isNotEmpty
                                          ? true
                                          : false,
                                );
                              } else {
                                return SizedBox(
                                  width: Get.width,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CircularPercentIndicator(
                                        radius: 35,
                                        percent: 0.3,
                                        progressColor: ColorRes.green,
                                        animationDuration: 50,
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                color: ColorRes.grey,
                              );
                            },
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            Container(
              height: 180,
              width: Get.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.green.shade700,
                      Colors.lightGreenAccent.shade700
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topRight,
                  ),
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        controller.url ??
                            "https://i0.wp.com/researchictafrica.net/wp/wp-content/uploads/2016/10/default-profile-pic.jpg?ssl=1",
                        width: 70,
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    controller.name == null ? controller.number! : controller.name!,
                    style: TextStyle(
                        fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("ID: 410")
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: (){
               controller.signOut();
               Scaffold.of(context).closeDrawer();
              },
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: const [
                    Icon(
                      Icons.logout,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      width: 35,
                    ),
                    Text(
                      "Log out",
                      style:
                      TextStyle(fontSize: 14, color: Colors.grey),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  incrementQty(CategoryDish dish) {
    if (dish.count! > -1) {
      setState(() {
        dish.count = dish.count! + 1;
        debugPrint(dish.count.toString());
      });
      // update();
      if (dish.count == 1) {
        setState(() {
          controller.addDish(dish);
        });
      }
      setState(() {
        controller.setQty(dish.count!, dish.dishId!);
      });
    }
  }

  decrementQty(CategoryDish dish) {
    if (dish.count! > 0) {
      setState(() {
        dish.count = dish.count! - 1;
      });

      controller.setQty(dish.count!, dish.dishId!);
      controller.update();
      if (dish.count == 0) {
        setState(() {
          controller.removeDish(dish);
        });
      }
    }
  }

}
