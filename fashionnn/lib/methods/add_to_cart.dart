import 'package:fashionnn/data/app_data.dart';
import 'package:fashionnn/model/base_model.dart';
import 'package:flutter/material.dart';
import 'package:advance_notification/advance_notification.dart';

class AddToCart {
  static void addToCart(BaseModel data, BuildContext context) {
    // this variable save a true or false value
    bool contains = itemsOnCart.contains(data);

    if (contains == true) {
      // if the data available already on the list
      const AdvanceSnackBar(
        textSize: 14.0,
        bgColor: Colors.red,
        message: 'You have added this item to cart before',
        mode: Mode.ADVANCE,
        duration: Duration(seconds: 5),
      ).show(context);
    } else {
      itemsOnCart.add(data);

      const AdvanceSnackBar(
        textSize: 14.0,
        bgColor: Colors.red,
        message: 'Successfully added to your cart',
        mode: Mode.ADVANCE,
        duration: Duration(seconds: 5),
      ).show(context);
    }
  }
}
