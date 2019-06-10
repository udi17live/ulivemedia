import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ulivemedia/pages/single_video_page.dart';
import 'package:ulivemedia/services/database_services.dart';
import 'package:expandable/expandable.dart';

class CategoryPage extends StatefulWidget {
  final String category;
  CategoryPage(this.category);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  var color;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey3 =
      new GlobalKey<RefreshIndicatorState>();

  @override
  void initState() {
    //AsyncSnapshot snapshot = services.getCategoryDetails(widget.category);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey3,
      onRefresh: setTitles,
      child: FutureBuilder(
        future: services.getCategoryDetails(widget.category),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            color = Color(num.parse((snapshot.data['color'])));

            return Scaffold(
              appBar: AppBar(
                backgroundColor: color,
                elevation: 0.0,
              ),
              body: LayoutBuilder(
                builder:
                    (BuildContext context, BoxConstraints viewportConstraints) {
                  return CustomScrollView(
                    scrollDirection: Axis.vertical,
                    slivers: <Widget>[
                      SliverList(
                        delegate: SliverChildListDelegate([
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.0, vertical: 8.0),
                            width: MediaQuery.of(context).size.width,
                            color: color,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ExpandablePanel(
                                        initialExpanded: false,
                                        tapBodyToCollapse: true,
                                        header: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(snapshot.data['category'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18)),
                                        ),
                                        collapsed: Text(
                                          snapshot.data['description'],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12),
                                          softWrap: true,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        expanded: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              snapshot.data['description'],
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 12),
                                              softWrap: true,
                                            )),
                                        tapHeaderToExpand: true,
                                        hasIcon: false,
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      10.0, 15.0, 10.0, 15.0),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Column(
                                    children: <Widget>[
                                      Text(snapshot.data['videos'],
                                          style: TextStyle(
                                              color: color,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25)),
                                      Text('VIDEOS',
                                          style: TextStyle(
                                              color: color,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10)),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ]),
                      ),
                      SliverFillRemaining(
                        child: FutureBuilder(
                          future: services.getVideobyCategory(widget.category),
                          builder: (BuildContext context,
                              AsyncSnapshot snapshotvid) {
                            if (snapshotvid.hasData) {
                              return _buildVideoWidget(snapshotvid);
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        ),
                      )
                    ],
                  );
                },
              ),
            );
          } else {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }

  Future<Null> setTitles() async {
    services.getVideobyCategory(widget.category);
  }

  Widget _buildVideoWidget(AsyncSnapshot snapshot) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
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
