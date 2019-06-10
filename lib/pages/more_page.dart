import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ulivemedia/pages/edit_profile_page.dart';
import 'package:ulivemedia/services/auth_service.dart';
import 'package:ulivemedia/services/database_services.dart';

class MorePage extends StatelessWidget {
  UserRepository userRepository = UserRepository.instance();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(
                width: MediaQuery.of(context).size.width,
                //height: 200,
                child: ChangeNotifierProvider(
                  builder: (_) => UserRepository.instance(),
                  child: Consumer(builder: (context, UserRepository user, _) {
                    switch (user.status) {
                      case Status.Uninitialized:
                        return _buildNoProfileArea(context);
                      case Status.Authenticating:
                        return _buildNoProfileArea(context);
                      case Status.Unauthenticated:
                        return _buildNoProfileArea(context);
                      case Status.Authenticated:
                        return FutureBuilder(
                          future: services
                              .getCurrentUserDetails(userRepository.user),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return _buildProfileArea(snapshot, context);
                            } else {
                              return Center(child: CircularProgressIndicator());
                            }
                          },
                        );
                    }
                  }),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildCircleAvatar(FirebaseUser user) {
    String photourl =
        'https://firebasestorage.googleapis.com/v0/b/ulivemedia-8a6ec.appspot.com/o/user_default.png?alt=media&token=4ed7fb78-416c-420a-9238-328666fb8e37';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 70.0,
        height: 70.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(user.photoUrl ?? photourl),
                fit: BoxFit.cover)),
      ),
    );
  }

  Widget _buildProfileArea(AsyncSnapshot snapshot, BuildContext context) {
    return Column(
      children: <Widget>[
        _buildCircleAvatar(userRepository.user),
        Text(
          snapshot.data['displayName'],
          style: TextStyle(
              fontSize: 20,
              color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.bold),
        ),
        Text(
          snapshot.data['email'],
          style: TextStyle(
            fontSize: 15,
            color: Theme.of(context).accentColor,
          ),
        ),
        ButtonBar(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            MaterialButton(
                color: Theme.of(context).primaryColor,
                child: Row(
                  children: <Widget>[
                    Icon(FontAwesomeIcons.edit, color: Colors.white, size: 14),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Edit Profile',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => EditProfilePage(userRepository.user) ));
                }),
            MaterialButton(
                color: Theme.of(context).accentColor,
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.signOutAlt,
                      color: Colors.white,
                      size: 14,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Sign Out',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                onPressed: () {
                  userRepository.signOut();
                }),
          ],
        )
      ],
    );
  }

  Widget _buildNoProfileArea(BuildContext context) {
    String photoUrl =
        "https://firebasestorage.googleapis.com/v0/b/ulivemedia-8a6ec.appspot.com/o/user_default.png?alt=media&token=4ed7fb78-416c-420a-9238-328666fb8e37";
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: 70.0,
                height: 70.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: NetworkImage(photoUrl), fit: BoxFit.cover)),
              ),
            ),
            Center(
              child: Text(
                'You are not Signed In. Please Sign In to your account!',
                style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            MaterialButton(
              height: 45.0,
                color: Theme.of(context).accentColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.signOutAlt,
                      color: Colors.white,
                      size: 20,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Sign In',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/loginRegister');
                }),
          ],
        ),
      ),
    );
  }
}
