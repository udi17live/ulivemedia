import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ulivemedia/pages/home_page.dart';
import 'package:ulivemedia/pages/login_register.dart';
import 'package:ulivemedia/pages/news_page.dart';
import 'package:ulivemedia/pages/video_page.dart';
import 'package:ulivemedia/pages/more_page.dart';
import 'package:ulivemedia/providers/auth_provider.dart';
import 'package:ulivemedia/services/auth_service.dart';
import 'package:ulivemedia/services/database_services.dart';
import 'package:ulivemedia/widgets/layout_widgets.dart';

class MainClass extends StatefulWidget {
  final Widget child;
  int initialPage;

  MainClass({this.child,@required this.initialPage});

  static restartApp(BuildContext context) {
    final _MainClassState state =
        context.ancestorStateOfType(const TypeMatcher<_MainClassState>());
    state.initState();
  }

  @override
  _MainClassState createState() => _MainClassState();
}

enum AuthStatus {
  notDetermined,
  notSignedIn,
  signedIn,
}

class _MainClassState extends State<MainClass>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  UserRepository userRepository = UserRepository.instance();
  Key key = new UniqueKey();


  void restartApp() {
    this.setState(() {
      key = new UniqueKey();
    });
  }

  AuthStatus authStatus = AuthStatus.notDetermined;
  //uthService auth;

  /* @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    auth = AuthProvider.of(context).auth;
    auth.currentUser().then((String userId) {
      setState(() {
        authStatus =
            userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
  }

  void _signedIn() {
    setState(() {
      authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut() {
    setState(() {
      authStatus = AuthStatus.notSignedIn;
    });
  } */

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 6, initialIndex: 0);

    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nextPage(widget.initialPage);
    super.dispose();
  }

  void _nextPage(int tab) {
    final int newTab = _tabController.index + tab;
    if (newTab < 0 || newTab >= _tabController.length) return;
    _tabController.animateTo(newTab);
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).primaryColor;
    return Scaffold(
      key: key,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset('assets/logo/logo.png'),
        ),
        actions: <Widget>[
          ChangeNotifierProvider(
            builder: (_) => UserRepository.instance(),
            child: Consumer(
              builder: (context, UserRepository user, _) {
                switch (user.status) {
                  case Status.Uninitialized:
                    return IconButton(
                      icon: Icon(FontAwesomeIcons.userCircle,
                          size: 25, color: color),
                      onPressed: () => _tabController.animateTo(5),
                    );
                  case Status.Unauthenticated:
                    return IconButton(
                      icon: Icon(FontAwesomeIcons.userCircle,
                          size: 25, color: color),
                      onPressed: () => _tabController.animateTo(5),
                    );
                  case Status.Authenticating:
                    return IconButton(
                      icon: Icon(FontAwesomeIcons.userCircle,
                          size: 25, color: color),
                      onPressed: () => _tabController.animateTo(5),
                    );
                  case Status.Authenticated:
                    return _buildCircleAvatar(user.user);
                }
              },
            ),
          )

          /*  authStatus == AuthStatus.notDetermined ||
                  authStatus == AuthStatus.notSignedIn
              ? IconButton(
                  icon:
                      Icon(FontAwesomeIcons.userCircle, size: 25, color: color),
                  onPressed: () {},
                )
              : IconButton(
                  icon: Icon(FontAwesomeIcons.home, size: 25, color: color),
                  onPressed: () {},
                ) */
        ],
        centerTitle: true,
      ),
      bottomNavigationBar: TabBar(
        controller: _tabController,
        indicatorColor: Theme.of(context).accentColor,
        indicatorWeight: 3,
        tabs: <Widget>[
          Tab(icon: Icon(FontAwesomeIcons.home, color: color)),
          Tab(icon: Icon(FontAwesomeIcons.play, color: color)),
          Tab(icon: Icon(FontAwesomeIcons.newspaper, color: color)),
          Tab(icon: Icon(FontAwesomeIcons.commentAlt, color: color)),
          Tab(icon: Icon(FontAwesomeIcons.userAlt, color: color)),
          Tab(icon: Icon(FontAwesomeIcons.bars, color: color)),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          HomePage(),
          VideoPage(),
          NewsPage(),
          LoginRegisterPage(),
          Center(child: Text("Page 5")),
          MorePage()
        ],
      ),
    );
  }


  Widget _buildCircleAvatar(FirebaseUser user) {
    String photourl =
        'https://firebasestorage.googleapis.com/v0/b/ulivemedia-8a6ec.appspot.com/o/user_default.png?alt=media&token=4ed7fb78-416c-420a-9238-328666fb8e37';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => _tabController.animateTo(5),
        child: Container(
          width: 42.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: NetworkImage(user.photoUrl ?? photourl),
              fit: BoxFit.cover
            )
          ),
          
        ) 
      ),
    );
    
  }
}


/* Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
              return MainClass(initialPage: 2,); */