import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/bloc/cubit.dart';
import 'package:news_app/bloc/states.dart';
import 'package:news_app/shared/constants/constants.dart';
import 'bloc/blocObserver.dart';
import 'homeLayOut/homeLayOut.dart';
import 'shared/network/local/cachedHelper.dart';
import 'shared/network/remote/dioHelper.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CachedHelper.init();
  bool isLight  = await CachedHelper.getDate('isLight');
  runApp(MyApp(isLight:isLight));
}

class MyApp extends StatelessWidget {
  final bool isLight ;
  MyApp({this.isLight});
  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
      providers: [
        BlocProvider<NewsCubit>(
          create: (context) => NewsCubit()..changeBrightnessMode(isLight: isLight),
        ),
        BlocProvider<NewsCubit>(
          create: (context) => NewsCubit()..getData(),
        ),
      ],
      child: BlocConsumer<NewsCubit , NewsStates>(
        listener: (context , state){
          if (state is ChangeColorMode){
            print('State Form Main ==>' + ChangeColorMode().mode.toString());
          }
        },
         builder: (context , state){
           return MaterialApp(
             debugShowCheckedModeBanner: false,
             theme: ThemeData(
               primaryColor: Colors.deepOrangeAccent,
               primarySwatch: Colors.deepOrange,
               floatingActionButtonTheme: FloatingActionButtonThemeData(
                   backgroundColor: Colors.deepOrangeAccent
               ),
               scaffoldBackgroundColor: Colors.white,
               iconTheme: IconThemeData(
                 color : Colors.black,
               ),
               appBarTheme: AppBarTheme(
                 titleTextStyle: TextStyle(
                     color : Colors.black,
                     fontSize : 20.0 ,
                     fontWeight: FontWeight.w700
                 ),
                 elevation: 0.0 ,
                 color: Colors.white,
                 iconTheme: IconThemeData(
                     color: Colors.black54
                 ),
                 backwardsCompatibility: false,
                 systemOverlayStyle: SystemUiOverlayStyle(
                     statusBarColor: Colors.deepOrangeAccent,
                     statusBarIconBrightness: Brightness.light,

                 ) ,
               ),
               bottomNavigationBarTheme: BottomNavigationBarThemeData(
                   type: BottomNavigationBarType.fixed,
                   showSelectedLabels: false ,
                   showUnselectedLabels: false,
                   selectedItemColor: Colors.deepOrangeAccent
               ),
               textTheme: TextTheme(
                   bodyText1: TextStyle(
                     color: Colors.black,
                     fontWeight: FontWeight.w600,
                     fontSize: 16.0,
                     fontFamily: 'Amiri-Regular',
                   )
               ),
             ),
             darkTheme: ThemeData(
               textTheme: TextTheme(
                   bodyText1: TextStyle(
                     color: Colors.white,
                     fontWeight: FontWeight.w600,
                     fontSize: 16.0,
                     fontFamily: 'Amiri-Regular',
                   )
               ),
               primaryColor: Colors.deepOrangeAccent,
               primarySwatch: Colors.deepOrange,
               scaffoldBackgroundColor: HexColor('2D2D31'),
               appBarTheme: AppBarTheme(
                   backgroundColor: Colors.black38,
                   titleTextStyle: TextStyle(color : Colors.deepOrangeAccent),
                   actionsIconTheme: IconThemeData(color : Colors.deepOrangeAccent)
               ),
               bottomNavigationBarTheme: BottomNavigationBarThemeData(
                   type: BottomNavigationBarType.fixed,
                   showSelectedLabels: false ,
                   showUnselectedLabels: false,
                   selectedItemColor: Colors.deepOrangeAccent,
                   backgroundColor: Colors.black38,
                   unselectedIconTheme: IconThemeData(
                       color : Colors.grey
                   )
               ),

             ),
             themeMode: BlocProvider.of<NewsCubit>(context).lightMode ? ThemeMode.light : ThemeMode.dark,
             home: HomeLayOut(),
           );
         },
      ),
    );

  }
}
