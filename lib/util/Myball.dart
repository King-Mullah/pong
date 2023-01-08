import 'package:flutter/material.dart';


class MyBall extends StatelessWidget {
  //const MyBall({Key? key}) : super(key: key);
final x;
final y;
const MyBall({this.x, this.y});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment(x,y),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      width: 20,
      height: 20,
    );
  }
}
