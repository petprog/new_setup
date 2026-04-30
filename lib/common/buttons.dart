import 'dart:io';

import 'package:new_setup/core/core.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    this.onTap,
    required this.title,
    this.titleColor,
    this.btnColor,
    this.borderColor,
    this.disabled = false,
    this.loading = false,
    this.hpadding = 10,
    this.vpadding = 10,
  });

  final void Function()? onTap;
  final String title;
  final Color? titleColor;
  final Color? btnColor;
  final bool loading;
  final bool disabled;
  final Color? borderColor;
  final double hpadding;
  final double vpadding;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: context.screenSize.width,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor ?? AppColors.primary),
          gradient: btnColor == null
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary.withOpacity(.8),
                    AppColors.primary,
                  ],
                )
              : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: loading || disabled ? null : onTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: hpadding,
                vertical: vpadding,
              ),
              child: Center(
                child: loading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator.adaptive(
                          backgroundColor: Platform.isIOS
                              ? btnColor == null
                                    ? Colors.white
                                    : AppColors.primary
                              : Colors.white,
                        ),
                      )
                    : Text(
                        title,
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: titleColor ?? Colors.white,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
