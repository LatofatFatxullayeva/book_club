// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class OurUser {
  String? uid;
  String? email;
  String? fullName;
  Timestamp? accountCreated;
  String? groupId;
  OurUser({
    this.uid,
    this.email,
    this.fullName,
    this.accountCreated,
     this.groupId,
  });
}
