import 'package:conditional/conditional.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/cubit.dart';
import 'package:news_app/bloc/states.dart';
import 'package:news_app/modules/widgetHelper/articleItem.dart';
import 'package:news_app/modules/widgetHelper/defaultTextFormField.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit , NewsStates >(
       listener: (context , state){},
       builder: (context , state){
         var cubit = NewsCubit.get(context);
         return SafeArea(
             child: Scaffold(
                 appBar: AppBar(
                   title : Text('Search')
                 ),
                 body: Column(children: [
                   Padding(
                     padding : EdgeInsets.all(20.0),
                     child: defaultFormField(
                       'Search', // label
                       'Search', // hint
                         (value) {
                         // validator
                         if (value.isEmpty) {
                           return 'the field cont be empty';
                         }
                       },
                       (String value) {
                         NewsCubit.get(context).getSearchNews(value);
                       },
                       Icons.search
                     ),
                   ),
                   Expanded(
                     child: Padding(
                       padding: const EdgeInsets.all(10.0),
                       child: Conditional(
                         condition: cubit.searchNews.length > 0 ,
                         onConditionFalse: Center(),
                         onConditionTrue: ListView.builder(
                             itemCount: cubit.searchNews.length,
                             itemBuilder: (context , index){
                               return articleItem(cubit.searchNews[index]['title'] , cubit.searchNews[index]['publishedAt'] , cubit.searchNews[index]['urlToImage'], cubit.searchNews[index]['url'],context);
                             }),
                       ),
                     ),
                   ),
                 ])));
       },
    );
  }
}
