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
import 'package:notienziert/resources/styles_manager.dart';
import 'package:notienziert/routing/navigation.dart';
import 'package:notienziert/routing/routes.dart';
import 'package:notienziert/shared/widgets/CustomCTAButton.dart';
import 'package:notienziert/shared/widgets/CustomeSvg.dart';
import 'package:notienziert/utils/appConfig.dart';
import 'package:notienziert/utils/validator.dart';
import 'package:provider/provider.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

import '../../shared/widgets/CustomeRoundedTextFiled.dart';

class Signup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild!.unfocus();
          }
        },
        child: Consumer<AuthProvider>(
          builder: (context, provider, _) => Scaffold(
            body: Form(
              key: provider.signUpFormKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 60.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Sign'.tr(),
                            style: AppConfig()
                                .getTextContext(context)
                                .headline2!
                                .copyWith(fontSize: FontSize.s40.sp),
                          ),
                          GradientText('Up'.tr(),
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
                      Text(
                        "CreateAcc".tr(),
                        style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            fontSize: FontSize.s24.sp,
                            color: ColorManager.fadeGrey),
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      CustomTextFiled(
                        prefixIcon: CustomSvgAssets(
                          path: IconAssets.profile,
                          color: sl<SettingProvider>()
                              .CCC[sl<SharedLocal>().getColorIndex][0],
                        ),
                        hintText: 'Fullname',
                        keyboardType: TextInputType.emailAddress,
                        focuse: (_) => FocusScope.of(context).nearestScope,
                        textInputAction: TextInputAction.next,
                        onChanged: (val) {
                          provider.fullname.text = val!;
                        },
                        validator: (value) =>
                            Validator.valueExists(value ?? ""),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      CustomTextFiled(
                        prefixIcon: CustomSvgAssets(
                          path: IconAssets.email,
                          color: sl<SettingProvider>()
                              .CCC[sl<SharedLocal>().getColorIndex][0],
                        ),
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        focuse: (_) => FocusScope.of(context).nextFocus(),
                        textInputAction: TextInputAction.next,
                        onChanged: (val) {
                          provider.emailController.text = val!;
                        },
                        validator: (value) =>
                            Validator2.validateEmail(value ?? ""),
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      CustomTextFiled(
                        focuse: (_) => FocusScope.of(context).nearestScope,
                        prefixIcon: Container(
                          child: ButtonTheme(
                            alignedDropdown: true,
                            child: DropdownButton(
                              dropdownColor: ColorManager.darkGrey,
                              isExpanded: true,
                              icon: Icon(
                                Icons.keyboard_arrow_down_outlined,
                                color: sl<SettingProvider>()
                                    .CCC[sl<SharedLocal>().getColorIndex][0],
                              ),
                              underline: Container(),
                              hint: Text(
                                'Gender',
                                style: getRegularStyle(
                                    color: ColorManager.lightGrey,
                                    fontSize: FontSize.s16.sp),
                              ),
                              value: provider.selectedGender,
                              onChanged: (newValue) {
                                provider.selectGender(newValue);
                              },
                              items: provider.gender.map((location) {
                                return DropdownMenuItem(
                                  child: new Text(
                                    "${location.values}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            color: sl<SettingProvider>().CCC[
                                                sl<SharedLocal>()
                                                    .getColorIndex][0]),
                                  ),
                                  value: location,
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                        hintText: '',
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        onChanged: (val) {},
                        validator: (value) =>
                            provider.selectedGender == null ? "" : null,
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      CustomTextFiled(
                        suffixIcon: CustomSvgAssets(
                          color: sl<SettingProvider>()
                              .CCC[sl<SharedLocal>().getColorIndex][0],
                          path: IconAssets.hide,
                        ),
                        prefixIcon: CustomSvgAssets(
                          color: sl<SettingProvider>()
                              .CCC[sl<SharedLocal>().getColorIndex][0],
                          path: IconAssets.lock,
                        ),
                        hintText: 'password',
                        focuse: (_) => FocusScope.of(context).nearestScope,
                        textInputAction: TextInputAction.next,
                        onChanged: (val) {
                          provider.passwordController.text = val!;
                        },
                        validator: (value) =>
                            Validator2.validatePassword(value ?? ""),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      // 059
                      CustomTextFiled(
                        suffixIcon: CustomSvgAssets(
                          color: sl<SettingProvider>()
                              .CCC[sl<SharedLocal>().getColorIndex][0],
                          path: IconAssets.hide,
                        ),
                        prefixIcon: CustomSvgAssets(
                          color: sl<SettingProvider>()
                              .CCC[sl<SharedLocal>().getColorIndex][0],
                          path: IconAssets.lock,
                        ),
                        hintText: 'ConfirmPassword',
                        focuse: (_) => FocusScope.of(context).parent,
                        textInputAction: TextInputAction.done,
                        onChanged: (val) {
                          provider.confirmPasswordController.text = val!;
                        },
                        validator: (val) {
                          if (val!.isEmpty) return ''.tr();
                          if (val != provider.passwordController.text)
                            return 'Not Match'.tr();
                          return null;
                        }, //0599147563
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Theme(
                            data: ThemeData(
                                unselectedWidgetColor: const Color(0xFF667085)),
                            child: Checkbox(
                              value: provider.rememberMe,
                              checkColor: sl<SettingProvider>()
                                  .CCC[sl<SharedLocal>().getColorIndex][0],
                              activeColor: ColorManager.secondryBlack,
                              onChanged: (value) {
                                provider.remember(value!);
                              },
                            ),
                          ),
                          Text('Agree with trams and condition'.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(fontSize: FontSize.s12.sp)),
                        ],
                      ),
                      SizedBox(
                        height: 40.h,
                      ),
                      CustomeCTAButton(
                        trigger: provider.loading,
                        primary: ColorManager.secondryBlack,
                        onPressed: () {
                          provider.SignupProvider();
                        },
                        title: "Sign Up",
                      ),
                      SafeArea(
                        // yahya123@gmail.com
                        // yahya123
                        bottom: true,
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              sl<NavigationService>()
                                  .navigateToAndRemove(Routes.login);
                            },
                            child: RichText(
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Haveanaccount'.tr(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2!
                                        .copyWith(
                                            color: ColorManager.lightGrey),
                                  ),
                                  TextSpan(
                                    text: 'Login'.tr(),
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
      ),
    );
  }
}
