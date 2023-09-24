import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notienziert/api/local/local_pref.dart';
import 'package:notienziert/features/Registrations/auth_provider.dart';
import 'package:notienziert/features/Settings/settingProvider.dart';
import 'package:notienziert/interceptors/di.dart';
import 'package:notienziert/resources/assets_manager.dart';
import 'package:notienziert/resources/color_manager.dart';
import 'package:notienziert/resources/font_manager.dart';
import 'package:notienziert/routing/navigation.dart';
import 'package:notienziert/routing/routes.dart';
import 'package:notienziert/shared/widgets/CustomCTAButton.dart';
import 'package:notienziert/shared/widgets/CustomeRoundedTextFiled.dart';
import 'package:notienziert/shared/widgets/CustomeSvg.dart';
import 'package:notienziert/utils/appConfig.dart';
import 'package:notienziert/utils/validator.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, _) {
        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                currentFocus.focusedChild!.unfocus();
              }
            },
            child: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Form(
                  key: value.loginFormKey,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      children: [
                        Spacer(),
                        // SizedBox(
                        //   height: 60.h,
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Welcome".tr(),
                              style: AppConfig()
                                  .getTextContext(context)
                                  .headline2!
                                  .copyWith(fontSize: FontSize.s40.sp),
                            ),
                            GradientText('back'.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline2!
                                    .copyWith(
                                        fontSize: FontSize.s40.sp,
                                        fontWeight: FontWeightManager.semiBold),
                                colors: sl<SettingProvider>()
                                    .CCC[sl<SharedLocal>().getColorIndex]),
                          ],
                        ),
                        // SizedBox(
                        //   height: 20.h,
                        // ),
                        Image.asset(
                          ImageAssets.splashLogoPng,
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                        // SizedBox(
                        //   height: 40.h,
                        // ),
                        CustomTextFiled(
                          prefixIcon: CustomSvgAssets(
                            color: sl<SettingProvider>()
                                .CCC[sl<SharedLocal>().getColorIndex][0],
                            path: IconAssets.profile,
                          ),
                          hintText: 'Email',
                          keyboardType: TextInputType.emailAddress,
                          focuse: (_) => FocusScope.of(context).nearestScope,
                          textInputAction: TextInputAction.next,
                          onChanged: (val) {
                            value.emailController.text = val!;
                          },
                          validator: (value) =>
                              Validator2.validateEmail(value ?? ""),
                        ),
                        SizedBox(
                          height: 14.h,
                        ),
                        CustomTextFiled(
                          textInputAction: TextInputAction.next,
                          obscureText: value.isObscure,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              value.visibility();
                            },
                            child: CustomSvgAssets(
                              color: sl<SettingProvider>()
                                  .CCC[sl<SharedLocal>().getColorIndex][0],
                              path: value.isObscure
                                  ? IconAssets.hide
                                  : IconAssets.show,
                            ),
                          ),
                          prefixIcon: CustomSvgAssets(
                            color: sl<SettingProvider>()
                                .CCC[sl<SharedLocal>().getColorIndex][0],
                            path: IconAssets.lock,
                          ),
                          hintText: 'password',
                          focuse: (_) => FocusScope.of(context).nearestScope,
                          onChanged: (val) {
                            value.passwordController.text = val!;
                          },
                          validator: (value) =>
                              Validator2.validatePassword(value ?? ""),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            sl<NavigationService>()
                                .navigateTo(Routes.forgetPassword);
                          },
                          child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Text(
                                "Forget password".tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2!
                                    .copyWith(color: ColorManager.lightGrey),
                              )),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        CustomeCTAButton(
                          isActive: !value.loading,
                          trigger: value.loading,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            value.loginProvider();
                          },
                          title: "Login",
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Spacer(),
                        SafeArea(
                          bottom: true,
                          child: Center(
                            child: InkWell(
                              onTap: () {
                                sl<NavigationService>()
                                    .navigateToAndRemove(Routes.signUp);
                              },
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'HaventAccount'.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(
                                              color: ColorManager.lightGrey),
                                    ),
                                    TextSpan(
                                      text: 'SignUp'.tr(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle2!
                                          .copyWith(
                                              decoration:
                                                  TextDecoration.underline,
                                              color: sl<SettingProvider>().CCC[
                                                  sl<SharedLocal>()
                                                      .getColorIndex][0],
                                              fontWeight:
                                                  FontWeightManager.semiBold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
