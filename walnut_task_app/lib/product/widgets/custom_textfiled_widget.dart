import 'package:flutter/material.dart';
import 'package:walnut_task_app/core/extensions/theme_extensions.dart';
import 'package:walnut_task_app/product/constants/padding_constants.dart';

class CustomTextFieldWidget extends StatefulWidget {
  const CustomTextFieldWidget({
    super.key,
    required this.controller,
    this.hintText,
    this.maxLines,
    this.icon,
    this.onIconTap,
    this.readOnly = false,
    this.inputType,
    this.isPassword = false,
  });

  final String? hintText;
  final int? maxLines;
  final TextEditingController controller;
  final IconData? icon;
  final VoidCallback? onIconTap;
  final bool readOnly;
  final TextInputType? inputType;
  final bool isPassword;

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: PaddingConstants.pageAllNormal,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: context.grey),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: widget.controller,
              readOnly: widget.readOnly,
              obscureText: _obscureText,
              keyboardType: widget.inputType,
              onTapOutside: (_) => FocusScope.of(context).unfocus(),
              onChanged: (val) {
                widget.controller.text = val;
                setState(() {});
              },
              maxLines: _obscureText ? 1 :  widget.maxLines,
              textAlignVertical: TextAlignVertical.top,
              cursorColor: context.blackColor,
              style: context.bodyMedium,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: PaddingConstants.zero,
                border: InputBorder.none,
                hintText: widget.hintText,
                hintStyle: context.bodySmall,
              ),
            ),
          ),
          if (widget.icon != null)
            IconButton(
              icon: Icon(widget.icon, color: context.grey),
              onPressed: widget.onIconTap,
            ),
        ],
      ),
    );
  }
}
