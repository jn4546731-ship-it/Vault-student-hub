import 'package:flutter/material.dart';
import 'dart:convert';

void main() {
  runApp(const VaultStudentHubApp());
}

class VaultStudentHubApp extends StatelessWidget {
  const VaultStudentHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vault Student Hub',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/registration': (context) => const StudentRegistrationScreen(),
        '/attendance': (context) => const AttendanceManagementScreen(),
        '/api_consumer': (context) => const ApiConsumerScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// ==========================================
// 🔐 MODULE 1: LOGIN SCREEN
// ==========================================
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _admissionController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _handleLogin() {
    if (_formKey.currentState!.validate()) {
      if (_admissionController.text == "BIT/2024/74648") {
        Navigator.pushReplacementNamed(context, '/dashboard');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid Student Credentials (401)')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24.0),
          constraints: const BoxConstraints(maxWidth: 400),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Icon(Icons.lock_outline, size: 80, color: Colors.blueAccent),
                const SizedBox(height: 16),
                const Text(
                  'VAULT STUDENT HUB',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, letterSpacing: 1.5),
                ),
                const SizedBox(height: 32),
                TextFormField(
                  controller: _admissionController,
                  decoration: const InputDecoration(
                    labelText: 'Admission Number',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) => value!.isEmpty ? 'Enter your admission number' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.security),
                  ),
                  validator: (value) => value!.isEmpty ? 'Enter your security token' : null,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _handleLogin,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.blueAccent,
                  ),
                  child: const Text('AUTHENTICATE', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 📊 MODULE 2: MASTER DASHBOARD SCREEN
// ==========================================
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vault Student Hub'),
        backgroundColor: Colors.black12,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Welcome back John',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            const SizedBox(height: 8),
            const Text(
              'Academic Track: BSIT | System Active',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  _buildMenuCard(
                      context,
                      title: 'Student Directory',
                      subtitle: 'Manage Profiles (Task 2)',
                      icon: Icons.badge,
                      route: '/registration',
                      color: Colors.blueAccent
                  ),
                  _buildMenuCard(
                      context,
                      title: 'Attendance Tracker',
                      subtitle: 'Class Roll Ledger (Task 3)',
                      icon: Icons.how_to_reg,
                      route: '/attendance',
                      color: Colors.greenAccent
                  ),
                  _buildMenuCard(
                      context,
                      title: 'API Terminal',
                      subtitle: 'External REST Portal',
                      icon: Icons.cloud_sync,
                      route: '/api_consumer',
                      color: Colors.orangeAccent
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuCard(BuildContext context, {required String title, required String subtitle, required IconData icon, required String route, required Color color}) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: const Color(0xFF1E1E1E),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 40, color: color),
              const SizedBox(height: 12),
              Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(fontSize: 10, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 🗄️ DATA CORE: SHARED RELATIONAL SIMULATION STATE
// ==========================================
// Global dummy relational state layer mirroring SQLite tables structure
class LocalDatabaseSimulation {
  // Task 2: Students Table Structure
  static final List<Map<String, String>> studentsTable = [
    {"student_id": "BIT/2024/74648", "student_name": "John Njoroge", "course": "BIT", "year": "3", "phone": "0712345678"},
    {"student_id": "BIT/2024/99999", "student_name": "Samuel Kamau", "course": "BCS", "year": "3", "phone": "0787654321"},
  ];

  // Task 3: Attendance Ledger Table Structure
  static final List<Map<String, String>> attendanceTable = [
    {"record_id": "1", "student_id": "BIT/2024/74648", "date": "2026-06-17", "status": "Present"},
  ];
}

// ==========================================
// 📋 MODULE 3: TASK 2 STUDENT REGISTRATION
// ==========================================
class StudentRegistrationScreen extends StatefulWidget {
  const StudentRegistrationScreen({super.key});

  @override
  State<StudentRegistrationScreen> createState() => _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _courseController = TextEditingController();
  final _phoneController = TextEditingController();

  // Simulated SQL Operation: INSERT INTO Students
  void _executeInsertCommand() {
    if (_idController.text.isNotEmpty && _nameController.text.isNotEmpty) {
      setState(() {
        LocalDatabaseSimulation.studentsTable.add({
          "student_id": _idController.text,
          "student_name": _nameController.text,
          "course": _courseController.text,
          "year": "3",
          "phone": _phoneController.text,
        });
      });
      _idController.clear();
      _nameController.clear();
      _courseController.clear();
      _phoneController.clear();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('SQL Command Executed: INSERT SUCCESS')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Directory Database'), backgroundColor: Colors.black12),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: LocalDatabaseSimulation.studentsTable.length,
        itemBuilder: (context, index) {
          final student = LocalDatabaseSimulation.studentsTable[index];
          return Card(
            color: const Color(0xFF1E1E1E),
            child: ListTile(
              leading: const CircleAvatar(backgroundColor: Colors.blueAccent, child: Icon(Icons.person, color: Colors.white)),
              title: Text(student['student_name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text('ID: ${student['student_id']} | Prog: ${student['course']} \nContact: ${student['phone']}'),
              isThreeLine: true,
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('SQL Execution Window: CREATE STUDENT', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                TextField(controller: _idController, decoration: const InputDecoration(labelText: 'Student ID (PK)')),
                TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Full Name')),
                TextField(controller: _courseController, decoration: const InputDecoration(labelText: 'Course Program')),
                TextField(controller: _phoneController, decoration: const InputDecoration(labelText: 'Phone Number')),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _executeInsertCommand,
                  style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(45), backgroundColor: Colors.blueAccent),
                  child: const Text('EXECUTE INSERT', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 📅 MODULE 4: TASK 3 ATTENDANCE TRACKER
// ==========================================
class AttendanceManagementScreen extends StatefulWidget {
  const AttendanceManagementScreen({super.key});

  @override
  State<AttendanceManagementScreen> createState() => _AttendanceManagementScreenState();
}

class _AttendanceManagementScreenState extends State<AttendanceManagementScreen> {
  String _selectedStatus = "Present";

  // Simulated SQL Operation: INSERT INTO Attendance_Records (Relational FK Mapping)
  void _markAttendance(String studentId) {
    setState(() {
      LocalDatabaseSimulation.attendanceTable.add({
        "record_id": (LocalDatabaseSimulation.attendanceTable.length + 1).toString(),
        "student_id": studentId,
        "date": "2026-06-17",
        "status": _selectedStatus,
      });
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Attendance Logged for $studentId -> $_selectedStatus')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Class Attendance Ledger'), backgroundColor: Colors.black12),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Roster Action Status:', style: TextStyle(color: Colors.grey)),
            Row(
              children: [
                Radio<String>(
                  value: "Present",
                  groupValue: _selectedStatus,
                  onChanged: (val) => setState(() => _selectedStatus = val!),
                ),
                const Text("Present"),
                const SizedBox(width: 20),
                Radio<String>(
                  value: "Absent",
                  groupValue: _selectedStatus,
                  onChanged: (val) => setState(() => _selectedStatus = val!),
                ),
                const Text("Absent"),
              ],
            ),
            const Divider(height: 32, color: Colors.white24),
            const Text('Active Student Database Roster:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: LocalDatabaseSimulation.studentsTable.length,
                itemBuilder: (context, index) {
                  final student = LocalDatabaseSimulation.studentsTable[index];

                  // Compute Relational SQL aggregation logic (Count instances matching current key)
                  final attendanceCount = LocalDatabaseSimulation.attendanceTable
                      .where((rec) => rec['student_id'] == student['student_id'] && rec['status'] == 'Present')
                      .length;

                  return Card(
                    color: const Color(0xFF1E1E1E),
                    child: ListTile(
                      title: Text(student['student_name']!),
                      subtitle: Text('ID: ${student['student_id']} \nTotal Sessions Attended: $attendanceCount'),
                      trailing: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                        onPressed: () => _markAttendance(student['student_id']!),
                        child: const Text('LOG STATUS', style: TextStyle(color: Colors.white, fontSize: 11)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// 🌐 MODULE 5: ASYNCHRONOUS REST API PORTAL
// ==========================================
class ApiConsumerScreen extends StatefulWidget {
  const ApiConsumerScreen({super.key});

  @override
  State<ApiConsumerScreen> createState() => _ApiConsumerScreenState();
}

class _ApiConsumerScreenState extends State<ApiConsumerScreen> {
  bool _isLoading = false;
  List<dynamic> _fetchedJsonRecords = [];

  Future<void> fetchRemoteApiData() async {
    setState(() { _isLoading = true; });
    await Future.delayed(const Duration(milliseconds: 1000));
    String rawMockJsonStream = '[{"id": 101, "name": "Dr. Charles Nyoro", "role": "Department Head"}, {"id": 102, "name": "Computing Lab Alpha", "role": "Gateway Server"}]';
    setState(() {
      _fetchedJsonRecords = jsonDecode(rawMockJsonStream);
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchRemoteApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('REST API Data Terminal'), backgroundColor: Colors.black12),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator(color: Colors.blueAccent))
          : ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _fetchedJsonRecords.length,
        itemBuilder: (context, index) {
          final node = _fetchedJsonRecords[index];
          return Card(
            color: const Color(0xFF181818),
            child: ListTile(
              leading: const Icon(Icons.cloud_done, color: Colors.orangeAccent),
              title: Text(node['name']),
              subtitle: Text('Role: ${node['role']}'),
            ),
          );
        },
      ),
    );
  }
}