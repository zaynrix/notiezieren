import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class buildBasicShimmer extends StatelessWidget {
  final double height;
  final double width;
  final double width2;

  buildBasicShimmer(
      {Key? key,
      this.height = double.infinity,
      this.width = 100,
      this.width2 = double.infinity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 15.h,
            width: MediaQuery.of(context).size.width * 0.5,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
          ),
          SizedBox(
            height: 10.h,
          ),
          Container(
            height: 120.h,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15.r)),
          ),
        ],
      ),
    );
  }
}

class buildListShimmer extends StatelessWidget {
  final int item_count;
  final double item_height;

  buildListShimmer({Key? key, this.item_count = 10, this.item_height = 100.0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: item_count,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
              top: 0.0, left: 16.0, right: 16.0, bottom: 18.0),
          child: buildBasicShimmer(height: item_height),
        );
      },
    );
  }
}

