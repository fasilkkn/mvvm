
import 'package:mvvm/data/network/base_api_service.dart';
import 'package:mvvm/res/app_url.dart';
import '../data/network/network_api_services.dart';
import '../model/movie_model.dart';

class HomeRepository{


  BaseApiServices apiServices = NetworkApiServices();

  Future<MovieListModel>movieList()async{

    try{
      dynamic response = await apiServices.getAPiResponse(AppUrl.movieListEndPointUrl);
      return response = MovieListModel.fromJson(response);

    }catch(e){
      throw e;
    }
  }
}