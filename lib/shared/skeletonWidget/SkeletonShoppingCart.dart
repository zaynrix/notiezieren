// ignore_for_file: must_be_immutable, unused_import

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonShoppingList extends StatelessWidget {
  int itemCount;
  SkeletonShoppingList({this.itemCount= 6});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: itemCount,
        physics: NeverScrollableScrollPhysics(),
        itemBuilder: (_, index) => SkeletonShoppingCard());
  }
}

class SkeletonShoppingCard extends StatelessWidget {
  const SkeletonShoppingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        children: [
          // Container(
          //   // height: 80,
          //   // width: 300,
          //
          // ),
          // Container(
          //   height:80 ,
          //   width: double.infinity,
          // )
        ],
        // margin: EdgeInsets.all(6),
        // child: Padding(
        //   padding: EdgeInsets.all(10.0.w),
        //   child: Column(
        //     children: [
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //         children: [
        //           Container(
        //             width: 10,
        //             height: 8.0,
        //             color: Colors.white,
        //           ),
        //         ],
        //       ),
        //     ],
        //   ),
        // ),
      ),
    );
  }
}


