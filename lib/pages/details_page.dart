import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provide/detail_info.dart';
import './details_page/details_top_area.dart';
import './details_page/details_explain.dart';
import './details_page/details_tabbar.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId;
  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          ),
          title: Text('商品详情页'),
        ),
        body: ChangeNotifierProvider(
          create: (_) => DetailInfoProvider(),
          builder: (context, child) => FutureBuilder(
              future: _getBackInfo(context),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    child: Column(
                      children: [
                        DetailsTopArea(context),
                        DetailsExplain(),
                        DetailsTabBar()
                      ],
                    ),
                  );
                } else {
                  return Text('加载中');
                }
              }),
        ));
  }

  Future _getBackInfo(BuildContext context) async {
    await context.read<DetailInfoProvider>().getGoodsInfo(goodsId);
    return '完成';
  }
}
