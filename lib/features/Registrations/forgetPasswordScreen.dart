import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notienziert/features/Registrations/auth_provider.dart';
import 'package:notienziert/resources/assets_manager.dart';
import 'package:notienziert/resources/color_manager.dart';
import 'package:notienziert/resources/font_manager.dart';
import 'package:notienziert/shared/widgets/CustomCTAButton.dart';
import 'package:notienziert/shared/widgets/CustomeRoundedTextFiled.dart';
import 'package:provider/provider.dart';

import '../../utils/validator.dart';

class ForgetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorManager.white),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.info_outline,
                color: ColorManager.white,
              ))
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Consumer<AuthProvider>(
          builder: (context, value, _) => Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25.w),
                  child: Form(
                    key: value.forgetFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Spacer(),
                        Center(
                          child: Text('Reset password',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1!
                                  .copyWith(fontSize: FontSize.s22.sp)),
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Image.asset(
                          ImageAssets.splashLogoPng,
                          width: MediaQuery.of(context).size.width * 0.5,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Center(
                          child: Text(
                              'Enter the email associated with your account and we’ll send an email with instructions to reset your password!',
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      color: ColorManager.lightGrey,
                                      fontSize: FontSize.s14.sp)),
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        CustomTextFiled(
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
                          height: 24.h,
                        ),
                        CustomeCTAButton(
                          ProgressColor: ColorManager.white,
                          trigger: value.loading,
                          primary: ColorManager.primary,
                          onPressed: () {
                            value.forgetProvider();
                          },
                          title: "Next",
                        ),
                        Spacer(
                          flex: 2,
                        ),
                      ],
                    ),
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
