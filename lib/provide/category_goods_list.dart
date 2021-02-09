import 'package:flutter/material.dart';
import '../model/categoryGoods.dart';

class CategoryGoodsListProvider with ChangeNotifier {
  List<CategoryGoodsData> goodList = [];

  setGoodList(List<CategoryGoodsData> list) {
    goodList.addAll(list);
    notifyListeners();
  }
}
