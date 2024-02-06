import 'package:cart_app/app/utils/key_constatnt.dart';
import 'package:cart_app/app/utils/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
}
