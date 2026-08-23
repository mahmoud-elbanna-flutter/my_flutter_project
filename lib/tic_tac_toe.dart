import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const StartScreen(),
    );
  }
}

const Color xColor = Colors.black;
const Color oColor = Color(0xffb074d1);

class StartScreen extends StatelessWidget {
const StartScreen({super.key});

void startGame(BuildContext context, String player) {
Navigator.push(
context,
MaterialPageRoute(
builder: (context) => GameScreen(
firstPlayer: player,
),
),
);
}

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: Colors.white,

body: SafeArea(
child: Container(
width: double.infinity,
height: double.infinity,

decoration: const BoxDecoration(
gradient: LinearGradient(
begin: Alignment.topCenter,
end: Alignment.bottomCenter,
colors: [
Color(0xFF0D0D0D),
Color(0xFFD9B8FF),
],
),
),

child: LayoutBuilder(
builder: (context, constraints) {
return Padding(
padding: const EdgeInsets.symmetric(
horizontal: 30,
vertical: 20,
),

child: Column(
children: [

const Spacer(),

const Text(
'Tix-Tac-Toe',
textAlign: TextAlign.center,
style: TextStyle(
color: Colors.white,
fontSize: 25,
fontWeight: FontWeight.bold,
),
),

const SizedBox(height: 120),

const Text(
'Pick who goes first?',
style: TextStyle(
color: Colors.white,
fontSize: 15,
fontWeight: FontWeight.w500,
),
),

const SizedBox(height: 15),

Row(
children: [

Expanded(
child: GestureDetector(
onTap: () {
startGame(context, 'X');
},

child: Container(
height: 85,

decoration: BoxDecoration(
color: Colors.white,
borderRadius:
BorderRadius.circular(17),
),

child: const Center(
child: XOIcon(
type: 'X',
color: xColor,
size: 58,
),
),
),
),
),

const SizedBox(width: 8),

Expanded(
child: GestureDetector(
onTap: () {
startGame(context, 'O');
},

child: Container(
height: 85,

decoration: BoxDecoration(
color: Colors.white,
borderRadius:
BorderRadius.circular(17),
),
  child: const Center(
    child: XOIcon(
      type: 'O',
      color: oColor,
      size: 58,
    ),
  ),
),
),
),
],
),

  const Spacer(),
],
),
);
},
),
),
),
);
}
}

class XOIcon extends StatelessWidget {
  final String type;
  final Color color;
  final double size;

  const XOIcon({
    super.key,
    required this.type,
    required this.color,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,

      child: CustomPaint(
        painter: XOIconPainter(
          type: type,
          color: color,
        ),
      ),
    );
  }
}

class XOIconPainter extends CustomPainter {
  final String type;
  final Color color;

