/* import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ulivemedia/providers/auth_provider.dart';
import 'package:ulivemedia/services/auth_service.dart';
import 'package:ulivemedia/services/database_services.dart';



class LayoutWidgets {
  
  Widget _buildCircleAvatar(AuthService auth, BuildContext context, VoidCallback authstatus) {
    final Color color = Theme.of(context).primaryColor;
    if (auth.currentUser() == null) {
      IconButton(
        icon: Icon(FontAwesomeIcons.userCircle, size: 25, color: color),
        onPressed: () {},
      );
    } else {
      FutureBuilder(
        future: services.getCurrentUserDetails(auth.user1),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            String photourl =
                'https://firebasestorage.googleapis.com/v0/b/ulivemedia-8a6ec.appspot.com/o/user_default.png?alt=media&token=4ed7fb78-416c-420a-9238-328666fb8e37';
            return GestureDetector(
              onTap: () {},
              child: CircleAvatar(
                child: Image.network(
                  snapshot.data['photoUrl'] ?? photourl,
                  fit: BoxFit.cover,
                ),
                radius: 20.0,
              ),
            );
          } else {
            IconButton(
              icon: Icon(FontAwesomeIcons.userCircle, size: 25, color: color),
              onPressed: () {},
            );
          }
        },
      );
    }
  }

  
  Widget applicationAppBar(BuildContext context, VoidCallback authstatus) {
    final Color color = Theme.of(context).primaryColor;
    var auth = AuthProvider.of(context).auth;
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0.0,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset('assets/logo/logo.png'),
      ),
      actions: <Widget>[
        if (auth == null) ...{
          _buildCircleAvatar(auth, context, authstatus)
        } else ...{
          IconButton(
            icon: Icon(FontAwesomeIcons.userCircle, size: 25, color: color),
            onPressed: () {},
          )
        }
      ],
      centerTitle: true,
    );
  }
}

LayoutWidgets layoutWidgets = LayoutWidgets();
 */