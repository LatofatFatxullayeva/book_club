// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';

class Group {
  String? id;
  String? name;
  String? leader;
  List<String>? menbers;
  Timestamp? groupCreated;
  Group({
     this.id,
     this.name,
     this.leader,
     this.menbers,
     this.groupCreated,
  });
}
