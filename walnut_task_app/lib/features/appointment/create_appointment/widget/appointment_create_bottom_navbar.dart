import 'package:flutter/material.dart';
import 'package:walnut_task_app/core/extensions/theme_extensions.dart';
import 'package:walnut_task_app/product/widgets/custom_button_widget.dart';

class AppointmentCreateBottomNavBar extends StatelessWidget {
  final int currentPage;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onConfirm;

  const AppointmentCreateBottomNavBar({
    super.key,
    required this.currentPage,
    required this.onNext,
    required this.onBack,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    bool isFirstPage = currentPage == 0;
    return BottomAppBar(
      color: context.transparent,
      child: Row(
        mainAxisAlignment: isFirstPage
            ? MainAxisAlignment.end
            : MainAxisAlignment.spaceBetween,

        children: [
          if (!isFirstPage) CustomButtonWidget(text: "BACK", onPressed: onBack),
          CustomButtonWidget(
            text: isFirstPage ? "CONTINUE" : "CONFIRM",
            onPressed: isFirstPage ? onNext : onConfirm,
          ),
        ],
      ),
    );
  }
}
