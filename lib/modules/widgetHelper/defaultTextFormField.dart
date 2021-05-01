import 'package:flutter/material.dart';

Widget defaultFormField (
    @required String label ,
    @required String  hint ,
    @required Function validator ,
    @required Function onChanged ,
    IconData prefixIcon ,

    ){
  return TextFormField(

    decoration: InputDecoration(
      prefixIcon: Icon(prefixIcon ) ,
      labelText: label,
      border: OutlineInputBorder(borderSide:BorderSide(color: Colors.grey) ),
      enabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.grey) ),
    ),
    validator: validator,
    onChanged: onChanged,

  );
}
