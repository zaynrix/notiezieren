import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notienziert/api/local/local_pref.dart';
import 'package:notienziert/features/Home/homePro.dart';
import 'package:notienziert/features/Registrations/auth_provider.dart';
import 'package:notienziert/features/Settings/settingProvider.dart';
import 'package:notienziert/interceptors/di.dart';
import 'package:notienziert/models/customeSettingItemModel.dart';
import 'package:notienziert/resources/color_manager.dart';
import 'package:notienziert/shared/widgets/CustomAppBar.dart';
import 'package:notienziert/shared/widgets/CustomSettingsItem.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);

  final user = sl<SharedLocal>().getUser();
  final profileProvider = sl<SettingProvider>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Setting",
      ),
      key: sl<AuthProvider>().scaffoldKey,
      backgroundColor: ColorManager.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
          child: Column(
            children: [
              Card(
                color: ColorManager.black,
                elevation: 0,
                child: ListTile(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5.h, horizontal: 5.w),
                  leading: CachedNetworkImage(
                    imageUrl: "https://www.w3schools.com/howto/img_avatar.png",
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(image: imageProvider),
                        borderRadius: BorderRadius.all(Radius.circular(6.0.r)),
                      ),
                      width: 70.w,
                      height: 70.h,
                    ),
                    placeholder: (context, url) => CircularProgressIndicator(
                      color: ColorManager.primary,
                    ),
                    errorWidget: (context, url, error) => Container(
                      decoration: BoxDecoration(
                        color: ColorManager.primary,
                        borderRadius: BorderRadius.all(Radius.circular(6.0.r)),
                      ),
                      width: 70.w,
                      height: 70.h,
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: Center(
                          child: Text(
                            user.fullName![0],
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    "${user.fullName ?? "Guest"}",
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
              SizedBox(
                height: 25.h,
              ),
              Expanded(
                child: Consumer2<HomeProvider, SettingProvider>(
                  builder: (context, data, v2, child) => ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => Divider(
                      height: 14.h,
                      color: Colors.transparent,
                    ),
                    itemCount: SettingItems.length,
                    itemBuilder: (context, index) {
                      return CustomSettingItem(
                        redColor: SettingItems[index].redColor,
                        onPressed: SettingItems[index].onPressed,
                        title: SettingItems[index].title,
                        path2: SettingItems[index].path,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
