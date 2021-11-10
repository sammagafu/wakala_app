import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<String> getUserProfile() async {
  var userprofile = await FirebaseFirestore.instance
      .collection("user_profile")
      .where("uiid", isEqualTo: FirebaseAuth.instance.currentUser?.uid)
      .get();
  return userprofile.docs.first.get("""
fullname""").toString();
}
