import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:new_setup/core/core.dart';

class AppInputField extends StatefulWidget {
  const AppInputField({
    super.key,
    required this.title,
    this.compulsoryField = false,
    this.passwordField = false,
    this.onChanged,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.hintText = "",
    this.icon,
    this.controller,
  });
  final String title;

  final bool compulsoryField;

  final bool passwordField;

  final void Function(String)? onChanged;

  final TextInputType? keyboardType;

  final List<TextInputFormatter>? inputFormatters;

  final String? Function(String?)? validator;

  final String hintText;

  final IconData? icon;

  final TextEditingController? controller;

  @override
  State<AppInputField> createState() => _AppInputFieldState();
}

class _AppInputFieldState extends State<AppInputField> {
  bool isHidden = true;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(widget.title, style: context.textTheme.bodyMedium),
            widget.compulsoryField
                ? Text(
                    "*",
                    style: context.textTheme.bodyMedium!.copyWith(
                      color: AppColors.primary,
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
        TextFormField(
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus!.unfocus();
          },
          controller: widget.controller,
          obscureText: widget.passwordField ? isHidden : false,
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIconConstraints: widget.icon != null
                ? BoxConstraints(minHeight: 36, maxWidth: 36)
                : null,
            prefixIcon: widget.icon == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(left: 10, right: 5),
                    child: Icon(widget.icon, color: AppColors.textGrey),
                  ),
            suffixIconConstraints: widget.passwordField
                ? BoxConstraints(minHeight: 36, maxWidth: 36)
                : null,
            suffixIcon: !widget.passwordField
                ? null
                : InkWell(
                    onTap: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 5, right: 10),
                      child: Icon(
                        isHidden ? Icons.visibility : Icons.visibility_off,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ),
          ),
          cursorColor: AppColors.primary,
          inputFormatters: widget.inputFormatters,
          style: context.textTheme.bodyMedium!.copyWith(
            fontWeight: FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
