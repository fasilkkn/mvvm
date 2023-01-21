
import 'package:mvvm/data/network/base_api_service.dart';
import 'package:mvvm/data/network/network_api_services.dart';
import 'package:mvvm/res/app_url.dart';

class AuthRepository{

   BaseApiServices apiServices = NetworkApiServices();


   Future<dynamic> loginApi(dynamic data)async{
     try{
       dynamic response = await apiServices.postAPiResponse(AppUrl.loginEndPointUrl, data);
       return response;
     }catch(e){
       throw e;
     }
   }



   Future<dynamic> registerApi(dynamic data)async{
     try{
       dynamic response = await apiServices.postAPiResponse(AppUrl.registerEndPointUrl, data);
       return response;
     }catch(e){
       throw e;
     }
   }
}