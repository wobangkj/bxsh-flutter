import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:oktoast/oktoast.dart';
import '../provide/child_category.dart';
import '../provide/category_goods_list.dart';
import '../service/service_method.dart';
import '../model/category.dart';
import '../model/categoryGoods.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('商品分类'),
        ),
        body: Container(
          child: Row(
            children: [
              _LeftCategoryNav(),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [_RightCategoryNav(), _CategoryGoodsList()],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// 左侧大类导航
class _LeftCategoryNav extends StatefulWidget {
  _LeftCategoryNav({Key key}) : super(key: key);

  @override
  __LeftCategoryNavState createState() => __LeftCategoryNavState();
}

class __LeftCategoryNavState extends State<_LeftCategoryNav> {
  List<CategoryData> list = [];
  int listIndex = 0; //索引
  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180.w,
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1.w, color: Colors.black12))),
      child: ListView.builder(
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
        itemCount: list.length,
      ),
    );
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        List<BxMallSubDto> childList = list[index].bxMallSubDto;
        context
            .read<ChildCategory>()
            .setChildCategory(childList, list[index].mallCategoryId);
      },
      child: Container(
        height: 100.h,
        padding: EdgeInsets.only(left: 10.w, top: 20.w),
        decoration: BoxDecoration(
            color: isClick ? Color.fromRGBO(236, 238, 239, 1.0) : Colors.white,
            border:
                Border(bottom: BorderSide(width: 1.w, color: Colors.black12))),
        child: Text(
          list[index].mallCategoryName,
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  void _getData() async {
    Category res = Category.fromJson(await getCategory({}));
    setState(() {
      list = res.data;
      context
          .read<ChildCategory>()
          .setChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }
}

//右侧小类类别

class _RightCategoryNav extends StatefulWidget {
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<_RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ChildCategory(),
      child: Container(
          child: Container(
              height: 80.h,
              width: 570.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(width: 1.w, color: Colors.black12))),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:
                    context.watch<ChildCategory>().childCategoryList.length,
                itemBuilder: (_, index) {
                  return _rightInkWell(index,
                      context.read<ChildCategory>().childCategoryList[index]);
                },
              ))),
    );
  }

  Widget _rightInkWell(int index, BxMallSubDto item) {
    bool isCheck =
        context.read<ChildCategory>().childIndex == index ? true : false;
    return InkWell(
      onTap: () {
        context
            .read<ChildCategory>()
            .changeChildIndex(index, context.read<ChildCategory>().categoryId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              color: isCheck ? Colors.pink : Colors.black,
              fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }
}

class _CategoryGoodsList extends StatefulWidget {
  _CategoryGoodsList({Key key}) : super(key: key);

  @override
  __CategoryGoodsListState createState() => __CategoryGoodsListState();
}

class __CategoryGoodsListState extends State<_CategoryGoodsList> {
  var scrollController = new ScrollController();
  @override
  void initState() {
    super.initState();
    _getGoodsList('4', '');
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
            width: 570.w,
            child: ChangeNotifierProvider(
              create: (_) => CategoryGoodsListProvider(),
              child: EasyRefresh(
                footer: ClassicalFooter(
                    infoColor: Colors.pink,
                    bgColor: Colors.white,
                    textColor: Colors.pink,
                    infoText: '加载中...',
                    noMoreText: "",
                    loadingText: '上拉加载'),
                child: ListView.builder(
                    itemCount: context
                        .watch<CategoryGoodsListProvider>()
                        .goodList
                        .length,
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      return _listWidget(index);
                    }),
                onLoad: () async {
                  context.read<ChildCategory>().addPage();
                  _getGoodsList('4', '',
                      page: context.read<ChildCategory>().page);
                },
              ),
            )));
  }

  Widget _goodsImage(index) {
    return Container(
      width: 200.w,
      child: Image.network(
          context.read<CategoryGoodsListProvider>().goodList[index].image),
    );
  }

  Widget _goodsName(index) {
    return Container(
      width: 370.w,
      padding: EdgeInsets.all(5.w),
      child: Text(
        context.read<CategoryGoodsListProvider>().goodList[index].goodsName,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 28.sp),
      ),
    );
  }

  Widget _goodsPrice(index) {
    return Container(
      margin: EdgeInsets.only(top: 20.w),
      width: 370.w,
      child: Row(children: [
        Text(
          '价格:￥${context.read<CategoryGoodsListProvider>().goodList[index].presentPrice}',
          style:
              TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
        ),
        Text(
            '￥${context.read<CategoryGoodsListProvider>().goodList[index].oriPrice}',
            style: TextStyle(
                color: Colors.black26, decoration: TextDecoration.lineThrough))
      ]),
    );
  }

  Widget _listWidget(int index) {
    return InkWell(
      onTap: () {
        showToast("content");
        _getGoodsList(
            context.read<CategoryGoodsListProvider>().goodList[index].goodsId,
            '');
      },
      child: Container(
        padding: EdgeInsets.only(top: 5.w, bottom: 5.w),
        decoration: BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.black12, width: 1.w))),
        child: Row(
          children: [
            _goodsImage(index),
            Column(
              children: [
                _goodsName(index),
                _goodsPrice(index),
              ],
            )
          ],
        ),
      ),
    );
  }

  void _getGoodsList(String categoryId, String categorySubId,
      {int page = 1}) async {
    if (page == 3) {
      scrollController.jumpTo(0.0);
    }

    Map payload = {
      'categoryId': categoryId == null ? '4' : categoryId,
      'categorySubId': categorySubId,
      'page': page
    };
    CategoryGoods res = CategoryGoods.fromJson(await getMallGoods(payload));
    context
        .read<CategoryGoodsListProvider>()
        .setGoodList(res.data == null ? [] : res.data);
  }
}
