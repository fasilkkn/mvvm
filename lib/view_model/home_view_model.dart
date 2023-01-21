

 import 'package:flutter/cupertino.dart';
import 'package:mvvm/data/response/api_response.dart';
import 'package:mvvm/model/movie_model.dart';
import 'package:mvvm/repository/home_repository.dart';

class HomeViewModel with ChangeNotifier{

 final myRepository = HomeRepository();

 ApiResponse<MovieListModel>moviesList =ApiResponse.loading();

 setMoviesList(ApiResponse<MovieListModel> response){
  moviesList = response;
  notifyListeners();
 }

 Future<void>fetchMovieListApi()async{

  setMoviesList(ApiResponse.loading());

  myRepository.movieList().then((value){
   setMoviesList(ApiResponse.completed(value));
  }).onError((error, stackTrace){
   setMoviesList(ApiResponse.error(error.toString()));
  });
 }
 }