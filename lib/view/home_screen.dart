import 'package:flutter/material.dart';
import 'package:mvvm/data/response/status.dart';
import 'package:mvvm/utils/routes/routes_name.dart';
import 'package:mvvm/view_model/home_view_model.dart';
import 'package:mvvm/view_model/user_view_model.dart';
import 'package:provider/provider.dart';
import '../utils/until.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeViewModel homeViewModel =HomeViewModel();

  @override
  void initState() {
    homeViewModel.fetchMovieListApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userPreference =Provider.of<UserViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions:[
          Padding(
            padding: const EdgeInsets.only(right: 28.0),
            child: InkWell(
                onTap: (){
                  userPreference.remove().then((value){
                    Navigator.pushNamed(context,RoutesName.login);
                  });
                },
                child: Center(child: Text('logout'))),
          ),
        ],
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create: (BuildContext context)=>homeViewModel,
        child: Consumer<HomeViewModel>(
          builder: (context,value,_){

            switch(value.moviesList.status){
              case Status.Loading:
                return Center(child: const CircularProgressIndicator());

              case Status.Error:
                return  Center(child: Text(value.moviesList.message.toString()));

              case Status.Completed:
                return ListView.builder(
                  itemCount: value.moviesList.data!.movies!.length,
                  itemBuilder: (
                      BuildContext context, int index){
                    return Card(
                      child: ListTile(
                        leading: Image.network(value.moviesList.data!.movies![index].posterurl.toString(),
                          errorBuilder: (context,error,stack){
                          return const Icon(Icons.error,color: Colors.red);
                          },
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        ),
                        title: Text(value.moviesList.data!.movies![index].title.toString()),
                        subtitle:  Text(value.moviesList.data!.movies![index].year.toString()),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(Until.averageRating(value.moviesList.data!.movies![index].ratings!).toStringAsFixed(1)),
                            Icon(Icons.star,color: Colors.yellow,),
                          ],
                        ),
                      ),
                    );
                  },

                );
            }
            return Container();
          },
        ),
      )
    );
  }
}
