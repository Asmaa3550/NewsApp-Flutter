import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CachedHelper {

  static SharedPreferences sharedPreferences ;
  static CachedHelper get(context) => CachedHelper();

  static init () async {
    sharedPreferences = await SharedPreferences.getInstance();
   }

  static Future <bool> putDate (
    @required String key ,
    @required bool value
    )async{
    return await sharedPreferences.setBool('$key', value);
   }

  static Future <bool> getDate (
      @required String key ,
      )async{
    return await sharedPreferences.get('$key');
  }
}