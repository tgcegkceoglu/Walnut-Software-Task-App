import 'package:flutter/material.dart';
import 'package:walnut_task_app/core/extensions/theme_extensions.dart';

class CustomMarkerWidget extends StatelessWidget {
  const CustomMarkerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 6,
      height: 6,
      decoration: BoxDecoration(
        color: context.secondaryColor,
        shape: BoxShape.circle,
      ),
    );
  }
}
