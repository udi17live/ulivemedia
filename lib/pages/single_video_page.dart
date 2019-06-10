import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:ulivemedia/widgets/chewie_video_controller_item.dart';

class SingleVideoPage extends StatefulWidget {
  final DocumentSnapshot snapshot;

  SingleVideoPage(this.snapshot);

  @override
  _SingleVideoPageState createState() => _SingleVideoPageState();
}

class _SingleVideoPageState extends State<SingleVideoPage> {
  

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.snapshot['video_title'],
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold,
              fontSize: 18),
        ),
        elevation: 0.0,
        actions: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20.0)),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                child: Text(widget.snapshot['video_episode'],
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold)),
              ),
            ),
          ),
        ],
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              FontAwesomeIcons.arrowLeft,
              color: Theme.of(context).primaryColor,
            )),
      ),
      body: CustomScrollView(slivers: <Widget>[
        SliverList(
            delegate: SliverChildListDelegate([
         
         // YOUTUBE PLAYER
          ChewieVideoItem(
            looping: true,
            videoPlayerController: VideoPlayerController.network(
              widget.snapshot['url'],

            ),
          ),


         //END OF PLAYER

          Container(
            padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
            height: 200,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.snapshot['video_title'],
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(children: <Widget>[
                    SizedBox(
                      width: 2.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFFB3A3A),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Text(
                          widget.snapshot['video_duration'],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 2.0,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xFF00C824),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Text(
                          widget.snapshot['video_category'],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ]),
                  SizedBox(height: 2.0),
                  Row(children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          color: Color(0xFFC800BC),
                          borderRadius: BorderRadius.circular(20.0)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 5.0),
                        child: Text(
                          widget.snapshot['video_published_on'],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ]),
                ]),
          ),
        ])),
        SliverFillRemaining(
          child: Text(widget.snapshot['video_description']),
        ),
      ]),
    );
  }
}