  XOIconPainter({
    required this.type,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {

    final paint = Paint()
      ..color = color
      ..strokeWidth = 10
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    if (type == 'O') {

      final center = Offset(
        size.width / 2,
        size.height / 2,
      );

      canvas.drawCircle(
        center,
        size.width * 0.34,
        paint,
      );

    } else {

      canvas.drawLine(
        Offset(
          size.width * 0.20,
          size.height * 0.20,
        ),
        Offset(
          size.width * 0.80,
          size.height * 0.80,
        ),
        paint,
      );

      canvas.drawLine(
        Offset(
          size.width * 0.80,
          size.height * 0.20,
        ),
        Offset(
          size.width * 0.20,
          size.height * 0.80,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(
      covariant XOIconPainter oldDelegate,
      ) {
    return oldDelegate.type != type ||
        oldDelegate.color != color;
  }
}

class GameScreen extends StatefulWidget {
  final String firstPlayer;

  const GameScreen({
    super.key,
    required this.firstPlayer,
  });

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

List<String> board = List.filled(9, '');

late String currentPlayer;

String? winner;

bool gameOver = false;

int seconds = 0;

Timer? timer;

@override
void initState() {
super.initState();

currentPlayer = widget.firstPlayer;

startTimer();
}

void startTimer() {

timer?.cancel();

timer = Timer.periodic(
const Duration(seconds: 1),
(timer) {

if (!gameOver) {
setState(() {
seconds++;
});
}
},
);
}

String getTime() {

int minutes = seconds ~/ 60;

int sec = seconds % 60;

return '${minutes.toString().padLeft(2, '0')}:'
'${sec.toString().padLeft(2, '0')}';
}

void play(int index) {

if (gameOver) {
return;
}

if (board[index].isNotEmpty) {
return;
}

setState(() {
board[index] = currentPlayer;
});

checkWinner();

if (!gameOver) {

setState(() {

if (currentPlayer == 'X') {
currentPlayer = 'O';
} else {
currentPlayer = 'X';
}
});
}
}

void checkWinner() {

const List<List<int>> winningPositions = [

[0, 1, 2],
[3, 4, 5],
[6, 7, 8],

[0, 3, 6],
[1, 4, 7],
[2, 5, 8],

[0, 4, 8],
[2, 4, 6],
];

for (final position in winningPositions) {

final String a = board[position[0]];
final String b = board[position[1]];
final String c = board[position[2]];

if (a.isNotEmpty &&
a == b &&
b == c) {

setState(() {
winner = a;
gameOver = true;
});

timer?.cancel();

return;
}
}

if (!board.contains('')) {

setState(() {
winner = 'Draw';
gameOver = true;
});

timer?.cancel();
}
}

void playAgain() {

setState(() {

board = List.filled(9, '');

currentPlayer = widget.firstPlayer;

winner = null;

gameOver = false;

seconds = 0;
});

startTimer();
}

Widget gameCell(int index) {

return GestureDetector(

onTap: () {
play(index);
},

child: Container(

decoration: BoxDecoration(
color: Colors.white,

border: Border.all(
color: const Color(0xff777777),
width: 0.7,
),
),

child: Center(
child: board[index].isEmpty
? const SizedBox()
: XOIcon(
type: board[index],
color: board[index] == 'X'
? xColor
: oColor,
size: 52,
),
),
),
);
}

Widget boardWidget(double width) {

return Container(

width: width,

height: width,

decoration: BoxDecoration(
color: Colors.white,
borderRadius: BorderRadius.circular(22),
),

clipBehavior: Clip.antiAlias,

child: Column(
children: [

Expanded(
child: Row(
children: [
Expanded(child: gameCell(0)),
Expanded(child: gameCell(1)),
Expanded(child: gameCell(2)),
],
),
),

Expanded(
child: Row(
children: [
Expanded(child: gameCell(3)),
Expanded(child: gameCell(4)),
Expanded(child: gameCell(5)),
],
),
),

Expanded(
child: Row(
children: [
Expanded(child: gameCell(6)),
Expanded(child: gameCell(7)),
Expanded(child: gameCell(8)),
],
),
),
],
),
);
}

@override
void dispose() {

timer?.cancel();

super.dispose();
}

@override
Widget build(BuildContext context) {

return Scaffold(

backgroundColor: Colors.white,

body: SafeArea(

child: Container(

width: double.infinity,
height: double.infinity,

decoration: const BoxDecoration(

gradient: LinearGradient(

begin: Alignment.topCenter,
end: Alignment.bottomCenter,

colors: [
Color(0xFF0D0D0D),
Color(0xFFD9B8FF),
],
),
),

child: LayoutBuilder(

builder: (context, constraints) {

double boardSize =
constraints.maxWidth - 40;

if (boardSize > 360) {
boardSize = 360;
}

return Padding(

padding: const EdgeInsets.symmetric(
horizontal: 20,
vertical: 15,
),

child: Column(

children: [

Container(

width: double.infinity,

height: 40,

decoration: BoxDecoration(
color: Colors.white,
borderRadius:
BorderRadius.circular(25),
),

child: Center(

child: Text(
getTime(),

  style: const TextStyle(
    color: Colors.black,
    fontSize: 15,
    fontWeight: FontWeight.bold,
  ),
),
),
),

  const SizedBox(height: 15),

  Text(

    gameOver
        ? winner == 'Draw'
        ? 'Draw'
        : 'Player $winner\'s win'
        : 'Player $currentPlayer\'s Turn',

    style: const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  ),

  const SizedBox(height: 15),

  boardWidget(boardSize),

  const Spacer(),

  if (gameOver)

    GestureDetector(

      onTap: playAgain,

      child: Container(

        width: double.infinity,

        height: 45,

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(25),
        ),

        child: Center(

          child: Text(

            'Play Again',

            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight:
              FontWeight.bold,
            ),
          ),
        ),
      ),
    ),

  const SizedBox(height: 10),
],
),
);
},
),
),
),
);
}
}