import 'package:flutter/material.dart';


class CoverScreen extends StatelessWidget {
  //const CoverScreen({Key? key}) : super(key: key);
  final bool startgame;

  CoverScreen({required this.startgame});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: const Alignment(0, -0.2),
      child: Text(
          startgame ? "" : 'TAP TO START'),
    );
  }
}
