import 'package:flutter/material.dart';
import 'package:mvvm/view_model/services/splash_service.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  SplashService splashService = SplashService();

  @override
  void initState() {
    super.initState();
    splashService.checkAuthentication(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Splash Screen',style: Theme.of(context).textTheme.headline4,),),
    );
  }
}
