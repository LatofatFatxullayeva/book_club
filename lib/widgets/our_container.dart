// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class OurContainer extends StatelessWidget {
  final Widget child;
  const OurContainer({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.blue.shade300,
              blurRadius: 10,
              spreadRadius: 1,
              offset: Offset(4, 4),
            )
          ]),
      child: child,
    );
  }
}
