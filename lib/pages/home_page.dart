import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import '../service/service_method.dart';
import '../routers/application.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int page = 1;
  List<Map> hotGoodsList = [];

  var formData = {'lon': '115.02932', 'lat': '35.76189'};

  String homePageContent = '正在获取数据';

  @override
  void initState() {
    // _getHotGoods();
    getHomePageContent(formData).then((value) => {
          setState(() {
            homePageContent = value.toString();
          })
        });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body: FutureBuilder(
        future: getHomePageContent(formData),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Map> swiper = (snapshot.data['data']['slides'] as List).cast();
            List<Map> navigatorList =
                (snapshot.data['data']['category'] as List).cast();
            String adPicture =
                snapshot.data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImage =
                snapshot.data['data']['shopInfo']['leaderImage'];
            String leaderPhone =
                snapshot.data['data']['shopInfo']['leaderPhone'];
            List<Map> recCommendList =
                (snapshot.data['data']['recommend'] as List).cast();
            String floor1Title =
                snapshot.data['data']['floor1Pic']['PICTURE_ADDRESS'];
            String floor2Title =
                snapshot.data['data']['floor1Pic']['PICTURE_ADDRESS'];
            String floor3Title =
                snapshot.data['data']['floor1Pic']['PICTURE_ADDRESS'];

            List<Map> floor1 = (snapshot.data['data']['floor1'] as List).cast();
            List<Map> floor2 = (snapshot.data['data']['floor2'] as List).cast();
            List<Map> floor3 = (snapshot.data['data']['floor3'] as List).cast();
            return EasyRefresh(
              footer: ClassicalFooter(
                  infoColor: Colors.pink,
                  bgColor: Colors.white,
                  textColor: Colors.pink,
                  infoText: '加载中...',
                  noMoreText: "",
                  loadingText: '上拉加载'),
              child: Column(
                children: [
                  SwiperDiy(
                    swiperDateList: swiper,
                  ),
                  TopNavigator(navigatorList: navigatorList),
                  AdBanner(adPicture: adPicture),
                  LeaderPhone(
                      leaderImage: leaderImage, leaderPhone: leaderPhone),
                  RecCommend(recCommendList: recCommendList),
                  FloorTitle(pictureAddress: floor1Title),
                  FloorContent(looorContentList: floor1),
                  FloorTitle(pictureAddress: floor2Title),
                  FloorContent(looorContentList: floor2),
                  FloorTitle(pictureAddress: floor3Title),
                  FloorContent(looorContentList: floor3),
                  _hotGoods()
                ],
              ),
              onLoad: () async {
                Map formPage = {'page': page};
                // do something to wait for 2 seconds
                await Future.delayed(const Duration(seconds: 2), () {});
                var result = await getHomePageBlow(formPage);

                List<Map> newData = (result['data'] as List).cast();
                setState(() {
                  hotGoodsList.addAll(newData);
                  page++;
                });
              },
            );
          } else {
            return Center(
              child: Text('加载中...'),
            );
          }
        },
      ),
    );
  }

  // void _getHotGoods() async {
  //   Map formPage = {'page': page};
  //   var result = await getHomePageBlow(formPage);
  //   List<Map> newData = (result['data'] as List).cast();
  //   setState(() {
  //     hotGoodsList.addAll(newData);
  //     page++;
  //   });
  // }

  Widget hotTitle = Container(
    margin: EdgeInsets.only(top: 10.w),
    alignment: Alignment.center,
    color: Colors.transparent,
    padding: EdgeInsets.all(18.w),
    child: Text('火爆专区'),
  );

  Widget _wrapList() {
    if (hotGoodsList.length != 0) {
      List<Widget> listWidget = hotGoodsList
          .map((item) => InkWell(
                onTap: () {
                  Application.router
                      .navigateTo(context, "/detail/${item['goodsId']}");
                },
                child: Container(
                  width: 372.w,
                  color: Colors.white,
                  padding: EdgeInsets.all(5.w),
                  margin: EdgeInsets.only(bottom: 3.w),
                  child: Column(
                    children: [
                      Image.network(
                        item['image'],
                        width: 370.w,
                      ),
                      Text(
                        item['name'],
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.pink, fontSize: 26.sp),
                      ),
                      Row(
                        children: [
                          Text('￥${item['mallPrice']}'),
                          Text(
                            '￥${item['price']}',
                            style: TextStyle(
                              color: Colors.black26,
                              decoration: TextDecoration.lineThrough,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ))
          .toList();
      return Wrap(
        spacing: 2,
        children: listWidget,
      );
    } else {
      return Text('');
    }
  }

  Widget _hotGoods() {
    return Container(
      child: Column(
        children: [hotTitle, _wrapList()],
      ),
    );
  }
}

class SwiperDiy extends StatelessWidget {
  final List swiperDateList;
  SwiperDiy({Key key, this.swiperDateList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 333.h,
      width: 750.w,
      child: Swiper(
        itemCount: swiperDateList.length,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              Application.router.navigateTo(
                  context, "/detail/${swiperDateList[index]['goodsId']}");
            },
            child: Image.network(
              "${swiperDateList[index]['image']}",
              fit: BoxFit.cover,
            ),
          );
        },
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

class TopNavigator extends StatelessWidget {
  final List navigatorList;
  const TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUi(BuildContext context, item) {
    return InkWell(
      onTap: () {
        print('点击率到花宫娜');
      },
      child: Container(
        child: Column(
          children: [
            Image.network(
              item['image'],
              width: 95.w,
            ),
            Text(item['mallCategoryName']),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // if (this.navigatorList.length > 10) {
    //   this.navigatorList.removeRange(10, this.navigatorList.length);
    // }
    return Container(
      height: 330.h,
      width: 750.w,
      padding: EdgeInsets.all(10.w),
      child: GridView.count(
        crossAxisCount: 2,

        scrollDirection: Axis.horizontal,
        // physics: NeverScrollableScrollPhysics(),
        // padding: EdgeInsets.all(5.w),
        // mainAxisSpacing: 30.w,
        children: navigatorList
            .map((item) => _gridViewItemUi(context, item))
            .toList(),
      ),
    );
  }
}

class AdBanner extends StatelessWidget {
  final adPicture;
  const AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

// 店长电话
class LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  const LeaderPhone({Key key, this.leaderImage, this.leaderPhone})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 30.w),
      child: InkWell(
        onTap: _launchURL,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _launchURL() async {
    String url = 'tel:' + leaderPhone;
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw '不能进行访问';
    }
  }
}

// 商品推荐
class RecCommend extends StatelessWidget {
  final recCommendList;
  const RecCommend({Key key, this.recCommendList}) : super(key: key);

  // 标题
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        '商品推荐',
        style: TextStyle(color: Colors.pink),
      ),
      padding: EdgeInsets.fromLTRB(10.w, 2.w, 0.0, 5.w),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 1.w, color: Colors.black12))),
    );
  }

  // 商品单独项
  Widget _item(context, index) {
    return InkWell(
      onTap: () {
        Application.router
            .navigateTo(context, "/detail/${recCommendList[index]['goodsId']}");
      },
      child: Container(
        height: 330.h,
        width: 250.w,
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(left: BorderSide(width: 1.w, color: Colors.black12))),
        child: Column(
          children: [
            Image.network(recCommendList[index]['image']),
            Text('￥${recCommendList[index]['mallPrice']}'),
            Text(
              '￥${recCommendList[index]['price']}',
              style: TextStyle(
                  decoration: TextDecoration.lineThrough, color: Colors.pink),
            ),
          ],
        ),
      ),
    );
  }

  // 横线列表
  Widget _recCommentList() {
    return Container(
      height: 370.h,
      margin: EdgeInsets.only(top: 10.w),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: recCommendList.length,
        itemBuilder: (BuildContext context, int index) {
          return _item(context, index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 450.h,
      margin: EdgeInsets.only(top: 10.w),
      child: Column(
        children: [_titleWidget(), _recCommentList()],
      ),
    );
  }
}

// 楼层组件
class FloorTitle extends StatelessWidget {
  final String pictureAddress;
  const FloorTitle({Key key, this.pictureAddress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      child: Image.network(pictureAddress),
    );
  }
}

// 楼层商品
class FloorContent extends StatelessWidget {
  final List looorContentList;
  const FloorContent({Key key, this.looorContentList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [_firstRow(context), _otherGoods(context)],
      ),
    );
  }

  Widget _firstRow(context) {
    return Row(
      children: [
        _goodsItem(context, looorContentList[0]),
        Column(
          children: [
            _goodsItem(context, looorContentList[1]),
            _goodsItem(context, looorContentList[2]),
          ],
        )
      ],
    );
  }

  Widget _otherGoods(context) {
    return Row(
      children: [
        _goodsItem(context, looorContentList[3]),
        _goodsItem(context, looorContentList[4]),
      ],
    );
  }

  Widget _goodsItem(BuildContext context, Map goods) {
    return Container(
      width: 375.w,
      child: InkWell(
        onTap: () {
          Application.router.navigateTo(context, "/detail/${goods['goodsId']}");
        },
        child: Image.network(goods['image']),
      ),
    );
  }
}

class HotGoods extends StatefulWidget {
  HotGoods({Key key}) : super(key: key);

  @override
  _HotGoodsState createState() => _HotGoodsState();
}

class _HotGoodsState extends State<HotGoods> {
  int page = 1;
  @override
  void initState() {
    super.initState();
    getHomePageBlow(page).then((value) => print(value));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('spang'),
    );
  }
}
