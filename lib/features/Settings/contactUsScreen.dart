import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notienziert/api/local/local_pref.dart';
import 'package:notienziert/features/Settings/settingProvider.dart';
import 'package:notienziert/interceptors/di.dart';
import 'package:notienziert/resources/color_manager.dart';
import 'package:notienziert/shared/widgets/CustomAppBar.dart';
import 'package:provider/provider.dart';

class ContactUsScreen extends StatelessWidget {
  final data = sl<SettingProvider>();

  ContactUsScreen() {
    data.getContactUsProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: ColorManager.backgroundColor,
        appBar: CustomAppBar(
          backgroundColor: ColorManager.backgroundColor,
          title: "Contact Us",
        ),
        body: value.contactUsData.length == 0
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: ListView.separated(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    itemCount: value.contactUsData.length,
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
                          value.launchUrlSite(value.contactUsData[index].value);
                        },
                        child: Card(
                          color: ColorManager.black,
                          elevation: 1,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundColor: value
                                    .CCC[sl<SharedLocal>().getColorIndex][0],
                                child: AspectRatio(
                                  aspectRatio: 9 / 16,
                                  child: CachedNetworkImage(
                                    // color: Colors.red,
                                    fit: BoxFit.scaleDown,
                                    placeholder: (context, url) => Center(
                                        child:
                                            const CircularProgressIndicator()),
                                    imageUrl:
                                        "${value.contactUsData[index].image}",
                                  ),
                                ),
                              ),
                              title: Text(
                                "${value.contactUsData[index].value}",
                                overflow: TextOverflow.visible,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ),
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
