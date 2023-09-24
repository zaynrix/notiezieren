import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notienziert/shared/widgets/CustomeSvg.dart';

// ignore: must_be_immutable
class EmptyScreen extends StatelessWidget {
  String title;
  String subtitle;
  String path;

  EmptyScreen(
      {Key? key,
      required this.path,
      required this.title,
      required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(
              flex: 1,
            ),
            CustomSvgAssets(
              path: path,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              title.tr(),
              style: Theme.of(context).textTheme.headline2,
            ),
            SizedBox(
              height: 20.h,
            ),
            Text(
              subtitle.tr(),
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline4,
            ),
            Spacer(
              flex: 2,
            ),
          ],
        ),
      ),
    );
  }
}
