import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notienziert/api/local/local_pref.dart';
import 'package:notienziert/features/Home/homeScreen.dart';
import 'package:notienziert/features/Settings/settingProvider.dart';
import 'package:notienziert/interceptors/di.dart';
import 'package:notienziert/models/taskModel.dart';
import 'package:notienziert/resources/color_manager.dart';
import 'package:notienziert/shared/widgets/CustomAppBar.dart';
import 'package:notienziert/shared/widgets/CustomCTAButton.dart';
import 'package:provider/provider.dart';

class TypographyScreen extends StatelessWidget {
  TypographyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: CustomAppBar(
          title: 'Typography',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                noteCard(
                  stop: true,
                  element: Data.obj(),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Colors".tr(),
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(
                  height: 20,
                ),
                GridView.builder(
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 2,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      crossAxisCount: 5),
                  itemCount: value.CCC.length,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {
                        value.changeIndexColor(index);
                      },
                      child: Container(
                        width: 50,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: sl<SharedLocal>().getColorIndex == index
                                ? ColorManager.white
                                : ColorManager.parent,
                            //                   <--- border color
                            width: 3.0,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                          gradient: LinearGradient(
                            colors: value.CCC[index],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      "Fonts size :".tr() +
                          " ${10 * sl<SharedLocal>().getFontSize}",
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  margin: EdgeInsets.only(right: 10),
                  decoration: new BoxDecoration(
                      color: ColorManager.black,
                      borderRadius:
                          new BorderRadius.all(new Radius.circular(5.0)),
                      boxShadow: [
                        new BoxShadow(
                            color: Colors.black38,
                            offset: new Offset(0.0, 2.0),
                            blurRadius: 10)
                      ]),
                  child: new Slider(
                    value: sl<SharedLocal>().getFontSize,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white,
                    onChanged: (double s) => value.changeSize(s),
                    divisions: 10,
                    min: 1.0,
                    max: 5.0,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                CustomeCTAButton(
                  title: "Save",
                  trigger: false,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
