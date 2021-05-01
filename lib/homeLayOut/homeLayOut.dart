import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/bloc/cubit.dart';
import 'package:news_app/bloc/states.dart';
import 'package:news_app/modules/search/searchScreen.dart';


class HomeLayOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {
      if (state == NewsBusinessErrorState()) {
        print(NewsBusinessErrorState().error.toString());
      }
      if (state == NewsScienceErrorState()) {
        print(NewsBusinessErrorState().error.toString());
      }
      if (state == NewsSportsErrorState()) {
        print(NewsBusinessErrorState().error.toString());
      }
    }, builder: (context, state) {
      var cubit = NewsCubit.get(context);

      return SafeArea(
          child: Scaffold(
              extendBodyBehindAppBar: true,
              extendBody: true,
              appBar: AppBar(
                title: Text('News App',
                    style: TextStyle(
                    )),
                actions: [
                  IconButton(
                      icon: Icon(
                          Icons.search,
                       ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SearchScreen()));
                      }),
                  IconButton(
                      icon: Icon(
                          Icons.brightness_4_outlined,
                      ),
                      onPressed: () async {
                        cubit.changeBrightnessMode();
                      }),
                ],
              ),
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 20.0),
                child: Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color:cubit.lightMode?Colors.white: Colors.black45,
                      boxShadow: [
                        BoxShadow(
                            color: cubit.lightMode? Colors.grey[200]:Colors.black26,
                            spreadRadius: 3.0,
                            offset: Offset(0, 3),
                            blurRadius: 4)
                      ]),
                  child: BottomNavigationBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                    items: cubit.navigationItems,
                    currentIndex: cubit.navigationCurrentIndex,
                    onTap: (index) {
                      cubit.changeNavigationIndex(index);
                    },
                  ),
                ),
              ),
              body: cubit.bodyWidgets[cubit.navigationCurrentIndex]));
    });
  }
}
