import 'package:flutter/material.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view/login_screen.dart';
import 'package:mvvm/view/register_screen.dart';
import 'package:mvvm/view/splash_screen.dart';
import '../../view/home_screen.dart';

class Routes{

  static Route<dynamic> generateRoute(RouteSettings settings){

    switch (settings.name){

      case RoutesName.splash:
        return MaterialPageRoute(builder: (BuildContext context)=>const Splash());

      case RoutesName.home:
        return MaterialPageRoute(builder: (BuildContext context)=>const HomeScreen());

      case RoutesName.login:
        return MaterialPageRoute(builder: (BuildContext context)=>const LoginScreen());

      case RoutesName.signUp:
        return MaterialPageRoute(builder: (BuildContext context)=>const RegisterScreen());


      default:
        return MaterialPageRoute(builder: (_){
          return const Scaffold(
            body: Center(child: Text('No Route defined'),
            ),
          );
        });
    }
  }
}