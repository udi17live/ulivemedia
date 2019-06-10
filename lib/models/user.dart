
import 'package:flutter/foundation.dart';

class User{
  final String user_id;
  final String user_name;
  final String user_photoUrl;
  final String user_email;
  final String user_lastseen;
  final String user_country;

  User({
    @required this.user_id,
    @required this.user_email,
    @required this.user_name,
    this.user_photoUrl,
    this.user_country,
    @required this.user_lastseen,
  });
}