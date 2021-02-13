import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../provide/detail_info.dart';
import '../../provide/cart.dart';
import '../../model/detailGoods.dart';
import '../../provide/currentIndex.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GoodInfo goodsInfo = context.read<DetailInfoProvider>().goodsInfo;
    return Container(
      width: 750.w,
      color: Colors.white,
      height: 80.h,
      child: Row(
        children: [
          InkWell(
            onTap: () {
              context.read<CurrentIndexProvide>().changeIndex(2);
              Navigator.pop(context);
            },
            child: Container(
              width: ScreenUtil().setWidth(110),
              alignment: Alignment.center,
              child: Icon(
                Icons.shopping_cart,
                size: 35,
                color: Colors.red,
              ),
            ),
          ),
          // InkWell(
          //   onTap: () {
          //     Provider.of<CartProvide>(context, listen: false).save(
          //         goodsInfo.goodsId,
          //         goodsInfo.goodsName,
          //         1,
          //         goodsInfo.presentPrice,
          //         goodsInfo.image1);
          //   },
          //   child: Container(
          //     alignment: Alignment.center,
          //     width: ScreenUtil().setWidth(320),
          //     height: ScreenUtil().setHeight(80),
          //     color: Colors.green,
          //     child: Text(
          //       '加入购物车',
          //       style: TextStyle(
          //           color: Colors.white, fontSize: ScreenUtil().setSp(28)),
          //     ),
          //   ),
          // ),
          Consumer<CartProvide>(
            builder: (_, localer, __) => InkWell(
                onTap: () {
                  localer.save(goodsInfo.goodsId, goodsInfo.goodsName, 1,
                      goodsInfo.presentPrice, goodsInfo.image1);
                },
                child: Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: ScreenUtil().setWidth(320),
                      height: ScreenUtil().setHeight(80),
                      color: Colors.green,
                      child: Text(
                        '加入购物车',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ScreenUtil().setSp(28)),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                        decoration: BoxDecoration(
                            color: Colors.pink,
                            border: Border.all(width: 2, color: Colors.white),
                            borderRadius: BorderRadius.circular(12.0)),
                        child: Text(
                          '${context.watch<CartProvide>().allGoodsCount}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(22)),
                        ),
                      ),
                    )
                  ],
                )),
          ),
          // ChangeNotifierProvider(
          //   create: (_) => CartProvide(),
          //   builder: (context, _) => InkWell(
          //     onTap: () {
          //       context.read<CartProvide>().save(
          //           goodsInfo.goodsId,
          //           goodsInfo.goodsName,
          //           1,
          //           goodsInfo.presentPrice,
          //           goodsInfo.image1);
          //     },
          //     child: Container(
          //       alignment: Alignment.center,
          //       width: ScreenUtil().setWidth(320),
          //       height: ScreenUtil().setHeight(80),
          //       color: Colors.green,
          //       child: Text(
          //         '加入购物车',
          //         style: TextStyle(
          //             color: Colors.white, fontSize: ScreenUtil().setSp(28)),
          //       ),
          //     ),
          //   ),
          // ),

          InkWell(
            onTap: () {},
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.red,
              child: Text(
                '马上购买',
                style: TextStyle(
                    color: Colors.white, fontSize: ScreenUtil().setSp(28)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
