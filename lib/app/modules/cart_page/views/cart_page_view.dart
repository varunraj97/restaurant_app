import 'package:cart_app/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../utils/ColorRes.dart';
import '../../../utils/helper_widget.dart';
import '../../home/model/cart_model.dart';
import '../controllers/cart_page_controller.dart';

class CartPageView extends GetView<CartPageController> {
  const CartPageView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorRes.white,
        leading: IconButton(
          onPressed: () async{
            Get.back(result:'done');
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.grey,
          ),
        ),
        title: const Text(
          "Order Summary",
          style: TextStyle(color: Colors.grey, fontSize: 18),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            GestureDetector(
              onTap: (){
                Get.back(result:'true');
              },
              child: Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                height: 50,
                width: fullWidth(context),
                decoration: BoxDecoration(
                    color: Colors.green.shade900,
                    borderRadius: BorderRadius.circular(50)),
                child: const Center(
                  child: Text(
                    "Place Order",
                    style: TextStyle(fontSize: 20, color: ColorRes.white),
                  ),
                ),
              ),
            ),
            const Divider(
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
          ],
        ),
      ),

      body:  OrderSummaryItem(homeController:controller.homeController),
    );
  }
}
class OrderSummaryItem extends StatefulWidget {
  HomeController? homeController;
   OrderSummaryItem({this.homeController,
    Key? key,}) : super(key: key);

  @override
  State<OrderSummaryItem> createState() => _OrderSummaryItemState();
}

class _OrderSummaryItemState extends State<OrderSummaryItem> {
  double total = 0;
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(5),
                  height: 50,
                  width: fullWidth(context),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.green.shade900),
                  child:   Center(
                            child: Text(
                              "${widget.homeController!.cartList.length}-Dishes ${widget.homeController!.qty}-Items",
                              style: const TextStyle(fontSize: 16, color: ColorRes.white),
                            )
                  ),
                ),
                const SizedBox(height: 20),
                 Card(
                        child: Column(
                          children: widget.homeController!.cartList.map((e) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/icons/veg.png",
                                  width: 20,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: fullWidth(context) / 5,
                                      child: Text(
                                        e.dishName!,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "INR ${e.dishPrice}",
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${e.dishCalories}calories",
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black54),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: Container(
                                    height: 35,
                                    width: fullWidth(context) / 3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.green.shade900),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                            onPressed: () async{
                                              await decrementQty(e);
                                            },
                                            icon: const Icon(
                                              Icons.remove,
                                              color: ColorRes.white,
                                              size: 20,
                                            )),
                                        Text(
                                          e.count.toString(),
                                          style:
                                          const TextStyle(color: ColorRes.white, fontSize: 16),
                                        ),
                                        IconButton(
                                            onPressed: () async{
                                              await incrementQty(e);
                                            },
                                            icon: const Icon(
                                              Icons.add,
                                              color:ColorRes.white,
                                              size: 20,
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                                Text(
                                  "INR ${e.total.toString()}",
                                  style: const TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w400),
                                ),
                              ],
                            ),
                          )).toList(),
                        ),
                ),

                const Divider(
                  color: Colors.grey,
                  indent: 10,
                  endIndent: 10,
                ),

                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child:  Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children:  [
                            const Text(
                              "Total Amount",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                            Text(
                              "INR ${widget.homeController!.grandTotal()}",
                              style: const TextStyle(color: Colors.green, fontSize: 15),
                            )
                          ],
                  ),
                ),



              ],
            ),
          ),
        ],
      );
  }

  incrementQty(CategoryDish dish){
    if(dish.count!>0){
      setState(() {
        dish.count=dish.count!+1;
      });

      if(dish.count==1){
        widget.homeController!.addDish(dish);

      }
      widget.homeController!.setQty(dish.count!,dish.dishId!);

    }
  }

  decrementQty(CategoryDish dish){
    if(dish.count!>0){
      setState(() {
        dish.count=dish.count!-1;
      });
      widget.homeController!.setQty(dish.count!,dish.dishId!);
      if(dish.count==0) {
        widget.homeController!.removeDish(dish);
      }
    }
  }


}