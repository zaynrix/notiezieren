import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SkeletonMobileCardList extends StatelessWidget {
  final int itemCount;
  SkeletonMobileCardList({this.itemCount= 6});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: itemCount,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.6, crossAxisCount: 2),
        itemBuilder: (_, index) => SkeletonMobileCard());
  }
}

class SkeletonMobileCard extends StatelessWidget {
  const SkeletonMobileCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[100]!,
      child: Card(
        margin: EdgeInsets.all(6),
        child: Padding(
          padding: EdgeInsets.all(10.0.w),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 10,
                    height: 8.0,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
