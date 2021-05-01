import 'package:flutter/material.dart';
import 'package:news_app/modules/webView/webView.dart';

Widget articleItem( title , date , image , url , context  ){
  return InkWell(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> WebViewScreen(url: url)));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric( vertical: 10.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 160,
            height: 130,
            child : ClipRRect(
              borderRadius: BorderRadius.circular(5.0),
              child: FadeInImage(
                  fit: BoxFit.cover,
                  placeholder:NetworkImage('https://i.stack.imgur.com/y9DpT.jpg'),
                  image: image != null ? NetworkImage(image) : NetworkImage('https://i.stack.imgur.com/y9DpT.jpg')
              ),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(10.0),
              height: 140,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      style: Theme.of(context).textTheme.bodyText1
                    ),
                  ),
                  Text(date, style: TextStyle(fontSize: 16.0, color: Colors.grey))
                ],
              ),
            ),
          )
        ],
      ),
    ),
  );
}