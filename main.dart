// Student Name: John Njoroge Gachanja
// Reg Number: BIT/2024/74648
// Course Code: BIT4107 - Mobile Application Development
// Assignment: Week 3 Complete 5-Screen UI Prototype


import 'package:flutter/material.dart';

void main() {
  runApp(const StudentManagementApp());
}

class StudentManagementApp extends StatelessWidget {
  const StudentManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Portal Ecosystem',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(), // Screen 1
    );
  }
}

// Global shared static state database array for records simulation
final List<Map<String, String>> globalStudentDatabase = [
  {'name': 'John Njoroge', 'regNo': 'BIT/2024/74648', 'course': 'BSc. Information Technology'}
];

// ==========================================
// 1. SCREEN ONE: LOGIN PAGE
// ==========================================
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController(text: 'student');
  final TextEditingController _passwordController = TextEditingController(text: 'mku2026');

  void _handleLogin() {
    if (_loginFormKey.currentState!.validate()) {
      if (_usernameController.text == 'student' && _passwordController.text == 'mku2026') {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid Credentials! Use: student / mku2026')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Form(
                  key: _loginFormKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.lock_person, size: 70, color: Colors.deepPurple),
                      const SizedBox(height: 15),
                      const Text(
                        'Student Portal Login',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration(
                          labelText: 'Username',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) => value!.isEmpty ? 'Enter username' : null,
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.vpn_key),
                        ),
                        validator: (value) => value!.isEmpty ? 'Enter password' : null,
                      ),
                      const SizedBox(height: 30),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                          ),
                          onPressed: _handleLogin,
                          child: const Text('Login', style: TextStyle(color: Colors.white, fontSize: 16)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 2. SCREEN TWO: STUDENT DASHBOARD (MAIN HUB)
// ==========================================
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vault Student hub', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.white),
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back,Jon!',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.deepPurple),
            ),
            const Text('Select an operational module to begin management tasks.', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 25),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
                children: [
                  _buildMenuCard(
                    context,
                    title: 'Register Student',
                    icon: Icons.person_add,
                    color: Colors.deepPurple,
                    destination: const RegistrationPage(),
                  ),
                  _buildMenuCard(
                    context,
                    title: 'View Database',
                    icon: Icons.storage,
                    color: Colors.blue,
                    destination: const ViewRecordsPage(),
                  ),
                  _buildMenuCard(
                    context,
                    title: 'System Profile',
                    icon: Icons.analytics,
                    color: Colors.green,
                    destination: const ProfileAnalyticsPage(),
                  ),
                  _buildMenuCard(
                    context,
                    title: 'Portal Settings',
                    icon: Icons.settings,
                    color: Colors.orange,
                    destination: const SettingsPlaceholderPage(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, {required String title, required IconData icon, required Color color, required Widget destination}) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => destination)),
        borderRadius: BorderRadius.circular(15),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 45, color: color),
              const SizedBox(height: 12),
              Text(title, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 3. SCREEN THREE: STUDENT REGISTRATION PAGE
// ==========================================
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _regFormKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _regNoController = TextEditingController();
  String _selectedCourse = 'BSc. Information Technology';

  final List<String> _courses = [
    'BSc. Information Technology',
    'BSc. Computer Science',
    'BSc. Business Information Systems',
    'Diploma in IT'
  ];

  void _saveRecord() {
    if (_regFormKey.currentState!.validate()) {
      setState(() {
        globalStudentDatabase.add({
          'name': _nameController.text,
          'regNo': _regNoController.text,
          'course': _selectedCourse,
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Student Record Saved Successfully!')),
      );
      _nameController.clear();
      _regNoController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Registration', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _regFormKey,
          child: ListView(
            children: [
              const Icon(Icons.assignment_ind, size: 65, color: Colors.deepPurple),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person)),
                validator: (value) => value!.isEmpty ? 'Please enter name' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _regNoController,
                decoration: const InputDecoration(labelText: 'Registration Number', border: OutlineInputBorder(), prefixIcon: Icon(Icons.badge)),
                validator: (value) => value!.isEmpty ? 'Please enter reg number' : null,
              ),
              const SizedBox(height: 15),
              DropdownButtonFormField<String>(
                value: _selectedCourse,
                decoration: const InputDecoration(labelText: 'Course Program', border: OutlineInputBorder(), prefixIcon: Icon(Icons.book)),
                items: _courses.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
                onChanged: (val) => setState(() => _selectedCourse = val!),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple, padding: const EdgeInsets.symmetric(vertical: 15)),
                onPressed: _saveRecord,
                child: const Text('Save Record Locally', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 4. SCREEN FOUR: SYSTEM DATABASE VIEWER
// ==========================================
class ViewRecordsPage extends StatelessWidget {
  const ViewRecordsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Roster', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: globalStudentDatabase.isEmpty
          ? const Center(child: Text('No records found.'))
          : ListView.builder(
        itemCount: globalStudentDatabase.length,
        padding: const EdgeInsets.all(15),
        itemBuilder: (context, index) {
          final student = globalStudentDatabase[index];
          return Card(
            elevation: 2,
            margin: const EdgeInsets.only(bottom: 12),
            child: ListTile(
              leading: CircleAvatar(backgroundColor: Colors.deepPurple, child: Text('${index + 1}', style: const TextStyle(color: Colors.white))),
              title: Text(student['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('Reg No: ${student['regNo']!}\nCourse: ${student['course']!}'),
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// 5. SCREEN FIVE: SYSTEM PROFILE & ANALYTICS
// ==========================================
class ProfileAnalyticsPage extends StatelessWidget {
  const ProfileAnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('System Statistics', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const Card(
              color: Colors.deepPurple,
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Icon(Icons.verified_user, size: 50, color: Colors.white),
                    SizedBox(width: 15),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('System Operator', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                        Text('Role: Academic Registrar Node', style: TextStyle(color: Colors.white70)),
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.dns, color: Colors.blue),
              title: const Text('Total Database Records Indexed'),
              trailing: Text('${globalStudentDatabase.length}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.g_translate, color: Colors.green),
              title: Text('Cross-Platform Engine'),
              trailing: Text('Flutter Web SDK', style: TextStyle(fontWeight: FontWeight.w500)),
            ),
            const Divider(),
            const ListTile(
              leading: Icon(Icons.security, color: Colors.red),
              title: Text('Local Memory Sync State'),
              trailing: Text('ACTIVE', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

// PLACEHOLDER FOR DASHBOARD UI GRID SYMMETRY
class SettingsPlaceholderPage extends StatelessWidget {
  const SettingsPlaceholderPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), backgroundColor: Colors.deepPurple, iconTheme: const IconThemeData(color: Colors.white)),
      body: const Center(child: Text('System properties configuration panel running nominal.')),
    );
  }
}