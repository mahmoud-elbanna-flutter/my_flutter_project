import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatelessWidget {
const ChatScreen({super.key});

@override
Widget build(BuildContext context) {
return Scaffold(
backgroundColor: const Color(0xff0b141a),
body: SafeArea(
child: Column(
children: [


Container(
height: 65,
color: const Color(0xff128c4a),
child: Row(
children: [

const SizedBox(width: 10),

const Icon(
Icons.arrow_back,
color: Colors.white,
),

const SizedBox(width: 10),

const CircleAvatar(
radius: 18,
backgroundImage: NetworkImage(
'https://i.pravatar.cc/100?img=12',
),
),

const SizedBox(width: 10),

const Expanded(
child: Text(
'Mahmoud',
style: TextStyle(
color: Colors.white,
fontSize: 15,
fontWeight: FontWeight.bold,
),
),
),

const Icon(
Icons.phone,
color: Colors.white,
size: 21,
),

const SizedBox(width: 20),

const Icon(
Icons.videocam_outlined,
color: Colors.white,
size: 23,
),

const SizedBox(width: 18),

const Icon(
Icons.more_vert,
color: Colors.white,
),

const SizedBox(width: 10),
],
),
),

Expanded(
child: Container(
decoration: const BoxDecoration(
color: Color(0xff0b141a),

image: DecorationImage(
image: AssetImage(
'assets/whatsapp_bg.png',
),
repeat: ImageRepeat.repeat,
opacity: 0.15,
),
),

child: ListView(
padding: const EdgeInsets.all(12),
children: [

Align(
alignment: Alignment.centerLeft,
child: message(
'Hello Mahmoud !',
const Color(0xff128c4a),
),
),

Align(
alignment: Alignment.centerRight,
child: message(
'Hello !',
const Color(0xff202c33),
),
),

Align(
alignment: Alignment.centerLeft,
child: message(
'Hey! Have you ever thought\n'
'about how random moments\n'
'can sometimes turn into the\n'
'best memories? It’s like the\n'
'universe loves to surprise us\n'
'when we least expect it!',
const Color(0xff128c4a),
),
),
Align(
alignment: Alignment.centerLeft,
child: Container(
width: 230,
margin: const EdgeInsets.only(top: 5),
padding: const EdgeInsets.all(8),
decoration: BoxDecoration(
color: const Color(0xff128c4a),
borderRadius: BorderRadius.circular(10),
),
child: Column(
crossAxisAlignment:
CrossAxisAlignment.start,
children: [

const Text(
'what a Great Content Tp learn Flutter',
style: TextStyle(
color: Colors.white,
fontSize: 14,
),
),

const SizedBox(height: 8),

ClipRRect(
borderRadius:
BorderRadius.circular(8),

child: Image.network(
'https://images.unsplash.com/photo-1551650975-87deedd944c3'
'?auto=format&fit=crop&w=600&q=80',

height: 140,
width: double.infinity,
fit: BoxFit.cover,
),
),
],
),
),
),

Align(
alignment: Alignment.centerRight,
child: message(
'what a Great Content Tp learn\nFlutter',
const Color(0xff202c33),
),
),
],
),
),
),


Container(
height: 60,
padding: const EdgeInsets.all(8),
color: const Color(0xff0b141a),

child: Row(
children: [

Expanded(
child: Container(
height: 45,

decoration: BoxDecoration(
border: Border.all(
color: const Color(0xff128c4a),
),
borderRadius:
BorderRadius.circular(25),
),

child: Row(
children: [

const SizedBox(width: 10),

const Icon(
Icons.camera_alt_outlined,
color: Colors.white,
),

const SizedBox(width: 10),

const Expanded(
child: Text(
'Type a Message ...',
style: TextStyle(
color: Colors.grey,
fontSize: 12,
),
),
),

const Icon(
Icons.send,
color: Colors.white,
),

const SizedBox(width: 10),
],
),
),
),

const SizedBox(width: 7),

Container(
width: 43,
height: 43,

decoration: const BoxDecoration(
color: Color(0xff128c4a),
shape: BoxShape.circle,
),
  child: const Icon(
    Icons.mic,
    color: Colors.white,
  ),
),
],
),
),
],
),
),
);
}


static Widget message(
    String text,
    Color color,
    ) {
  return Container(
    constraints: const BoxConstraints(
      maxWidth: 260,
    ),

    margin: const EdgeInsets.only(
      top: 7,
      bottom: 5,
    ),

    padding: const EdgeInsets.symmetric(
      horizontal: 12,
      vertical: 10,
    ),

    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(10),
    ),

    child: Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
        height: 1.3,
      ),
    ),
  );
}
}