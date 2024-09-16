import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class FlushMessage {
  static errorFlushMessage(BuildContext context, String message) {
    return Flushbar(
      title: "Error",
      titleSize: 18,

      messageText: Text(message,
          style: const TextStyle(color: Colors.white, fontSize: 15)),
      backgroundColor: const Color.fromARGB(255, 217, 120, 113),
      borderRadius: BorderRadius.zero,
      flushbarPosition: FlushbarPosition.TOP,
      shouldIconPulse: false,
      duration: const Duration(seconds: 2),
      icon: const Icon(
        Icons.error,
        color: Colors.white,
        size: 25,
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      // textDirection: TextDirection.ltr,
    ).show(context);
  }

  static successFlushMessage(BuildContext context, String message) {
    return Flushbar(
      title: "Successfull",
      titleSize: 18,

      messageText: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 15),
      ),
      backgroundColor: const Color.fromARGB(255, 120, 210, 125),
      flushbarPosition: FlushbarPosition.TOP,
      borderRadius: BorderRadius.zero,
      duration: const Duration(seconds: 2),
      icon: const Icon(
        Icons.check_outlined,
        color: Colors.white,
        size: 25,
      ),
      shouldIconPulse: false,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      // textDirection: TextDirection.ltr,
    ).show(context);
  }
}
