import 'dart:convert';

import 'package:flutter/material.dart';
import '../model/detailGoods.dart';
import '../service/service_method.dart';

class DetailInfoProvider with ChangeNotifier {
  GoodInfo goodsInfo;
  int tabIdx = 0;

  // tabbar切换
  handleTabbar(int idx) {
    tabIdx = idx;
    notifyListeners();
  }

  // 从后台获取数据
  getGoodsInfo(String id) async {
    Map formData = {"goodsId": id};
    DetailGoods res = DetailGoods.fromJson(await getGoodDetailById(formData));
    goodsInfo = res.data.goodInfo;
    notifyListeners();
  }
}
