import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:mvvm/model/user_model.dart';
import 'package:mvvm/repository/auth_repository.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import '../utils/routes/routes_name.dart';
import '../utils/until.dart';

class AuthViewModel with ChangeNotifier {

  final myRepository = AuthRepository();

  bool _loading = false;
  bool get loading => _loading;


  setLoading(bool value){
    _loading = value;
    notifyListeners();
  }

  bool _signUploading = false;
  bool get signUploading => _signUploading;

  setSignUpLoading(bool value){
    _signUploading = value;
    notifyListeners();
  }


  Future<void>loginApi(dynamic data, BuildContext context)async {
    
    setLoading(true);
    myRepository.loginApi(data).then((value){

      setLoading(false);
      final userPreference =Provider.of<UserViewModel>(context,listen: false);
      userPreference.saveUser(
          UserModel(
             token: value['token'].toString(),
      ));

      Until.flushBarErrorMessage('Login Successfully', context);
      Navigator.pushNamed(context,RoutesName.home);
      if(kDebugMode){
        print(value.toString());
      }

    }).onError((error, stackTrace){
      setLoading(false);
      if(kDebugMode){
        Until.flushBarErrorMessage(error.toString(), context);
      }
    });

  }

  Future<void>signUpApi(dynamic data, BuildContext context)async {

    setSignUpLoading(true);
    myRepository.registerApi(data).then((value){

      setSignUpLoading(false);
      Until.flushBarErrorMessage('SignUp Successfully', context);
      Navigator.pushNamed(context,RoutesName.home);
      if(kDebugMode){
        print(value.toString());
      }

    }).onError((error, stackTrace){
      setSignUpLoading(false);
      if(kDebugMode){
        Until.flushBarErrorMessage(error.toString(), context);
      }
    });

  }
}