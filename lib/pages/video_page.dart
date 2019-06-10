import 'package:flutter/material.dart';
import 'package:ulivemedia/pages/category_videos.dart';
import 'package:ulivemedia/pages/single_video_page.dart';
import 'package:ulivemedia/services/database_services.dart';

class VideoPage extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey2 =
      new GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey2,
      onRefresh: setTitles,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text('Categories',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),
              ),
              Container(
                height: 100.0,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CategoryPage('Giants of Aviation')));
                      },
                      splashColor: Colors.white.withOpacity(0.4),
                      child: Card(
                        semanticContainer: true,
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/categories/goa.png'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CategoryPage('Airline Alliances')));
                      },
                      splashColor: Colors.white.withOpacity(0.4),
                      child: Card(
                        semanticContainer: true,
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image: AssetImage('assets/categories/aa.png'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CategoryPage('Top Ten Aviation')));
                      },
                      splashColor: Colors.white.withOpacity(0.4),
                      child: Card(
                        semanticContainer: true,
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/categories/tta.png'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CategoryPage('Spotters Eye Episodes')));
                      },
                      splashColor: Colors.white.withOpacity(0.4),
                      child: Card(
                        semanticContainer: true,
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/categories/see.png'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CategoryPage('FSX Aviation')));
                      },
                      splashColor: Colors.white.withOpacity(0.4),
                      child: Card(
                        semanticContainer: true,
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/categories/fsx.png'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CategoryPage('Other Aviation')));
                      },
                      splashColor: Colors.white.withOpacity(0.4),
                      child: Card(
                        semanticContainer: true,
                        child: Container(
                          width: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                  image:
                                      AssetImage('assets/categories/ota.png'),
                                  fit: BoxFit.cover)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text('All Videos',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),
              ),
            ]),
          ),
          /* FutureBuilder(
            future: services.getHomeDataFeatured(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                return _buildVideoWidget(snapshot);
              }else{
                return CircularProgressIndicator();
              }
            },
          ) */

          SliverFillRemaining(
            child: FutureBuilder(
              future: services.getAllVideos(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return _buildVideoWidget(snapshot);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Future<Null> setTitles() async {
    services.getAllVideos();
  }

  Widget _buildVideoWidget(AsyncSnapshot snapshot) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                        SingleVideoPage(snapshot.data[index])));
          },
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
            child: Card(
              color: Colors.transparent,
              semanticContainer: true,
              borderOnForeground: true,
              child: Container(
                width: MediaQuery.of(context).size.width * .92,
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    image: DecorationImage(
                        image: NetworkImage(
                          '${snapshot.data[index]['video_thumbnail_url']}',
                        ),
                        fit: BoxFit.cover)),
                child: Container(
                  child: Stack(children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.transparent,
                              Color(0xFF010F35).withOpacity(.5),
                              Color(0xFF010F35),
                            ]),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFFFB3A3A),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Text(
                                    snapshot.data[index]['video_episode'],
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    color: Color(0xFF006DB5),
                                    borderRadius: BorderRadius.circular(20.0)),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10.0, vertical: 5.0),
                                  child: Text(
                                      snapshot.data[index]['video_duration'],
                                      style: TextStyle(color: Colors.white)),
                                ),
                              )
                            ],
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                            child: Text(
                              snapshot.data[index]['video_title'],
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Icon(Icons.play_circle_filled,
                          size: 70, color: Colors.white),
                    )
                  ]),
                ),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
        );
      },
    );
  }
}
