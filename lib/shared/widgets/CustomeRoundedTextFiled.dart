import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notienziert/api/local/local_pref.dart';
import 'package:notienziert/features/Settings/settingProvider.dart';
import 'package:notienziert/interceptors/di.dart';
import 'package:notienziert/resources/color_manager.dart';
import 'package:notienziert/resources/font_manager.dart';
import 'package:notienziert/resources/styles_manager.dart';

class CustomTextFiled extends StatelessWidget {
  CustomTextFiled(
      {this.onChanged,
      this.controller,
      required this.hintText,
      required this.focuse,
      this.validator,
      this.maxLines = 1,
      this.obscureText = false,
      this.keyboardType,
      this.prefixIcon,
      this.inputFormatters,
      this.textInputAction = TextInputAction.next,
      this.suffixIcon});

  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onChanged;
  final void Function(String) focuse;
  final String? Function(String?)? validator;
  final String hintText;
  final bool obscureText;
  final int maxLines;

  final TextInputType? keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 10),
              color: ColorManager.black.withOpacity(0.03),
              blurRadius: 20)
        ],
      ),
      child: TextFormField(
        maxLines: maxLines,
        inputFormatters: inputFormatters ?? [],
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: obscureText,
        validator: validator,
        onChanged: onChanged,
        keyboardType: keyboardType ?? TextInputType.text,
        onFieldSubmitted: focuse,
        controller: controller,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          isDense: true,
          hintText: hintText.tr(),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          filled: true,
          errorStyle: const TextStyle(height: 0, color: Colors.transparent),
          hintStyle: getRegularStyle(
              color: ColorManager.lightGrey, fontSize: FontSize.s16.sp),
          fillColor: ColorManager.primaryBlack,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.transparent, width: 3),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
                color: sl<SettingProvider>()
                    .CCC[sl<SharedLocal>().getColorIndex][0]),
          ),
        ),
        style: const TextStyle(
          fontSize: 16,
          color: ColorManager.lightGrey,
        ),
      ),
    );
  }
}
