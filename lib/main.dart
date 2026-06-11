import 'package:flutter/material.dart';
import 'dart:convert'; // For Week 5 JSON formatting mechanisms

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
        '/api_consumer': (context) => const ApiConsumerScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}

// ==========================================
// 🔐 MODULE 1: LOGIN SCREEN (Week 4 Security)
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
      // Basic authentication input validation logic
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
// 📊 MODULE 2: RECONFIGURED DASHBOARD SCREEN
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
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Navigator.pushReplacementNamed(context, '/'),
          )
        ],
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
              'Academic Track: BSIT | Registration System Operational',
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
                      title: 'Local CRUD System',
                      subtitle: 'SQLite Management App',
                      icon: Icons.storage,
                      route: '/registration',
                      color: Colors.greenAccent
                  ),
                  _buildMenuCard(
                      context,
                      title: 'API Consumer',
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
              const SizedBox(height: 16),
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(subtitle, style: const TextStyle(fontSize: 11, color: Colors.grey)),
            ],
          ),
        ),
      ),
    );
  }
}

// ==========================================
// 🗄️ MODULE 3: WEEK 4 LOCAL CRUD ENGINE
// ==========================================
class StudentRegistrationScreen extends StatefulWidget {
  const StudentRegistrationScreen({super.key});

  @override
  State<StudentRegistrationScreen> createState() => _StudentRegistrationScreenState();
}

class _StudentRegistrationScreenState extends State<StudentRegistrationScreen> {
  // In-memory data relational mapping mirroring relational tables
  final List<Map<String, dynamic>> _studentDatabase = [
    {"id": 1, "name": "John Njoroge", "course": "BIT"},
    {"id": 2, "name": "Samuel Kamau", "course": "BCS"},
  ];

  final _nameController = TextEditingController();
  final _courseController = TextEditingController();
  final _searchController = TextEditingController();
  int _nextId = 3;
  String _searchQuery = "";

  // CRUD Operation: Create Record
  void _createRecord() {
    if (_nameController.text.isNotEmpty && _courseController.text.isNotEmpty) {
      setState(() {
        _studentDatabase.add({
          "id": _nextId++,
          "name": _nameController.text,
          "course": _courseController.text,
        });
        _nameController.clear();
        _courseController.clear();
      });
      Navigator.pop(context);
    }
  }

  // CRUD Operation: Update Record
  void _updateRecord(int id, String currentName, String currentCourse) {
    _nameController.text = currentName;
    _courseController.text = currentCourse;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Update Student Record'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Name')),
            TextField(controller: _courseController, decoration: const InputDecoration(labelText: 'Course Code')),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              setState(() {
                final target = _studentDatabase.firstWhere((element) => element['id'] == id);
                target['name'] = _nameController.text;
                target['course'] = _courseController.text;
              });
              _nameController.clear();
              _courseController.clear();
              Navigator.pop(context);
            },
            child: const Text('Save Changes'),
          )
        ],
      ),
    );
  }

  // CRUD Operation: Delete Record
  void _deleteRecord(int id) {
    setState(() {
      _studentDatabase.removeWhere((element) => element['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Dynamic structural search filtering array updates
    final filteredRecords = _studentDatabase.where((student) {
      return student['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          student['course'].toString().toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('SQLite Record Management'), backgroundColor: Colors.black12),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: const InputDecoration(
                labelText: 'Search Records...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: filteredRecords.length,
                itemBuilder: (context, index) {
                  final record = filteredRecords[index];
                  return Card(
                    color: const Color(0xFF1E1E1E),
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        child: Text(record['id'].toString(), style: const TextStyle(color: Colors.white)),
                      ),
                      title: Text(record['name']),
                      subtitle: Text('Course Field: ${record['course']}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blueAccent),
                            onPressed: () => _updateRecord(record['id'], record['name'], record['course']),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => _deleteRecord(record['id']),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 16, right: 16, top: 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Insert Data Record', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  TextField(controller: _nameController, decoration: const InputDecoration(labelText: 'Full Name')),
                  TextField(controller: _courseController, decoration: const InputDecoration(labelText: 'Course Name')),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _createRecord,
                    style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(45)),
                    child: const Text('Execute INSERT'),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// ==========================================
// 🌐 MODULE 4: WEEK 5 ASYNCHRONOUS REST API PORTAL
// ==========================================
class ApiConsumerScreen extends StatefulWidget {
  const ApiConsumerScreen({super.key});

  @override
  State<ApiConsumerScreen> createState() => _ApiConsumerScreenState();
}

class _ApiConsumerScreenState extends State<ApiConsumerScreen> {
  bool _isLoading = false;
  String _errorMessage = "";
  List<dynamic> _fetchedJsonRecords = [];

  // Async task framework processing simulated endpoint response safely
  Future<void> fetchRemoteApiData() async {
    setState(() {
      _isLoading = true;
      _errorMessage = "";
    });

    try {
      // Emulating network server call latency safely
      await Future.delayed(const Duration(milliseconds: 1500));

      // JSON Serialization String stream (Week 5 Standard payload mapping layout)
      String rawMockJsonStream = '[{"id": 101, "name": "Dr. Charles Nyoro", "role": "Department Head", "email": "nyoro@mku.ac.ke"}, {"id": 102, "name": "Computing Lab Alpha", "role": "Server Node Gateway", "email": "gateway@vsh.io"}]';

      setState(() {
        _fetchedJsonRecords = jsonDecode(rawMockJsonStream);
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _errorMessage = "Timeout or 500 Server Error encountered.";
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchRemoteApiData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('REST API Data Terminal'),
        backgroundColor: Colors.black12,
        actions: [IconButton(icon: const Icon(Icons.refresh), onPressed: fetchRemoteApiData)],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator(color: Colors.blueAccent))
            : _errorMessage.isNotEmpty
            ? Center(child: Text(_errorMessage, style: const TextStyle(color: Colors.redAccent)))
            : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('GET /api/v1/endpoints structural mapping stream:', style: TextStyle(color: Colors.grey, fontFamily: 'monospace', fontSize: 12)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: _fetchedJsonRecords.length,
                itemBuilder: (context, index) {
                  final node = _fetchedJsonRecords[index];
                  return Card(
                    color: const Color(0xFF181818),
                    borderOnForeground: true,
                    shape: RoundedRectangleBorder(side: const BorderSide(color: Colors.white10), borderRadius: BorderRadius.circular(8)),
                    child: ListTile(
                      leading: const Icon(Icons.cloud_done, color: Colors.orangeAccent),
                      title: Text(node['name'], style: const TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Text('Role: ${node['role']} \nData Identity: ${node['email']}'),
                      trailing: const Icon(Icons.arrow_right, color: Colors.grey),
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