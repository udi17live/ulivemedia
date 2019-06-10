import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ulivemedia/services/database_services.dart';

class HomePage extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  Widget _buildHomePageCard(AsyncSnapshot snapshot) {
    return ListView.builder(
      itemCount: 3,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          semanticContainer: true,
          borderOnForeground: true,
          child: Container(
            width: MediaQuery.of(context).size.width * .92,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                image: DecorationImage(
                    image: NetworkImage(
                      snapshot.data[index]['imageURL'],
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
                                snapshot.data[index]['tag'],
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
                              child: Text(snapshot.data[index]['tag_type'],
                                  style: TextStyle(color: Colors.white)),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 0.0),
                        child: Text(
                          snapshot.data[index]['title'],
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
                      size: 100, color: Colors.white),
                )
              ]),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        );
      },
    );
  }

  Widget _buildSubscribeCard() {
    return Card(
      color: Color(0xFFFF564B),
      child: Center(
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 0.0),
          leading: Image.asset('assets/logo/logo_w.png'),
          title: Text(
            'ULIVE MEDIA',
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '750 Subscribers',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          trailing: Icon(
            FontAwesomeIcons.arrowRight,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      key: _refreshIndicatorKey,
      onRefresh: setTitles,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text('Welcome Aboard,',
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 24)),
              ),
              Container(
                height: 200.0,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                child:FutureBuilder(
                      future: services.getHomeDataFeatured(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return _buildHomePageCard(snapshot);
                        } else {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
              ),
              Container(
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                child: _buildSubscribeCard(),
              ),

              Container(
                height: 250,
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                child: _buildGrid(context),
              ),
            ]),
          ),
          
        ],
      ),
    );
  }

  Future<Null> setTitles() async {
    services.getHomeDataFeatured();
  }

  Widget _buildGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
          child: InkWell(
            highlightColor: Theme.of(context).primaryColor,
            onTap: () {},
            child: Card(elevation: 2.0,
              child: Container(
                padding: EdgeInsets.all(12.0),
                height: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.video_call,
                      color: Theme.of(context).primaryColor,
                      size: 40.0,
                    ),
                    Text(
                      'All Videos',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
          child: InkWell(
            highlightColor: Theme.of(context).primaryColor,
            onTap: () {},
            child: Card(elevation: 2.0,
              child: Container(
                padding: EdgeInsets.all(12.0),
                height: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.video_call,
                      color: Theme.of(context).primaryColor,
                      size: 40.0,
                    ),
                    Text(
                      'All Videos',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),


        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
          child: InkWell(
            highlightColor: Theme.of(context).primaryColor,
            onTap: () {},
            child: Card(elevation: 2.0,
              child: Container(
                padding: EdgeInsets.all(12.0),
                height: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.video_call,
                      color: Theme.of(context).primaryColor,
                      size: 40.0,
                    ),
                    Text(
                      'All Videos',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),


        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
          child: InkWell(
            highlightColor: Theme.of(context).primaryColor,
            onTap: () {},
            child: Card(elevation: 2.0,
              child: Container(
                padding: EdgeInsets.all(12.0),
                height: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.video_call,
                      color: Theme.of(context).primaryColor,
                      size: 40.0,
                    ),
                    Text(
                      'All Videos',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),


        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
          child: InkWell(
            highlightColor: Theme.of(context).primaryColor,
            onTap: () {},
            child: Card(elevation: 2.0,
              child: Container(
                padding: EdgeInsets.all(12.0),
                height: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.video_call,
                      color: Theme.of(context).primaryColor,
                      size: 40.0,
                    ),
                    Text(
                      'All Videos',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),



        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 0.0),
          child: InkWell(
            highlightColor: Theme.of(context).primaryColor,
            onTap: () {},
            child: Card(elevation: 2.0,
              child: Container(
                padding: EdgeInsets.all(12.0),
                height: 150.0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.video_call,
                      color: Theme.of(context).primaryColor,
                      size: 40.0,
                    ),
                    Text(
                      'All Videos',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
