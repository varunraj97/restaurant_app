import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../utils/ColorRes.dart';
import '../../../../utils/helper_widget.dart';

class CardWidget extends StatelessWidget {
  int? dishType;
  String? dishName;
  String? dishPrice;
  String? dishCalories;
  String? discription;
  String? image;
  Widget? button;
  bool? isAvailable;
   CardWidget(
      {this.dishType,
        this.dishName,
        this.dishPrice,
        this.dishCalories,
        this.discription,
        this.image,
        this.button,
        this.isAvailable,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20,left: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    dishType== 2?
                    Image.asset(
                      "assets/icons/veg.png",
                      width: 20,
                    ) :
                    Image.asset(
                      "assets/icons/nonveg.png",
                      width: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    SizedBox(
                      width: fullWidth(context) / 2,
                      child: Text(
                        dishName!,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width:  fullWidth(context) / 1.5,
                  padding:
                  const EdgeInsets.only(left: 25, right: 10),
                  child: Row(
                    children: [
                      Text("INR $dishPrice", style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
                      const Spacer(),
                      Text(
                        "$dishCalories calories",
                        style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black),
                      ),
            
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    padding: const EdgeInsets.only(left: 25),
                    width:  fullWidth(context) / 1.5,
                    child: Text(
                      discription!,
                      style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey.shade500),
                    )),
                const SizedBox(
                  height: 10,
                ),
            
                Padding(
                  padding: const EdgeInsets.only(left: 25),
                  child: button,
                ),
                const SizedBox(
                  height: 10,
                ),
                isAvailable==true
                    ?
                const Padding(
                  padding: EdgeInsets.only(left: 25),
                  child: Text(
                    "Customizations Available",
                    style: TextStyle(
                        color: ColorRes.soldColor,
                        fontSize: 14),
                  ),
                )
                    : Container()
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                //   CachedNetworkImage(
                //     imageUrl:image!,
                //     placeholder: (context, url) =>
                //     const CircularProgressIndicator(),
                //     errorWidget: (context, url, error) => Center(child: new Icon(Icons.error)),
                //     width: 100,
                //   ),
                // ]
              Image.network(image!,width: 100,)],
            ),
          )
        ],
      ),
    );
  }
}
