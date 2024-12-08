import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_app/Routes/routes_name.dart';
import 'package:news_app/screens/categories_screen.dart';
import 'package:news_app/screens/home_screen.dart';
import 'package:news_app/screens/splash_screen.dart';

class Routes{

  static Route<dynamic>generatesRoutes(RouteSettings setting){
    setting.arguments;
    switch(setting.name){
      case RoutesName.homecreen:
        return MaterialPageRoute(builder: (BuildContext context)=>HomeScreen());
      case RoutesName.splashscreen:
        return MaterialPageRoute(builder: (BuildContext context)=>SplashScreen());
      case RoutesName.categoriescreen:
        return MaterialPageRoute(builder: (BuildContext context)=>CategoriesScreen());
      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(
              child: Text('No routes defined'),
            ),
          );
        });
    }

  }

}