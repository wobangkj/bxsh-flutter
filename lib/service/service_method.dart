import 'package:dio/dio.dart';
// import 'package:oktoast/oktoast.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

Future request(url, formData) async {
  try {
    Response response;
    Dio dio = new Dio();
    dio.options.contentType =
        ContentType.parse('application/x-www-form-urlencoded').toString();
    dio.options.responseType = ResponseType.json;
    if (formData == null) {
      response = await dio.post(url, data: formData);
    } else {
      response = await dio.post(url, data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('异常');
    }
  } catch (e) {
    print(e);
  }
}

// 获取首页主题内容

Future getHomePageContent(formData) async {
  return await request(servicePath['homePageContent'], formData);
}

// 获取火爆撞去
Future getHomePageBlow(formData) async {
  return await request(servicePath['homePageBelowContent'], formData);
}

// 大分类
Future getCategory(formData) async {
  return await request(servicePath['getCategory'], formData);
}

// 小分类
Future getMallGoods(formData) async {
  return await request(servicePath['getMallGoods'], formData);
}

// 商品详情
Future getGoodDetailById(formData) async {
  return await request(servicePath['getGoodDetailById'], formData);
}
