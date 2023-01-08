import 'package:flutter/material.dart';


class MyBrick extends StatelessWidget {
  //const MyBrick({Key? key}) : super(key: key);

  final x;
  final y;
  final brickWidth;
  final thisIsEnemy;

  const MyBrick({this.x , this.y, this.brickWidth, this.thisIsEnemy});

  @override
  Widget build(BuildContext context) {
    return  Container(
      alignment:  Alignment((2 * x + brickWidth)/(2 - brickWidth),y),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
          color: thisIsEnemy? Colors.pink : Colors.white,
          height: 20,
          width: MediaQuery.of(context).size.width / 5,
        ),
      ),
    );
  }
}
