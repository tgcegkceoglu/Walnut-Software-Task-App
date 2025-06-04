import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:walnut_task_app/core/extensions/theme_extensions.dart';

class ToastHelper {
  static final Toastification _toastification = Toastification();

  // Toast to show warning errors across the page 
  static void showToast(BuildContext context, String message, {ToastificationType type = ToastificationType.info}) {
    _toastification.show(
      context: context,
      title: Text(message,style: context.bodySmall.copyWith(color: context.whiteColor),),
      style: ToastificationStyle.fillColored,
      type: type,
      autoCloseDuration: const Duration(seconds: 3),
    );
  }
}
