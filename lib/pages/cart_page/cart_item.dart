import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_shop/provide/cart.dart';
import 'package:provider/provider.dart';
import '../../model/cartInfo.dart';
import './cart_count.dart';

class CartItem extends StatelessWidget {
  final CartInfoMode item;
  CartItem(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border:
              Border(bottom: BorderSide(width: 1.w, color: Colors.black12))),
      child: Row(
        children: <Widget>[
          _cartCheckBt(item, context),
          _cartImage(item),
          _cartGoodsName(item),
          _cartPrice(item, context)
        ],
      ),
    );
  }

  //多选按钮
  Widget _cartCheckBt(item, BuildContext context) {
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool val) {
          item.isCheck = val;
          context.read<CartProvide>().changeCheckState(item);
        },
      ),
    );
  }

  //商品图片
  Widget _cartImage(item) {
    return Container(
      width: 150.w,
      padding: EdgeInsets.all(3.w),
      decoration:
          BoxDecoration(border: Border.all(width: 1.w, color: Colors.black12)),
      child: Image.network(item.images),
    );
  }

  //商品名称
  Widget _cartGoodsName(item) {
    return Container(
      width: 300.w,
      padding: EdgeInsets.all(10.w),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[Text(item.goodsName), CartCount(item)],
      ),
    );
  }

  //商品价格
  Widget _cartPrice(item, context) {
    return Container(
      width: 150.w,
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'),
          Container(
            child: InkWell(
              onTap: () {
                Provider.of<CartProvide>(context, listen: false)
                    .deleteOneGoods(item.goodsId);
              },
              child: Icon(
                Icons.delete_forever,
                color: Colors.black26,
                size: 30,
              ),
            ),
          )
        ],
      ),
    );
  }
}
