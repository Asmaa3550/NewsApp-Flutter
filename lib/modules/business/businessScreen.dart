import 'package:conditional/conditional.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/cubit.dart';
import 'package:news_app/bloc/states.dart';
import 'package:news_app/modules/widgetHelper/articleItem.dart';

class BusinessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer <NewsCubit , NewsStates>(
      listener: (context , state){},
      builder: (context , state){
        var list = NewsCubit.get(context).businessNews;
        return  Padding(
          padding: const EdgeInsets.all(10.0),
          child: Conditional(
            condition: list.length > 0 ,
            onConditionFalse: Center(child: CircularProgressIndicator()),
            onConditionTrue: ListView.builder(
                itemCount: list.length,
                itemBuilder: (context , index){
               return articleItem(list[index]['title'] , list[index]['publishedAt'] , list[index]['urlToImage'],list[index]['url'] , context);
            }),
          ),
        );
      },
    );
  }
}

