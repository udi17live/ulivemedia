/* import 'package:flutter/material.dart';
import 'package:ulivemedia/services/auth_service.dart';

class AuthProvider extends InheritedWidget {
  const AuthProvider({Key key, Widget child, this.auth}) : super(key: key, child: child);
  final AuthService auth;

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static AuthProvider of(BuildContext context) {
    return context.inheritFromWidgetOfExactType(AuthProvider);
  }
} */