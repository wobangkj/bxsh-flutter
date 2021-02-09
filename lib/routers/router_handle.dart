import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import '../pages/details_page.dart';

Handler usersHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  String goodsId = (params["id"][0]);
  return DetailsPage(goodsId);
});
