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
      home: const HotelsPage(),
    );
  }
}

class HotelsPage extends StatelessWidget {
  const HotelsPage({super.key});

  final List<Map<String, String>> hotels = const [
    {
      'name': 'Sharm El Shikh',
      'image': 'assets/1.jpg',
    },
    {
      'name': 'Alexandria',
      'image': 'assets/2.jpg',
    },
    {
      'name': 'Dahab',
      'image': 'assets/3.jpg',
    },
    {
      'name': 'Marasy',
      'image': 'assets/4.jpg',
    },
    {
      'name': 'Nile',
      'image': 'assets/5.jpg',
    },
    {
      'name': 'Aswan',
      'image': 'assets/6.jpg',
    },
    {
      'name': 'Hurghada',
      'image': 'assets/7.jpg',
    },
    {
      'name': 'El Gouna',
      'image': 'assets/8.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const Text(
                'Home',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                height: 45,
                decoration: BoxDecoration(
                  color: const Color(0xff07549A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Available Hotels',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 6),

              Expanded(
                child: GridView.builder(
                  itemCount: hotels.length,
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 6,
                    childAspectRatio: 0.85,
                  ),
                  itemBuilder: (context, index) {
                    return HotelCard(
                      name: hotels[index]['name']!,
                      image: hotels[index]['image']!,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HotelCard extends StatelessWidget {
final String name;
final String image;

const HotelCard({
super.key,
required this.name,
required this.image,
});

@override
Widget build(BuildContext context) {
return Container(
decoration: BoxDecoration(
borderRadius: BorderRadius.circular(12),
),

child: ClipRRect(
borderRadius: BorderRadius.circular(12),

child: Stack(
children: [

Positioned.fill(
child: Image.asset(
image,
fit: BoxFit.cover,
),
),

Positioned(
bottom: 6,
left: 5,
right: 5,

child: Container(
height: 30,
decoration: BoxDecoration(
color: const Color(0xff07549A),
borderRadius: BorderRadius.circular(20),
),
  child: Center(
    child: Text(
      name,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
),
),
],
),
),
);
}
}