import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:flutter/material.dart';

class FlushBarHelper {
  static void flushBarErrorMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        duration: Duration(seconds: 2),
        borderRadius: BorderRadius.circular(10),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.red,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: Icon(Icons.error, size: 28, color: Colors.white),
      )..show(context),
    );
  }

  static void flushBarSuccessMessage(String message, BuildContext context) {
    showFlushbar(
      context: context,
      flushbar: Flushbar(
        forwardAnimationCurve: Curves.decelerate,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        padding: const EdgeInsets.all(15),
        message: message,
        duration: Duration(seconds: 2),
        borderRadius: BorderRadius.circular(10),
        flushbarPosition: FlushbarPosition.TOP,
        backgroundColor: Colors.green,
        reverseAnimationCurve: Curves.easeInOut,
        positionOffset: 20,
        icon: Icon(Icons.check_box, size: 28, color: Colors.white),
      )..show(context),
    );
  }
}
