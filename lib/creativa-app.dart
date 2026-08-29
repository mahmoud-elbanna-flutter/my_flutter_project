import 'package:flutter/material.dart';

void main() {
  runApp(const CreativaApp());
}

class CreativaApp extends StatelessWidget {
  const CreativaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Creativa App',
      theme: ThemeData(
        useMaterial3: false,
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFF7F7FC),
        primaryColor: const Color(0xFF4059C1),
      ),
      home: const LoginScreen(),
    );
  }
}

// ==================== LOGIN SCREEN ====================

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  void submit() {
    if (nameController.text.isEmpty || idController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your name and Student ID'),
        ),
      );
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(
          name: nameController.text,
          studentId: idController.text,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              children: [
                const SizedBox(height: 100),

                const Text(
                  'Creativa App',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4059C1),
                  ),
                ),

                const SizedBox(height: 40),

                Container(
                  width: 145,
                  height: 145,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF4059C1),
                    border: Border.all(
                      color: const Color(0xFF4059C1),
                      width: 4,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.school,
                      size: 70,
                      color: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(height: 80),

                buildTextField(
                  controller: nameController,
                  hint: 'Name',
                  icon: Icons.person_outline,
                ),

                const SizedBox(height: 20),

                buildTextField(
                  controller: idController,
                  hint: 'Student ID',
                  icon: Icons.badge_outlined,
                  keyboardType: TextInputType.number,
                ),

                const SizedBox(height: 45),

                SizedBox(
                  width: double.infinity,
                  height: 68,
                  child: ElevatedButton(
                    onPressed: submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF4059C1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Container(
      height: 68,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(
            icon,
            color: const Color(0xFF4059C1),
            size: 30,
          ),
          hintText: hint,
          hintStyle: const TextStyle(
            fontSize: 20,
            color: Colors.grey,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 20),
        ),
      ),
    );
  }
}

// ==================== MAIN SCREEN ====================

class MainScreen extends StatefulWidget {
  final String name;
  final String studentId;

  const MainScreen({
    super.key,
    required this.name,
    required this.studentId,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeScreen(
        name: widget.name,
        studentId: widget.studentId,
      ),
      const CoursesScreen(),
      ProfileScreen(
        name: widget.name,
        studentId: widget.studentId,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF4059C1),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Creativa App',
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),

      drawer: AppDrawer(
        name: widget.name,
        studentId: widget.studentId,
        onPageSelected: changePage,
      ),

      body: pages[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: changePage,
        selectedItemColor: const Color(0xFF4059C1),
        unselectedItemColor: Colors.grey,
        backgroundColor: const Color(0xFFFCF9FF),
        type: BottomNavigationBarType.fixed,
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
}

// ==================== HOME SCREEN ====================

class HomeScreen extends StatelessWidget {
  final String name;
  final String studentId;

  const HomeScreen({
    super.key,
    required this.name,
    required this.studentId,
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
              fontSize: 27,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),

          const SizedBox(height: 35),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              color: const Color(0xFFFCF9FF),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
                  blurRadius: 8,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xFF4059C1),
                  ),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 45,
                  ),
                ),

                const SizedBox(width: 22),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello, $name!',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Student ID: $studentId',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 40),

          const Text(
            'Use the menu or the bottom navigation bar to explore '
                'your courses, profile, and more.',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== COURSES SCREEN ====================

class CoursesScreen extends StatelessWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(28),
      children: [
        courseCard(
          icon: Icons.flutter_dash,
          title: 'Flutter Basics',
          description:
          'Learn the fundamentals of building apps with Flutter.',
        ),

        courseCard(
          icon: Icons.code,
          title: 'Dart Programming',
          description:
          'Understand the Dart language that powers Flutter.',
        ),

        courseCard(
          icon: Icons.design_services,
          title: 'UI/UX Fundamentals',
          description:
          'Learn how to design clean and user-friendly interfaces.',
        ),

        courseCard(
          icon: Icons.hub,
          title: 'Git & GitHub',
          description:
          'Learn version control and how to collaborate on code.',
        ),
      ],
    );
  }

  Widget courseCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 25),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFFCF9FF),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 6,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFF4059C1),
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 32,
            ),
          ),

          const SizedBox(width: 20),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 7),

                Text(
                  description,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.grey,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==================== PROFILE SCREEN ====================

class ProfileScreen extends StatelessWidget {
  final String name;
  final String studentId;

  const ProfileScreen({
    super.key,
    required this.name,
    required this.studentId,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(32),
      children: [
        Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: const Color(0xFFFCF9FF),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.15),
                blurRadius: 7,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 140,
                height: 140,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF4059C1),
                ),
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                  size: 80,
                ),
              ),

              const SizedBox(width: 25),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    'ID: $studentId',
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        const SizedBox(height: 45),

        Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
            color: const Color(0xFFFCF9FF),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.12),
                blurRadius: 7,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              infoRow(
                icon: Icons.person,
                title: 'Name:',
                value: name,
              ),

              const Divider(height: 30),

              infoRow(
                icon: Icons.badge,
                title: 'Student ID:',
                value: studentId,
              ),

              const Divider(height: 30),

              infoRow(
                icon: Icons.school,
                title: 'Organization:',
                value: 'Creativa App',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget infoRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Icon(
          icon,
          color: const Color(0xFF4059C1),
          size: 30,
        ),

        const SizedBox(width: 20),

        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(width: 5),

        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.grey,
            ),
          ),
        ),
      ],
    );
  }
}

// ==================== DRAWER ====================

class AppDrawer extends StatelessWidget {
  final String name;
  final String studentId;
  final Function(int) onPageSelected;

  const AppDrawer({
    super.key,
    required this.name,
    required this.studentId,
    required this.onPageSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.78,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 260,
            color: const Color(0xFF4059C1),
            padding: const EdgeInsets.only(
              left: 25,
              top: 65,
            ),
            child: Row(
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: const Icon(
                    Icons.person,
                    size: 55,
                    color: Color(0xFF4059C1),
                  ),
                ),

                const SizedBox(width: 22),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      'ID: $studentId',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          drawerItem(
            context,
            icon: Icons.home,
            title: 'Home',
            index: 0,
          ),

          drawerItem(
            context,
            icon: Icons.person,
            title: 'Profile',
            index: 2,
          ),

          drawerItem(
            context,
            icon: Icons.school,
            title: 'Courses',
            index: 1,
          ),

          drawerItem(
            context,
            icon: Icons.info,
            title: 'About',
            index: -1,
          ),

          drawerItem(
            context,
            icon: Icons.settings,
            title: 'Settings',
            index: -1,
          ),

          const Divider(),

          ListTile(
            leading: const Icon(
              Icons.logout,
              color: Colors.red,
              size: 30,
            ),
            title: const Text(
              'Logout',
              style: TextStyle(
                fontSize: 19,
              ),
            ),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginScreen(),
                ),
                    (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget drawerItem(
      BuildContext context, {
        required IconData icon,
        required String title,
        required int index,
      }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 25,
        vertical: 5,
      ),
      leading: Icon(
        icon,
        color: const Color(0xFF4059C1),
        size: 30,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 19,
        ),
      ),
      onTap: () {
        Navigator.pop(context);

        if (index != -1) {
          onPageSelected(index);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$title page is not available yet'),
            ),
          );
        }
      },
    );
  }
}