// ignore_for_file: avoid_print

import 'package:book_club/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OurDatabase {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createUser(OurUser user) async {
    String retVal = "error";

    try {
      await _firestore.collection("users").doc(user.uid).set({
        'fullName': user.fullName,
        'email': user.email,
        'accountCreated': Timestamp.now(),
        'groupId': user.groupId,
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<OurUser> getUserInfo(String uid) async {
    OurUser retVal = OurUser();
    try {
      DocumentSnapshot docSnapshot =
          await _firestore.collection("users").doc(uid).get();
      retVal.uid = uid;
      var data = docSnapshot.data() as Map<String, dynamic>;
      retVal.fullName = data["fullName"];
      retVal.email = data["email"];
      retVal.accountCreated = data["accountCreated"];
      retVal.groupId = data["groupId"];
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> createGroup(String groupName, String userUid) async {
    String retVal = "error";
    List<String> members = [];
    try {
      members.add(userUid);
      DocumentReference _docRef = await _firestore.collection("groups").add({
        'name': groupName,
        'leader': userUid,
        'members': members,
        'groupCreate': Timestamp.now(),
      });

      await _firestore.collection("users").doc(userUid).update({
        'groupId': _docRef.id,
      });

      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> joinGroup(String groupId, String userUid) async {
    String retVal = "error";
    List<String> members = [];

    try {
      members.add(userUid);
      await _firestore.collection("groups").doc(groupId).update({
        'members': FieldValue.arrayUnion(members),
      });
      await _firestore.collection("users").doc(userUid).update({
        'groupId': groupId,
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
