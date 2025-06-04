import 'package:flutter/material.dart';
import 'package:walnut_task_app/core/extensions/theme_extensions.dart';
import 'package:walnut_task_app/product/constants/padding_constants.dart';

class CustomButtonWidget extends StatelessWidget {
  final String text;
  final double? width;
  final Alignment? alignment;
  final Function() onPressed;
  const CustomButtonWidget({super.key, required this.text, required this.onPressed,this.width,this.alignment});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      alignment: alignment,
      padding: PaddingConstants.zero,
      constraints: const BoxConstraints(),
      onPressed: onPressed,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      color: Colors.transparent,
      focusColor: Colors.transparent,
      disabledColor: Colors.transparent,
      style: const ButtonStyle(splashFactory: NoSplash.splashFactory),
      icon: Container(
        padding: PaddingConstants.pageAllNormal,
        width: width,
        decoration: BoxDecoration(
          color: context.secondaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(text,style: context.bodyMedium.copyWith(color: context.whiteColor),textAlign: TextAlign.center,),
      ),
    );
  }
}
