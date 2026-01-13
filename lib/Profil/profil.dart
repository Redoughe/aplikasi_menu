import 'package:flutter/material.dart';
import 'akun.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String name = "Username123";
  String email = "user123@gmail.com";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Akun",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),

            /// ===== HEADER PROFILE =====
            Column(
              children: [
                const CircleAvatar(
                  radius: 40,
                  child: Icon(Icons.person, size: 40),
                ),
                const SizedBox(height: 12),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// ===== POINT CARD =====
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: const Icon(Icons.star, color: Color(0xFFFF8C00)),
                  title: const Text("POIN MEMBER"),
                  subtitle: const Text(
                    "1200 Poin",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {},
                ),
              ),
            ),

            const SizedBox(height: 16),

            /// ===== MENU =====
            _menuItem(
              icon: Icons.receipt_long,
              title: "Transaksi",
              onTap: () {},
            ),

            _menuItem(
              icon: Icons.person_outline,
              title: "Akun",
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => AccountDetailPage(
                      name: name,
                      email: email,
                    ),
                  ),
                );

                if (result != null) {
                  setState(() {
                    name = result['name'];
                    email = result['email'];
                  });
                }
              },
            ),

            const Divider(height: 32),

            _menuItem(
              icon: Icons.description_outlined,
              title: "Syarat & Ketentuan",
              onTap: () {},
            ),

            _menuItem(
              icon: Icons.privacy_tip_outlined,
              title: "Kebijakan Privasi",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}