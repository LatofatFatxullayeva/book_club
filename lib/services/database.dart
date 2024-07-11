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
      DocumentSnapshot _docSnapshot =
          await _firestore.collection("users").doc(uid).get();
      retVal.uid = uid;
      var data = _docSnapshot.data() as Map<String, dynamic>;
      retVal.fullName = data["fullName"];
      retVal.email = data["email"];
      retVal.accountCreated = data["accountCreated"];
    } catch (e) {
      print(e);
    }
    return retVal;
  }
}
