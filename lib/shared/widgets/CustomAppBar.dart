import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notienziert/resources/color_manager.dart';
import 'package:notienziert/resources/font_manager.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final double height;
  final Widget? leading;
  final List<Widget>? actions;
  final Color? backgroundColor;

  CustomAppBar({
    this.backgroundColor = ColorManager.backgroundColor,
    this.leading,
    required this.title,
    this.actions,
    this.height = kToolbarHeight,
  });

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        "${title.tr()}",
        style: TextStyle(color: ColorManager.white, fontSize: FontSize.s40.sp),
      ),
      centerTitle: false,
      actions: actions,
      backgroundColor: backgroundColor,
    );
  }
}
