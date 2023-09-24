import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notienziert/features/Settings/settingProvider.dart';
import 'package:notienziert/interceptors/di.dart';
import 'package:notienziert/resources/color_manager.dart';
import 'package:notienziert/shared/widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';

class UsersScreen extends StatelessWidget {
  final data = sl<SettingProvider>();

  ContactUsScreen() {
    data.getUsersProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: ColorManager.backgroundColor,
        appBar: CustomAppBar(
          backgroundColor: ColorManager.backgroundColor,
          title: "Users",
        ),
        body: value.users.length == 0
            ? Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: ListView.separated(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: value.users.length,
                          separatorBuilder: (context, index) => Divider(
                            height: 14.h,
                            color: Colors.transparent,
                          ),
                          itemBuilder: (context, index) => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(15.0.r),
                              ),
                            ),
                            child: InkWell(
                              onTap: () {
                                value.launchUrlSite(
                                    value.contactUsData[index].value);
                              },
                              child: Card(
                                  color: ColorManager.black,
                                  elevation: 1,
                                  child: AspectRatio(
                                    aspectRatio: 16 / 9,
                                    child: Container(
                                      child: CachedNetworkImage(
                                        // color: Colors.red,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) => Center(
                                            child:
                                                const CircularProgressIndicator()),
                                        imageUrl:
                                            "${value.users[index].imageUrl}",
                                      ),
                                      decoration: BoxDecoration(
                                          // image: DecorationImage()
                                          ),
                                    ),
                                  )),
                            ),
                          ),
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
