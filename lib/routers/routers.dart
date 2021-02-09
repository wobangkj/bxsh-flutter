import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handle.dart';

class Routers {
  static String root = '/';
  static String detailsPage = '/detail/:id';
  static void configureRouters(FluroRouter router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return Center(child: Text('404页面'));
    });

    router.define(detailsPage, handler: usersHandler);
  }
}
