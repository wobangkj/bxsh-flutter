import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:oktoast/oktoast.dart';
import 'package:fluro/fluro.dart';
import './provide/Counter.dart';
import './provide/child_category.dart';
import './provide/category_goods_list.dart';
// import './provide/detail_info.dart';
import './pages/index_page.dart';
import './routers/application.dart';
import './routers/routers.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => Counter()),
      ChangeNotifierProvider(create: (_) => ChildCategory()),
      ChangeNotifierProvider(create: (_) => CategoryGoodsListProvider()),
      // ChangeNotifierProvider(create: (_) => DetailInfoProvider()),
    ], child: MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final router = FluroRouter();
    Routers.configureRouters(router);
    Application.router = router;

    return Container(
        child: ScreenUtilInit(
      designSize: Size(750, 1334),
      allowFontScaling: false,
      child: OKToast(
        child: MaterialApp(
          title: '百姓生活+',
          onGenerateRoute: Application.router.generator,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(primaryColor: Colors.pink),
          home: IndexPage(),
        ),
      ),
    ));
  }
}
