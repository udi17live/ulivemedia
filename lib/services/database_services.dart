import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ulivemedia/models/user.dart';

class Services with ChangeNotifier {
  var firestore = Firestore.instance;

  Future getHomeDataFeatured() async {
    QuerySnapshot querySnapshot =
        await Firestore.instance.collection("homescroll").getDocuments();
    var list = querySnapshot.documents;

    print("List has ${list.length} documents");
    return list;
  }

  Future getAllVideos() async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection("videos")
        .orderBy('time', descending: true)
        .getDocuments();

    var vidlist = snapshot.documents;

    print("List has ${vidlist.length} documents");
    notifyListeners();
    return vidlist;
  }

  Future getVideobyCategory(String category) async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection('videos')
        .where('video_category', isEqualTo: category)
        .orderBy('time', descending: true)
        .getDocuments();

    var vidlist = snapshot.documents;

    print("List has ${vidlist.length} documents");
    notifyListeners();
    return vidlist;
  }

  Future getCategoryDetails(String category) async {
    String docId;

    if(category == 'Giants of Aviation'){
      docId = 'goa';
    }else if(category == 'Airline Alliances'){
      docId = 'aa';
    }else if(category == 'Top Ten Aviation'){
      docId = 'tta';
    }else if(category == 'FSX Aviation'){
      docId = 'fsx';
    }else if(category == 'Spotters Eye Episodes'){
      docId = 'see';
    }else if(category == 'Other Aviation'){
      docId = 'ota';
    }

    DocumentSnapshot snapshot = await Firestore.instance.collection('categories').document(docId).get();

    print(snapshot.exists);

    return snapshot;
  }

  Future getAllNews() async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection("news")
        .orderBy('updated_at', descending: true)
        .getDocuments();

    var newslist = snapshot.documents;

    print("News List has ${newslist.length} documents");
    notifyListeners();
    return newslist;
  }

  Future getCurrentUserDetails(FirebaseUser user) async {
    DocumentSnapshot snapshot = await Firestore.instance.collection('users').document(user.uid).get();

    print(snapshot.exists);
    notifyListeners();
    return snapshot;
    
  }
}

Services services = Services();
