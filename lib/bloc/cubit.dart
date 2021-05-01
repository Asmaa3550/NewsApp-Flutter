import 'package:flutter/material.dart';
import 'package:news_app/modules/business/businessScreen.dart';
import 'package:news_app/modules/science/scienceScreen.dart';
import 'package:news_app/modules/sports/sportsScreen.dart';
import 'package:news_app/shared/network/local/cachedHelper.dart';
import 'package:news_app/shared/network/remote/dioHelper.dart';

import'states.dart';
import'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit() : super(NewsInitialState());

  int navigationCurrentIndex = 0 ;
  bool lightMode = true ;

  List<BottomNavigationBarItem> navigationItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business) , label: 'xn z'),
    BottomNavigationBarItem(icon: Icon(Icons.sports_basketball) , label: 'knxbk'),
    BottomNavigationBarItem(icon: Icon(Icons.science) , label: 'kjn'),
  ];
  List bodyWidgets= [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen()
  ];
  List<dynamic> businessNews = [] ;
  List<dynamic> sportsNews = [] ;
  List<dynamic> scienceNews = [] ;
  List<dynamic> searchNews = [] ;



  static NewsCubit get(context) => BlocProvider.of(context); // obj of Class .

  void changeBrightnessMode ({bool isLight}) async {

    if (isLight != null )
      lightMode= isLight ;
    else
      lightMode= !lightMode ;

    print('mode light => ' + lightMode.toString());
    await CachedHelper.putDate('isLight', lightMode).then((value) {
      emit(ChangeColorMode(mode: lightMode));
    });

  }
  void changeNavigationIndex (int currentIndex){
    navigationCurrentIndex = currentIndex ;
    emit(NewsBottomNavigation());
  }

  void getBusinessNews(){
      emit(NewsBusinessLoadingState());
      DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country' : 'eg' ,
          'category' : 'business' ,
          'apiKey' : '034f1aae2bc44f3ca76f5553a53454c6'
        }).then((value){

      businessNews = (value.data['articles']);
     emit(NewsBusinessSuccessState());
    }).catchError((error){
      print('Error ==>'+ error.toString());
      emit(NewsBusinessErrorState(error: error.toString()));
    });
  }
  void getSportsNews(){
    emit(NewsSportsLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country' : 'eg' ,
          'category' : 'sports' ,
          'apiKey' : '034f1aae2bc44f3ca76f5553a53454c6'
        }).then((value){

      sportsNews = (value.data['articles']);
      emit(NewsSportsSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsSportsErrorState(error: error.toString()));
    });
  }
  void getScienceNews(){
    emit(NewsScienceLoadingState());
    DioHelper.getData(
        url: 'v2/top-headlines',
        query: {
          'country' : 'eg' ,
          'category' : 'science' ,
          'apiKey' : '034f1aae2bc44f3ca76f5553a53454c6'
        }).then((value){

      scienceNews = (value.data['articles']);
      emit(NewsScienceSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsScienceErrorState(error: error.toString()));
    });
  }
  void getData (){
    getBusinessNews();
    getSportsNews();
    getScienceNews();
  }

  void getSearchNews (String query) {
      if (query != ''){
        print(query);
        emit(SearchNewsLoadingState());
        DioHelper.getData(
            url: 'v2/everything',
            query: {
              'q' : '$query' ,
              'apiKey' : '034f1aae2bc44f3ca76f5553a53454c6'
            }).then((value) {
          searchNews = value.data['articles'] ;
          emit(SearchNewsSuccessState(news: searchNews));
        }).catchError((error){
          emit(SearchNewsErrorState(error: error));
        });
      }
    }

}