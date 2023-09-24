import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:notienziert/api/local/local_pref.dart';
import 'package:notienziert/features/Home/homePro.dart';
import 'package:notienziert/features/Settings/settingProvider.dart';
import 'package:notienziert/interceptors/di.dart';
import 'package:notienziert/models/taskModel.dart';
import 'package:notienziert/resources/assets_manager.dart';
import 'package:notienziert/resources/color_manager.dart';
import 'package:notienziert/resources/font_manager.dart';
import 'package:notienziert/resources/strings_manager.dart';
import 'package:notienziert/routing/navigation.dart';
import 'package:notienziert/routing/routes.dart';
import 'package:notienziert/shared/pages/empty.dart';
import 'package:notienziert/shared/pages/reConnect.dart';
import 'package:notienziert/shared/skeletonWidget/ShimmerHelper.dart';
import 'package:notienziert/shared/widgets/CustomAppBar.dart';
import 'package:notienziert/shared/widgets/CustomeSvg.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen() {
    sl<HomeProvider>().getHome();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer2<HomeProvider, SettingProvider>(
      builder: (context, value, v2, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          key: value.ScaffoldKeySheet,
          floatingActionButton: FloatingActionButton(
            elevation: 16,
            child: Icon(Icons.add),
            backgroundColor: ColorManager.darkGrey,
            onPressed: () {
              value.noteTitle.clear();
              value.id = 0;
              value.noteBottomSheet(value.ScaffoldKeySheet);
            },
          ),
          backgroundColor: ColorManager.backgroundColor,
          appBar: CustomAppBar(
            actions: [
              Image.asset(
                ImageAssets.splashLogoPng,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.w),
                child: GestureDetector(
                  onTap: () {
                    sl<NavigationService>().navigateTo(Routes.setting);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: ColorManager.primaryBlack,
                        borderRadius: BorderRadius.circular(15)),
                    child: Padding(
                      padding: EdgeInsets.all(16.0.w),
                      child: CustomSvgAssets(
                        path: IconAssets.setting,
                        color: v2.CCC[sl<SharedLocal>().getColorIndex].first,
                      ),
                    ),
                  ),
                ),
              ),
            ],
            backgroundColor: ColorManager.parent,
            title: "${AppStrings().note}",
          ),
          body: Provider.of<InternetConnectionStatus>(context) ==
                  InternetConnectionStatus.disconnected
              ? NetworkDisconnected(onPress: () {
                  value.refresh();
                })
              : RefreshIndicator(
                  onRefresh: () async {
                    value.refresh();
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: value.init == false && value.tasks!.length == 0
                        ? SingleChildScrollView(
                            child: buildListShimmer(item_count: 10),
                          )
                        : value.tasks!.length > 0
                            ? RefreshIndicator(
                                onRefresh: () async {
                                  value.refresh();
                                },
                                child: ListView(
                                  children: [
                                    GroupedListView<Data, dynamic>(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      order: GroupedListOrder.DESC,
                                      elements: value.tasks!,
                                      groupBy: (element) =>
                                          element.createdAt!.split("T")[0],
                                      groupHeaderBuilder: (Data value) =>
                                          Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "${value.createdAt!.split("T")[0]}",
                                          style: TextStyle(
                                              color: ColorManager.lightGrey,
                                              fontSize: FontSize.s16),
                                        ),
                                      ),
                                      itemBuilder: (c, element) {
                                        return noteCard(
                                          scaffoldKeySheet:
                                              value.ScaffoldKeySheet,
                                          stop: true,
                                          element: element,
                                        );
                                      },
                                    )
                                  ],
                                ),
                              )
                            : EmptyScreen(
                                path: ImageAssets.noNote,
                                title: AppStrings().noNotes,
                                subtitle: AppStrings().subNoNotes,
                              ),
                  ),
                ),
        );
      },
    );
  }
}

class noteCard extends StatelessWidget {
  final GlobalKey? scaffoldKeySheet;
  final Data? element;
  final bool stop;

  noteCard({Key? key, this.element, this.stop = false, this.scaffoldKeySheet})
      : super(key: key);

  final data = sl<HomeProvider>();

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingProvider>(
      builder: (context, value, child) => Dismissible(
        background: SlideLeftBackground(),
        secondaryBackground: SlideRightBackground(),
        key: Key(element!.title!),
        confirmDismiss: stop
            ? (direction) async {
                if (direction == DismissDirection.endToStart) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          backgroundColor: ColorManager.darkGrey,
                          content: Text(
                            "Are you sure you want to delete ${element!.title!}?",
                            style: Theme.of(context).textTheme.subtitle2,
                            overflow: TextOverflow.visible,
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: Text(
                                "Cancel",
                                style: TextStyle(color: ColorManager.lightGrey),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text(
                                "Delete",
                                style: TextStyle(color: Colors.red),
                              ),
                              onPressed: () {
                                data.id = element!.id;
                                data.deleteTask();

                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      });
                } else {
                  data.noteTitle.text = element!.title!;
                  data.id = element!.id;
                  data.noteBottomSheet(scaffoldKeySheet!);
                }
                return null;
              }
            : (direction) async {
                return false;
              },
        child: Card(
          elevation: 0,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(36),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              gradient: LinearGradient(
                colors: value.CCC[sl<SharedLocal>().getColorIndex],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: Text("${element!.title!} ",
                overflow: TextOverflow.visible,
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 12.0 * sl<SharedLocal>().getFontSize)),
          ),
        ),
      ),
    );
  }
}

Widget slideLeftBackground() {
  return Container(
    color: Colors.red,
    child: Align(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(
            Icons.delete,
            color: Colors.white,
          ),
          Text(
            " Delete",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.right,
          ),
          SizedBox(
            width: 20,
          ),
        ],
      ),
      alignment: Alignment.centerRight,
    ),
  );
}

class SlideRightBackground extends StatelessWidget {
  const SlideRightBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      elevation: 0,
      color: ColorManager.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0.r),
      ),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            SizedBox(
              width: 30.w,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(10.0.h),
                child: CustomSvgAssets(
                  path: IconAssets.delete,
                  color: ColorManager.white,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
          ],
        ),
        alignment: AlignmentDirectional.centerStart,
      ),
    ));
  }
}

class SlideLeftBackground extends StatelessWidget {
  const SlideLeftBackground({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Card(
      elevation: 0,
      color: ColorManager.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0.r),
      ),
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 30.w,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(10.0.h),
                child: CustomSvgAssets(
                  path: IconAssets.menu,
                  color: ColorManager.white,
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
          ],
        ),
        alignment: AlignmentDirectional.centerStart,
      ),
    ));
  }
}
