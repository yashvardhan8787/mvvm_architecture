import "package:flutter/cupertino.dart";
import  "package:flutter/material.dart";
import "package:mvvm_architecture/utils/routes/routes_names.dart";
import "package:mvvm_architecture/view_model/home_view_model.dart";
import "package:mvvm_architecture/view_model/user_view_model.dart";
import "package:provider/provider.dart";

import "../data/response/status.dart";
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  HomeViewModel homeViewModel  = HomeViewModel();

  @override
  void initState(){
    super.initState();
    homeViewModel.fetchProductsListApi();
  }

  @override
  Widget build(BuildContext context) {
    final userPrefrences= Provider.of<UserViewModel>(context);
    return  Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
        backgroundColor: Colors.blue,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: (){
                  userPrefrences.remove().then((value){
                    Navigator.pushNamed(context, RoutesNames.login);
                  });
                },
                child: Text("LogOut")),
          ),

        ],
      ),
      body: ChangeNotifierProvider<HomeViewModel>(
        create:(BuildContext context) => homeViewModel,
        child: Consumer<HomeViewModel>(
          builder: (context, value, child) {
            switch(value.productList.status){
              case Status.LOADING:
                return CircularProgressIndicator();
              case Status.ERROR:
                return Center(
                  child: Text(value.productList.message.toString()),
                );

              case Status.COMPLETED:
                return ListView.builder(
                  itemCount:value.productList.data!.products!.length,
                  itemBuilder: (context, index) {

                  return Card(
                    child:ListTile(
                      title: Text(value.productList.data!.products![index].title.toString()),
                      subtitle: Text(value.productList.data!.products![index].category.toString()),
                      leading: Image.network(value.productList.data!.products![index].thumbnail.toString(),
                      height: 40,
                      width: 40,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error,color:Colors.red,);
                      },
                      ),
                      trailing: Row(
                        children: [
                        Text(value.productList.data!.products![index].rating.toString()),
                          Icon(Icons.star,color: Colors.amberAccent)
                    
                      ],
                    ),
                    ),
                  );
                },);
              default:
                return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
