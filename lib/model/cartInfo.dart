class CartInfoMode {
  String goodsId;
  String goodsName;
  double count;
  double price;
  String images;
  bool isCheck;

  CartInfoMode(
      {this.goodsId, this.goodsName, this.count, this.price, this.images});

  CartInfoMode.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    goodsName = json['goodsName'];
    count = json['count'] is int ? json['count'].toDouble() : json['count'];
    price = json['price'] is int ? json['price'].toDouble() : json['price'];
    images = json['images'];
    isCheck = json['isCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['count'] = this.count;
    data['price'] = this.price;
    data['images'] = this.images;
    data['isCheck'] = this.isCheck;
    return data;
  }
}
