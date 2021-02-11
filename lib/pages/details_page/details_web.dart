import 'package:flutter/material.dart';
import 'package:flutter_shop/model/detailGoods.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/detail_info.dart';

class DetailsWeb extends StatelessWidget {
  // final BuildContext context;
  // DetailsWeb(this.context);

  @override
  Widget build(BuildContext context) {
    GoodInfo goodsInfo = context.read<DetailInfoProvider>().goodsInfo;
    int tabIdx = context.watch<DetailInfoProvider>().tabIdx;
    if (tabIdx == 0) {
      return Container(
        child: Html(
          data: goodsInfo.goodsDetail,
        ),
      );
    } else {
      return Container(
          width: 750.w,
          padding: EdgeInsets.all(10),
          alignment: Alignment.center,
          child: Text('暂时没有数据'));
    }
  }
}
