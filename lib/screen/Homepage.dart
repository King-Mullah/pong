import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pong/util/Myball.dart';
import 'package:pong/util/brick.dart';
import 'package:pong/util/coverscreen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

enum direction { UP, DOWN, LEFT, RIGHT }

class _HomePageState extends State<HomePage> {
  double playerX = -0.2;
  double brickWidth = 0.4;

  double enemyX = -0.2;

  bool startgame = false;
  double ballx = 0;
  double bally = 0;
  var Ballydirection = direction.DOWN;
  var BallxDirection = direction.LEFT;

  bool isPlayerDead(){
    if(bally >= 1){
      return true;
    }
    return false;
  }

  void StartGame() {
    startgame = true;
    Timer.periodic(Duration(milliseconds: 1), (timer) {
      Updatedirection();
      moveBall();
      moveEnemy();
      if(isPlayerDead()){
        timer.cancel();
        resetGame();
      }
    });
  }
  void moveEnemy(){
    enemyX = ballx;
  }
  void resetGame(){
    setState(() {
      startgame = false;
      ballx= 0;
      bally = 0;
      playerX = -0.2;
      enemyX = -0.2;
    });
  }

  void Updatedirection() {
    setState(() {
      //vertical direction
      if (bally >= 0.9 && playerX + brickWidth >= ballx && playerX <= ballx) {
        Ballydirection = direction.UP;
      } else if (bally <= -0.9) {
        Ballydirection = direction.DOWN;
      }

      //horizontal direction
      if (ballx >= 1) {
        BallxDirection = direction.LEFT;
      } else if (bally <= -1) {
        BallxDirection = direction.RIGHT;
      }
    });
  }

  void moveBall() {
    setState(() {
      //vertical ball movement
      if (Ballydirection == direction.DOWN) {
        bally += 0.01;
      } else if (Ballydirection == direction.UP) {
        bally -= 0.01;
      }

      //horizontal ball movement
      if (BallxDirection == direction.LEFT) {
        bally += 0.01;
      } else if (BallxDirection == direction.RIGHT) {
        bally -= 0.01;
      }
    });
  }

  void moveLeft() {
    setState(() {
      if(!(playerX - 0.1 <= -1)){
        playerX -= 0.1;
      }
    });
  }

  void moveRight() {
    setState(() {
      if(!(playerX + brickWidth >= 1)){
        playerX += 0.1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return RawKeyboardListener(
      focusNode: FocusNode(),
      autofocus: true,
      onKey: (event) {
        if (event.isKeyPressed(LogicalKeyboardKey.arrowLeft)) {
          moveLeft();
        } else if (event.isKeyPressed(LogicalKeyboardKey.arrowRight)) {
          moveRight();
        }
      },
      child: GestureDetector(
        onTap: StartGame,
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          body: Center(
            child: Stack(
              children: [
                //coverscreen
                CoverScreen(
                  startgame: startgame,
                ),
                //top brick
                MyBrick(
                  x: enemyX,
                  y: -0.9,
                  brickWidth: brickWidth,
                  thisIsEnemy: true,
                ),
                //bottom brick
                MyBrick(
                  x: playerX,
                  y: 0.9,
                  brickWidth: brickWidth,
                  thisIsEnemy: false,
                ),
                //ball
                MyBall(
                  x: ballx,
                  y: bally,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
