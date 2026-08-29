import 'package:flutter/material.dart';

const blue = Color(0xFF4059C1);

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Creativa App',
      theme: ThemeData(
        primaryColor: blue,
        scaffoldBackgroundColor: const Color(0xFFF7F7FC),
      ),
      home: const Login(),
    );
  }
}

// ================= LOGIN =================

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    idController.dispose();
    super.dispose();
  }

  void submit() {
    if (nameController.text.trim().isEmpty ||
        idController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter Name and Student ID'),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Main(
          name: nameController.text,
          id: idController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            children: [
              const SizedBox(height: 70),

              const Text(
                'Creativa App',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: blue,
                ),
              ),

              const SizedBox(height: 35),

              ClipOval(
                child: Image.asset(
                  'assets/photo_2026-08-29_22-54-16.jpg',
                  width: 140,
                  height: 140,
                  fit: BoxFit.cover,
                ),
              ),

              const SizedBox(height: 60),

              TextField(
                controller: nameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  hintText: 'Name',
                  prefixIcon: const Icon(
                    Icons.person,
                    color: blue,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: idController,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  hintText: 'Student ID',
                  prefixIcon: const Icon(
                    Icons.badge,
                    color: blue,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  onPressed: submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ================= MAIN =================

class Main extends StatefulWidget {
  final String name;
  final String id;

  const Main({
    super.key,
    required this.name,
    required this.id,
  });

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      Home(widget.name, widget.id),
      const Courses(),
      Profile(widget.name, widget.id),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue,
        centerTitle: true,
        title: const Text('Creativa App'),
      ),

      drawer: buildDrawer(),

      body: pages[index],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: blue,
        onTap: (i) {
          setState(() {
            index = i;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'Courses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: blue,
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: blue,
                  ),
                ),

                const SizedBox(width: 15),

                Text(
                  '${widget.name}\nID: ${widget.id}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),

          drawerItem(
            Icons.home,
            'Home',
                () {
              Navigator.pop(context);
              setState(() {
                index = 0;
              });
            },
          ),

          drawerItem(
            Icons.person,
            'Profile',
                () {
              Navigator.pop(context);
              setState(() {
                index = 2;
              });
            },
          ),

          drawerItem(
            Icons.school,
            'Courses',
                () {
              Navigator.pop(context);
              setState(() {
                index = 1;
              });
            },
          ),

          drawerItem(
            Icons.info,
            'About',
                () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const About(),
                ),
              );
            },
          ),

          drawerItem(
            Icons.settings,
            'Settings',
                () {
              Navigator.pop(context);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Settings(),
                ),
              );
            },
          ),

          const Divider(),

          drawerItem(
            Icons.logout,
            'Logout',
                () {
              logout();
            },
            color: Colors.red,
          ),
        ],
      ),
    );
  }

  Widget drawerItem(
      IconData icon,
      String title,
      VoidCallback action, {
        Color color = blue,
      }) {
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(title),
      onTap: action,
    );
  }

  void logout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text(
            'Are you sure you want to logout?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),

            TextButton(
              onPressed: () {
                Navigator.pop(context);

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(),
                  ),
                      (route) => false,
                );
              },
              child: const Text(
                'Logout',
                style: TextStyle(
                  color: Colors.red,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

// ================= HOME =================

class Home extends StatelessWidget {
  final String name;
  final String id;

  const Home(
      this.name,
      this.id, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome to Creativa App',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 30),

          card(
            Row(
              children: [
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: blue,
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 40,
                  ),
                ),

                const SizedBox(width: 20),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, $name!',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      'Student ID: $id',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 30),

          const Text(
            'Use the menu or the bottom navigation bar to explore '
                'your courses, profile, and more.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}

// ================= COURSES =================

class Courses extends StatelessWidget {
  const Courses({super.key});

  @override
  Widget build(BuildContext context) {
    final courses = [
      [
        'Flutter Basics',
        'Learn the fundamentals of building apps with Flutter.',
        Icons.flutter_dash
      ],
      [
        'Dart Programming',
        'Understand the Dart language that powers Flutter.',
        Icons.code
      ],
      [
        'UI/UX Fundamentals',
        'Learn how to design clean and user-friendly interfaces.',
        Icons.design_services
      ],
      [
        'Git & GitHub',
        'Learn version control and how to collaborate on code.',
        Icons.hub
      ],
    ];

    return ListView(
      padding: const EdgeInsets.all(28),
      children: courses.map((course) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: card(
            Row(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: blue,
                  child: Icon(
                    course[2] as IconData,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(width: 18),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        course[0] as String,
                        style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        course[1] as String,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

// ================= PROFILE =================

class Profile extends StatelessWidget {
  final String name;
  final String id;

  const Profile(
      this.name,
      this.id, {
        super.key,
      });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(30),
      children: [
        card(
          Row(
            children: [
              const CircleAvatar(
                radius: 65,
                backgroundColor: blue,
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 70,
                ),
              ),

              const SizedBox(width: 20),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    'ID: $id',
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 35),

        card(
          Column(
            children: [
              info(
                Icons.person,
                'Name:',
                name,
              ),

              const Divider(),

              info(
                Icons.badge,
                'Student ID:',
                id,
              ),

              const Divider(),

              info(
                Icons.school,
                'Organization:',
                'Creativa App',
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ================= ABOUT =================

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        centerTitle: true,
        backgroundColor: blue,
      ),

      body: const Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: blue,
              child: Icon(
                Icons.school,
                color: Colors.white,
                size: 45,
              ),
            ),

            SizedBox(height: 15),

            Text(
              'Creativa App',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 5),

            Text(
              'Learn Flutter step by step.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            SizedBox(height: 20),

            Text(
              'Creativa App is a place where beginners learn '
                  'the fundamentals of mobile app development using '
                  'Flutter and Dart. Our courses are designed to be '
                  'simple, practical, and easy to follow, helping '
                  'students build real projects from day one.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ================= SETTINGS =================

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool dark = false;
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: blue,
      ),

      body: Column(
        children: [
          SwitchListTile(
            secondary: const Icon(
              Icons.dark_mode,
              color: blue,
            ),

            title: const Text('Dark Mode'),

            subtitle: const Text(
              'Enable dark theme',
            ),

            value: dark,

            activeThumbColor: blue,

            onChanged: (value) {
              setState(() {
                dark = value;
              });
            },
          ),

          SwitchListTile(
            secondary: const Icon(
              Icons.notifications,
              color: blue,
            ),

            title: const Text('Notifications'),

            subtitle: const Text(
              'Receive updates from the training center',
            ),

            value: notifications,

            activeThumbColor: blue,

            onChanged: (value) {
              setState(() {
                notifications = value;
              });
            },
          ),
        ],
      ),
    );
  }
}

// ================= CARD =================

Widget card(Widget child) {
  return Container(
    padding: const EdgeInsets.all(20),

    decoration: BoxDecoration(
      color: const Color(0xFFFCF9FF),
      borderRadius: BorderRadius.circular(18),

      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: .12),
          blurRadius: 7,
          offset: const Offset(0, 4),
        ),
      ],
    ),

    child: child,
  );
}

// ================= INFO =================

Widget info(
    IconData icon,
    String title,
    String value,
    ) {
  return ListTile(
    leading: Icon(
      icon,
      color: blue,
    ),

    title: Text(
      '$title $value',
      style: const TextStyle(
        fontSize: 16,
      ),
    ),
  );
}