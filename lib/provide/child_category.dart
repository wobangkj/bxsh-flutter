import 'package:flutter/material.dart';
import 'package:flutter_shop/model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0;
  String categoryId = '4';
  int page = 1; //列表页数，当改变大类或者小类时进行改变
  String noMoreText = ''; //显示更多的标识

  setChildCategory(List<BxMallSubDto> list, String id) {
    categoryId = id;
    childIndex = 0;
    //------------------关键代码start
    page = 1;
    noMoreText = '';
    //------------------关键代码end
    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all];
    childCategoryList.addAll(list);
    notifyListeners();
  }

  //改变子类索引
  changeChildIndex(int index, String id) {
    childIndex = index;
    //------------------关键代码start
    page = 1;
    noMoreText = ''; //显示更多的表示
    //------------------关键代码end
    notifyListeners();
  }

  //增加Page的方法f
  addPage() {
    page++;
  }

  //改变noMoreText数据
  changeNoMore(String text) {
    noMoreText = text;
    notifyListeners();
  }
}
