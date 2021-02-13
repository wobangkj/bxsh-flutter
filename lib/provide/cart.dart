import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:common_utils/common_utils.dart';
import '../model/cartInfo.dart';

class CartProvide with ChangeNotifier {
  String cartString = "[]";
  List<CartInfoMode> cartList = [];
  double allPrice = 0; //总价格
  int allGoodsCount = 0; //商品总数量

  save(goodsId, goodsName, count, price, images) async {
    //初始化SharedPreferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo'); //获取持久化存储的值
    //判断cartString是否为空，为空说明是第一次添加，或者被key被清除了。
    //如果有值进行decode操作
    var temp = cartString == null ? [] : json.decode(cartString);
    //把获得值转变成List
    List<Map> tempList = (temp as List).cast();
    //声明变量，用于判断购物车中是否已经存在此商品ID
    var isHave = false; //默认为没有
    int ival = 0; //用于进行循环的索引使用
    allPrice = 0;
    allGoodsCount = 0; //把商品总数量设置为0
    tempList.forEach((item) {
      //进行循环，找出是否已经存在该商品
      //如果存在，数量进行+1操作
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        tempList[ival]['isCheck'] = true;
        cartList[ival].count++;
        isHave = true;
      }
      if (item['isCheck']) {
        allPrice = NumUtil.add(
            allPrice, NumUtil.multiply(item['count'], item['price']));
        allGoodsCount +=
            item['count'] is int ? item['count'] : item['count'].toInt();
      }
      ival++;
    });
    //  如果没有，进行增加
    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true //是否已经选择
      };
      allPrice = NumUtil.add(
          allPrice, NumUtil.multiply(newGoods['count'], newGoods['price']));
      allGoodsCount += newGoods['count'] is int
          ? newGoods['count']
          : newGoods['count'].toInt();
      tempList.add(newGoods);
      cartList.add(new CartInfoMode.fromJson(newGoods));
    }
    //把字符串进行encode操作，
    cartString = json.encode(tempList);
    prefs.setString('cartInfo', cartString); //进行持久化
    notifyListeners();
  }

  show() async {}

  //得到购物车中的商品
  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //获得购物车中的商品,这时候是一个字符串
    cartString = prefs.getString('cartInfo');
    //把cartList进行初始化，防止数据混乱
    cartList = [];
    //判断得到的字符串是否有值，如果不判断会报错
    if (cartString == null) {
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cartString) as List).cast();
      allPrice = 0;
      allGoodsCount = 0;
      tempList.forEach((item) {
        // item['isCheck'] = !item['isCheck'];
        if (item['isCheck']) {
          allPrice = NumUtil.add(
              allPrice, NumUtil.multiply(item['count'], item['price']));
          allGoodsCount +=
              item['count'] is int ? item['count'] : item['count'].toInt();
        }
        cartList.add(CartInfoMode.fromJson(item));
      });
    }
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print('delete');
    prefs.remove('cartInfo');
    notifyListeners();
  }

  //删除单个购物车商品
  deleteOneGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString) as List).cast();

    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(delIndex);
    cartString = json.encode(tempList);
    prefs.setString('cartInfo', cartString); //
    await getCartInfo();
  }

  changeCheckState(CartInfoMode cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo'); //得到持久化的字符串
    List<Map> tempList =
        (json.decode(cartString) as List).cast(); //声明临时List，用于循环，找到修改项的索引
    int tempIndex = 0; //循环使用索引
    int changeIndex = 0; //需要修改的索引
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        //找到索引进行复制
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    // cartItem.isCheck = !cartItem.isCheck;
    tempList[changeIndex] = cartItem.toJson(); //把对象变成Map值
    cartString = json.encode(tempList); //变成字符串
    prefs.setString('cartInfo', cartString); //进行持久化
    await getCartInfo(); //重新读取列表
  }

  addOrReduceAction(CartInfoMode cartItem, String todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString); //
    await getCartInfo();
  }
}

mixin isCheck {}
