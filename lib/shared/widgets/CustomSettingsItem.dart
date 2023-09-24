import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notienziert/api/local/local_pref.dart';
import 'package:notienziert/features/Settings/settingProvider.dart';
import 'package:notienziert/interceptors/di.dart';
import 'package:notienziert/resources/color_manager.dart';
import 'package:notienziert/shared/widgets/CustomeSvg.dart';

class CustomSettingItem extends StatelessWidget {
  final String title;
  final Widget? path;
  final String? path2;
  final bool redColor;
  final void Function()? onPressed;

  CustomSettingItem(
      {Key? key,
      this.path2,
      required this.title,
      this.onPressed,
      this.path,
      this.redColor = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: ListTile(
            leading: CustomSvgAssets(
                path: path2,
                color: sl<SettingProvider>()
                    .CCC[sl<SharedLocal>().getColorIndex]
                    .first),
            title: Text(
              title.tr(),
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: !redColor ? ColorManager.white : ColorManager.red),
            ),
          ),
        ),
        decoration: BoxDecoration(
          color: ColorManager.black,
          borderRadius: BorderRadius.all(
            Radius.circular(12.0.r),
          ),
        ),
      ),
    );
  }
}
