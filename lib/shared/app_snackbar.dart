import 'package:flutter/material.dart';
import 'package:recipe/shared/app_text_style.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldKey =
    GlobalKey<ScaffoldMessengerState>();

class AppSnackBar {
  static void customSnackBar({required Widget child, required Color color}) {
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        backgroundColor: color,
        duration: const Duration(seconds: 5),
        content: child,
      ),
    );
  }

  static void close() {
    scaffoldKey.currentState?.clearSnackBars();
  }

  static void showCustomSnackbar(
      {required String message, bool isError = false}) {
    customSnackBar(
      color: isError ? Colors.red : Colors.green,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: isError ? Colors.red : Colors.green,
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Text(
                message,
                style: AppTextStyle.bold16.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                close();
              },
              child: Icon(
                Icons.close,
                color: isError ? Colors.red : Colors.green,
                size: 20,
              ),
            )
          ],
        ),
      ),
    );
  }

  static void showErrorCustomSnackbar({required String message}) {
    showCustomSnackbar(message: message, isError: true);
  }
}
