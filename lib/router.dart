import 'package:armpet_wash_mobile/goods_page.dart';
import 'package:armpet_wash_mobile/order_page.dart';
import 'package:armpet_wash_mobile/setup_Page.dart';
import 'package:armpet_wash_mobile/splash_page.dart';
import 'package:flutter/material.dart';

import 'dashboard_page.dart';
import 'fr/goods.dart';
import 'login_page.dart';

Route<dynamic>? generateRoute(RouteSettings settings) {
  final args = settings.arguments;
  switch (settings.name) {
    case '/':
      return MaterialPageRoute(builder: (_) => SplashPage());
    case '/login':
      return MaterialPageRoute(builder: (_) => LoginPage());
    case '/home':
      return MaterialPageRoute(builder: (_) => Dashboard());
    case '/setup':
      return MaterialPageRoute(builder: (_) => SetupPage());
    case '/order':
      return MaterialPageRoute(builder: (_) => OrderPage(tableId: args as int));
    case '/goods':
      return MaterialPageRoute<Goods?>(builder:  (_) => GoodsPage());
    default:
      return MaterialPageRoute(
        builder:
            (_) => Scaffold(
              body: Center(
                child: Text('No route defined for ${settings.name}'),
              ),
            ),
      );
  }
}
