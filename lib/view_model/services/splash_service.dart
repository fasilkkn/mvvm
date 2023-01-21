
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import '../../model/user_model.dart';

class SplashService{

  Future<UserModel>getUserData() =>UserViewModel().getUser();

  void checkAuthentication(BuildContext context)async{

    getUserData().then((value)async{

      if(value.token.toString() == 'null' || value.token.toString() == ''){
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.login);
      }else{
        await Future.delayed(const Duration(seconds: 3));
        Navigator.pushNamed(context, RoutesName.home);
      }
       
    }).onError((error, stackTrace){
      if(kDebugMode){
        print(error.toString());
      }
    });
  }
}