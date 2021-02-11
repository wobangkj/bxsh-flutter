import 'package:flutter/material.dart';
import 'package:flutter_shop/provide/detail_info.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTabBar extends StatelessWidget {
  // final BuildContext context;
  // DetailsTabBar(this.context);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: _myTabbar(context),
    );
  }

  Widget _myTabbar(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [_myItem('详情', 0, context), _myItem('评论', 1, context)],
      ),
    );
  }

  Widget _myItem(String name, int index, BuildContext context) {
    int tabIdx = context.watch<DetailInfoProvider>().tabIdx;
    // int tabIdx = 0;
    return Container(
      width: 375.w,
      padding: EdgeInsets.only(bottom: 10.w),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                  width: 1.w,
                  color: tabIdx == index
                      ? Theme.of(context).primaryColor
                      : Colors.white))),
      child: InkWell(
        onTap: () {
          context.read<DetailInfoProvider>().handleTabbar(index);
        },
        child: Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 30.sp,
              color: tabIdx == index
                  ? Theme.of(context).primaryColor
                  : Colors.black),
        ),
      ),
    );
  }
}
