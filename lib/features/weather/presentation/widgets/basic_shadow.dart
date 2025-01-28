// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class BasicShadow extends StatelessWidget {
  final bool topDown;

  const BasicShadow({
    Key? key,
    required this.topDown,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: topDown ? Alignment.topCenter : Alignment.bottomCenter,
          end: topDown ? Alignment.bottomCenter : Alignment.topCenter,
          colors: [
            Colors.black87,
            Colors.transparent,
          ],
        ),
      ),
    );
  }
}
