import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notienziert/features/Registrations/auth_provider.dart';
import 'package:notienziert/interceptors/di.dart';
import 'package:notienziert/resources/assets_manager.dart';
import 'package:notienziert/resources/color_manager.dart';
import 'package:notienziert/resources/font_manager.dart';
import 'package:notienziert/shared/widgets/CustomCTAButton.dart';
import 'package:notienziert/shared/widgets/CustomeRoundedTextFiled.dart';
import 'package:notienziert/shared/widgets/CustomeSvg.dart';
import 'package:notienziert/utils/validator.dart';
import 'package:provider/provider.dart';

class CreateNewPassword extends StatelessWidget {
  CreateNewPassword({Key? key}) : super(key: key);
  final data = sl<AuthProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.black),
          actions: [
            IconButton(onPressed: () {}, icon: Icon(Icons.info_outline))
          ],
        ),
        body: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Consumer<AuthProvider>(
            builder: (context, provider, _) => Scaffold(
                body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Form(
                  key: data.formKey2,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Center(
                          child: Text('Change password',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(fontSize: FontSize.s22.sp)),
                        ),
                        SizedBox(
                          height: 16.h,
                        ),
                        Wrap(
                          children: [
                            Text(
                              'Your new password must be different from previous used passwords.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      color: ColorManager.lightGrey,
                                      fontSize: FontSize.s14.sp),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        CustomTextFiled(
                          obscureText: provider.isObscure,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              provider.visibility();
                            },
                            child: CustomSvgAssets(
                              color: ColorManager.primary,
                              path: provider.isObscure
                                  ? IconAssets.hide
                                  : IconAssets.show,
                            ),
                          ),
                          prefixIcon: CustomSvgAssets(
                            color: ColorManager.primary,
                            path: IconAssets.lock,
                          ),
                          hintText: 'Current Password',
                          focuse: (_) => FocusScope.of(context).nearestScope,
                          textInputAction: TextInputAction.next,
                          onChanged: (val) {
                            data.currentPass.text = val!;
                          },
                          validator: (value) =>
                              Validator2.validatePassword(value ?? ""),
                        ),
                        SizedBox(
                          height: 4.h,
                        ),
                        Text(
                          "Must be at least 8 characters.",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(color: ColorManager.lightGrey),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        CustomTextFiled(
                          prefixIcon: CustomSvgAssets(
                            color: ColorManager.primary,
                            path: IconAssets.lock,
                          ),
                          hintText: 'New Password',
                          focuse: (_) => FocusScope.of(context).nearestScope,
                          textInputAction: TextInputAction.next,
                          onChanged: (val) {
                            data.newPass.text = val!;
                          },
                          validator: (val) {
                            if (val!.isEmpty) return 'Empty';
                            return null;
                          },
                        ),
                        SizedBox(
                          height: 24.h,
                        ),
                        CustomeCTAButton(
                          trigger: data.loading,
                          ProgressColor: ColorManager.white,
                          primary: ColorManager.primary,
                          onPressed: () {
                            sl<AuthProvider>().changePasswordProvider();
                          },
                          title: "Confirm",
                        ),
                        Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )),
          ),
        ));
  }
}
