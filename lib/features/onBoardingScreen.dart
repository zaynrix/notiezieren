import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:notienziert/api/local/local_pref.dart';
import 'package:notienziert/features/Settings/settingProvider.dart';
import 'package:notienziert/interceptors/di.dart';
import 'package:notienziert/resources/assets_manager.dart';
import 'package:notienziert/resources/color_manager.dart';
import 'package:notienziert/resources/strings_manager.dart';
import 'package:notienziert/routing/navigation.dart';
import 'package:notienziert/routing/routes.dart';

class Introduction extends StatelessWidget {
  const Introduction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IntroductionScreen(
        pages: [
          PageViewModel(
            image: SvgPicture.asset(
              ImageAssets.onBoarding1,
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            titleWidget: Text(
              '${AppStrings().takeNotes1}',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            bodyWidget: Text(
              '${AppStrings().takeSubNotes1}',
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.center,
            ),
          ),
          PageViewModel(
            titleWidget: Text(
              '${AppStrings().takeNotes2}',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            image: SvgPicture.asset(
              ImageAssets.onBoarding2,
              fit: BoxFit.contain,
              width: MediaQuery.of(context).size.width * 0.8,
            ),
            bodyWidget: Text(
              '${AppStrings().takeSubNotes2}',
              style: Theme.of(context).textTheme.subtitle2,
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
            ),
          ),
          PageViewModel(
            titleWidget: Text(
              '${AppStrings().takeNotes3}',
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              overflow: TextOverflow.visible,
            ),
            image: SvgPicture.asset(ImageAssets.onBoarding3,
                fit: BoxFit.contain,
                width: MediaQuery.of(context).size.width * 0.8),
            bodyWidget: Text(
              '${AppStrings().takeSubNotes3}',
              style: Theme.of(context).textTheme.subtitle2,
              overflow: TextOverflow.visible,
              textAlign: TextAlign.center,
            ),
          ),
        ],
        onDone: () {},
        nextStyle: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
              side: const BorderSide(color: Colors.red),
            ),
          ),
        ),
        showBackButton: false,
        showSkipButton: false,
        controlsMargin: const EdgeInsets.symmetric(vertical: 20),
        skip: const Icon(Icons.skip_next),
        next: CircleAvatar(
          backgroundColor:
              sl<SettingProvider>().CCC[sl<SharedLocal>().getColorIndex][0],
          radius: 22.r,
          child: SvgPicture.asset(
            IconAssets.arrowRight,
            color: Colors.white,
          ),
        ),
        done: ElevatedButton(
          onPressed: () {
            sl<NavigationService>().navigateToAndRemove(Routes.login);
          },
          child: const FittedBox(child: Text("Get Started")),
        ),
        dotsDecorator: DotsDecorator(
            size: const Size.square(10.0),
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            activeSize: const Size(10.0, 10.0),
            activeColor:
                sl<SettingProvider>().CCC[sl<SharedLocal>().getColorIndex][0],
            color: ColorManager.lightPink,
            spacing: const EdgeInsets.symmetric(horizontal: 3.0),
            activeShape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
      ),
    );
  }
}
