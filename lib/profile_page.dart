import 'package:flutter/material.dart';
import 'login_page.dart'; // นำเข้าหน้า LoginPage

class ProfilePage extends StatelessWidget {
  final String username; // ตัวแปรสำหรับชื่อผู้ใช้
  final String email; // ตัวแปรสำหรับอีเมล

  const ProfilePage({Key? key, required this.username, required this.email}) : super(key: key);

  void logout(BuildContext context) {
    // นำผู้ใช้ไปยังหน้า Login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              'User Profile',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 16.0),
            // แสดงข้อมูลผู้ใช้
            ListTile(
              title: const Text('Username'),
              subtitle: Text(username), // แสดงชื่อผู้ใช้
            ),
            ListTile(
              title: const Text('Email'),
              subtitle: Text(email), // แสดงอีเมล
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => logout(context), // เรียกใช้ฟังก์ชัน logout
              child: const Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // กำหนดสีพื้นหลังของปุ่ม
              ),
            ),
          ],
        ),
      ),
    );
  }
}
