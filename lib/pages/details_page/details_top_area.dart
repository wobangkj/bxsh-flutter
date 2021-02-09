import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../provide/detail_info.dart';
import '../../model/detailGoods.dart';

class DetailsTopArea extends StatelessWidget {
  final BuildContext context;
  DetailsTopArea(this.context);

  @override
  Widget build(BuildContext _) {
    GoodInfo goodsInfo = this.context.read<DetailInfoProvider>().goodsInfo;
    return Container(
        child: Container(
            child: Column(
      children: [
        _goodsImg(goodsInfo.image1),
        _goodsName(goodsInfo.goodsName),
        _goodsNum(goodsInfo.goodsSerialNumber),
        _goodsPrice(goodsInfo.presentPrice, goodsInfo.oriPrice)
      ],
    )));
  }

  // 商品图片
  Widget _goodsImg(url) {
    return Image.network(
      url,
      width: 740.w,
    );
  }

  // 商品名称
  Widget _goodsName(name) {
    return Container(
      width: 740.w,
      padding: EdgeInsets.only(left: 15.w),
      child: Text(
        name,
        style: TextStyle(fontSize: 30.sp),
      ),
    );
  }

  // 商品编号
  Widget _goodsNum(num) {
    return Container(
      width: 730.w,
      padding: EdgeInsets.only(left: 15.w),
      margin: EdgeInsets.only(top: 10.w),
      child: Text(
        '编号:${num}',
        style: TextStyle(color: Colors.black12),
      ),
    );
  }

  //商品价格方法

  Widget _goodsPrice(presentPrice, oriPrice) {
    return Container(
      width: ScreenUtil().setWidth(730),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Row(
        children: <Widget>[
          Text(
            '￥${presentPrice}',
            style: TextStyle(
              color: Colors.pinkAccent,
              fontSize: ScreenUtil().setSp(40),
            ),
          ),
          Text(
            '市场价:￥${oriPrice}',
            style: TextStyle(
                color: Colors.black26, decoration: TextDecoration.lineThrough),
          )
        ],
      ),
    );
  }
}
