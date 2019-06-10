import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';

enum AuthMode { Signup, Login }

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class UserRepository with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final Firestore db = Firestore.instance;

  UserRepository.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;
  FirebaseUser get user => _user;

  Future<bool> signIn(String email, String password) async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> register(String email, String name, String password) async{
    try {
      _status = Status.Authenticating;
      notifyListeners();
      FirebaseUser user = await _auth.createUserWithEmailAndPassword(email: email, password: password,);
      updateUserData(user, name: name);
      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      print(e.toString());
      return false;
    }
  }

  Future<bool> googleSignIn() async {
    try {
      _status = Status.Authenticating;
      notifyListeners();
      GoogleSignInAccount googleuser = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleuser.authentication;
      await _auth.signInWithGoogle(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      updateUserData(user);

      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }



  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
    }
    notifyListeners();
  }




  void updateUserData(FirebaseUser user, {String name}) async {
    DocumentReference ref = db.collection('users').document(user.uid);
    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoURL': user.photoUrl,
      'displayName': user.displayName ?? name,
      'lastSeen': DateTime.now(),
    }, merge: true);
  }
}

UserRepository authService = UserRepository.instance();

/* class AuthService { 
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Firestore db = Firestore.instance;
  FirebaseUser user1;


  Observable<FirebaseUser> user;
  Observable<Map<String, dynamic>> profile;
  PublishSubject loading = PublishSubject();

  AuthService(){
    user = Observable(_auth.onAuthStateChanged);

    profile = user.switchMap((FirebaseUser u){
      if (u != null){
        return db.collection('users').document(u.uid).snapshots().map((snap) => snap.data);
      }else{
        return Observable.just({});
      }
    });

  }

  Future<FirebaseUser> googleSignIn() async{
    loading.add(true);

    GoogleSignInAccount googleuser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleuser.authentication;
    FirebaseUser user = await _auth.signInWithGoogle(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    updateGoogleUserData(user);

    loading.add(false);
    return user;
  }

  Future<FirebaseUser> emailSignIn(var email, var password) async {
    loading.add(true);

    FirebaseUser user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    updateEmailUserData(user);
    print("Signed In with " + user.uid);
    //currentUser = user;

    loading.add(false);
    return user;
  }

  Future<FirebaseUser> emailRegister(
      var email, var password, var name, var country) async {
    loading.add(true);

    try {
      FirebaseUser user = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      addUser(user, name);

      print("Signed In with " + user.uid);
      loading.add(false);
      return user;

    } catch (error) {
      print(error);
    }

  }

  void addUser(FirebaseUser user, String name, ) async {
    DocumentReference ref = db.collection('users').document(user.uid);

    

    return ref.setData({
      'uid' : user.uid,
      'email' : user.email,
      'photoURL' : user.photoUrl,
      'displayName' : name,
      'lastSeen' : DateTime.now(),
      'country' : "United States"
    }, merge: true);
  }

  void updateEmailUserData(FirebaseUser user) async {
    DocumentReference ref = db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'lastSeen': DateTime.now(),
    }, merge: true);
  }

  void updateGoogleUserData(FirebaseUser user) async{
    DocumentReference ref = db.collection('users').document(user.uid);

    return ref.setData({
      'uid' : user.uid,
      'email' : user.email,
      'photoURL' : user.photoUrl,
      'displayName' : user.displayName,
      'lastSeen' : DateTime.now(),
      'country' : ''
    }, merge: true);
  }

  Future<String> currentUser() async{
    FirebaseUser user = await _auth.currentUser();
    user1 = user;
    return user?.uid;
  }

  

  void signOut(){
    _auth.signOut();
  }

}

final AuthService authService = AuthService();*/
