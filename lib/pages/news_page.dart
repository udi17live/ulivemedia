import 'package:flutter/material.dart';
import 'package:ulivemedia/services/database_services.dart';
import 'package:flutter_html/flutter_html.dart';

class NewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: services.getAllNews(),
      builder: (BuildContext context, AsyncSnapshot snapshot){
        
        if(snapshot.hasData){
           String data = snapshot.data[0]['content'].toString();
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                
                Text(snapshot.data[0]['title']),
                Text('short desc:'),
                Text(snapshot.data[0]['short']),
                Text('Last Updated:'),
                Text(snapshot.data[0]['updated_at'].toString()),
                Text('tags:'),
                Text(snapshot.data[0]['tags']),
                Text('content: '),
                Html(data: data, onLinkTap: (url){
                  print("Opening $url...");
                }, ),
              ],
            ),
          );

          /* return ListView.builder(
            
            itemCount: 1,
            itemBuilder: (BuildContext context, int index){
              String data = snapshot.data[index]['content'].toString();
              return Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      snapshot.data[0].
                    ],
                  ),
                ),
              );
            }
          ); */
        }else{
          return Center(child: CircularProgressIndicator(),);
        }
      },
    );
  }
}