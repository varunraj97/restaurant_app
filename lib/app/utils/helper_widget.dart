import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'ColorRes.dart';

double fullWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double fullHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

showToast(BuildContext context,String Message) {
  final snackbar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: ColorRes.white,
    content: Row(
      children: [
        Expanded(
          child: Text(
            Message,
            style: TextStyle(
              color:ColorRes.soldColor
            ),
          ),
        ),
      ],
    ),
    showCloseIcon: true,
    closeIconColor: ColorRes.red,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
      side: BorderSide(
        color: ColorRes.red,
        width: 1.0,
      ),
    ),
    padding: const EdgeInsets.symmetric(
      vertical: 10,
      horizontal: 10,
    ),
    clipBehavior: Clip.antiAliasWithSaveLayer,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackbar);
  // return Get.snackbar(
  //   '',
  //   message,
  //   backgroundColor: type == true
  //       ? AppColor.snackSuccessBackgroundColor
  //       : AppColor.snackErrorBackgroundColor,
  //   borderWidth: 1.0,
  //   borderColor: type == true
  //       ? AppColor.snackSuccessBorderColor
  //       : AppColor.snackErrorBorderColor,
  //   snackPosition: SnackPosition.BOTTOM,
  //   snackStyle: SnackStyle.FLOATING,
  //   animationDuration: const Duration(
  //     milliseconds: 500,
  //   ),
  //   borderRadius: 4.r,
  //   margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  //   padding: const EdgeInsets.only(bottom: 18),
  //   icon: SvgIcon(
  //     iconName: type == true ? 'success' : 'error',
  //     height: 24.h,
  //     width: 24.w,
  //   ),
  //   messageText: Padding(
  //     padding: const EdgeInsets.only(bottom: 15),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //       children: [
  //         Text(
  //           message,
  //           style: textWith14FontW400(
  //             type == true ? AppColor.mainTextColor2 : AppColor.errorColor,
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(right: 10),
  //           child: GestureDetector(
  //             onTap: () {
  //               Get.back();
  //             },
  //             child: Icon(
  //               Icons.close,
  //               color: type == true
  //                   ? AppColor.snackSuccessBorderColor
  //                   : AppColor.snackErrorBorderColor,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   ),
  // );
}