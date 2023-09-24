import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notienziert/api/local/local_pref.dart';
import 'package:notienziert/features/Home/homePro.dart';
import 'package:notienziert/features/Settings/settingProvider.dart';
import 'package:notienziert/interceptors/di.dart';
import 'package:notienziert/models/languageModel.dart';
import 'package:notienziert/resources/color_manager.dart';
import 'package:notienziert/resources/font_manager.dart';
import 'package:notienziert/resources/strings_manager.dart';
import 'package:notienziert/shared/widgets/CustomCTAButton.dart';
import 'package:notienziert/shared/widgets/CustomeRoundedTextFiled.dart';
import 'package:notienziert/utils/validator.dart';
import 'package:provider/provider.dart';

class BottomSheetNote extends StatefulWidget {
  @override
  _BottomSheetNoteState createState() => _BottomSheetNoteState();
}

class _BottomSheetNoteState extends State<BottomSheetNote> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.all(25),
      child: SingleChildScrollView(
        child: Consumer<HomeProvider>(
          builder: (context, data, child) => Form(
            key: data.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings().addNote,
                  style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: ColorManager.white,
                      fontWeight: FontWeightManager.semiBold),
                ),
                SizedBox(
                  height: 32.h,
                ),
                CustomTextFiled(
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(15),
                  ],
                  maxLines: 5,
                  controller: data.noteTitle,
                  hintText: '${AppStrings().typeSomething}',
                  keyboardType: TextInputType.streetAddress,
                  focuse: (_) => FocusScope.of(context).nearestScope,
                  textInputAction: TextInputAction.next,
                  validator: (value) => Validator2.validateName(value ?? ""),
                ),
                SizedBox(
                  height: 32.h,
                ),
                CustomeCTAButton(
                  trigger: data.loading,
                  primary: ColorManager.secondColor,
                  onPressed: data.loading != true
                      ? () {
                          data.id == 0 ? data.addTask() : data.updateTask();
                        }
                      : () {},
                  title: data.id != 0 ? AppStrings().update : AppStrings().save,
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomeCTAButtonCancel(
                  trigger: false,
                  primary: ColorManager.lightGrey,
                  onPressed: () {
                    data.id = 0;
                  },
                  title: AppStrings().cancel,
                ),
                SizedBox(
                  height: 16.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomSheetLanguage extends StatefulWidget {
  @override
  _BottomSheetLanguageState createState() => _BottomSheetLanguageState();
}

class _BottomSheetLanguageState extends State<BottomSheetLanguage> {
  final data = sl<SettingProvider>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Text(
                  "Language".tr(),
                  style: Theme.of(context).textTheme.subtitle2!.copyWith(
                      color: ColorManager.white,
                      fontWeight: FontWeightManager.semiBold),
                )
              ],
            ),
            SizedBox(
              height: 32.h,
            ),
            ListView.separated(
              shrinkWrap: true,
              itemCount: Language.languageList.length,
              separatorBuilder: (context, index) => Divider(),
              itemBuilder: (context, index) => Container(
                decoration: BoxDecoration(
                  color: ColorManager.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0.r),
                  ),
                ),
                child: Card(
                  color: ColorManager.black,
                  elevation: 0,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                    child: RadioListTile(
                      activeColor: sl<SettingProvider>()
                          .CCC[sl<SharedLocal>().getColorIndex][0],
                      toggleable: false,
                      value: index,
                      onChanged: (dynamic value) {
                        sl<SharedLocal>().setLanguage =
                            Language.languageList[index].languageCode;
                        context.setLocale(Locale(
                            '${Language.languageList[index].languageCode}'));

                        data.changeLanguage(value);
                        sl<SharedLocal>().setLanguageIndex = data.languageValue;
                        data.languageValue = value;
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                      groupValue: sl<SharedLocal>().getIndexLang,
                      title: Text(
                        "${Language.languageList[index].name}",
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(color: ColorManager.white),
                      ),
                    ),
                  ),
                  margin: EdgeInsets.zero,
                ),
              ),
            ),
            SizedBox(
              height: 16.h,
            ),
          ],
        ),
      ),
    );
  }
}
