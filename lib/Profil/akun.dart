import 'package:flutter/material.dart';

class AccountDetailPage extends StatefulWidget {
  final String name;
  final String email;

  const AccountDetailPage({
    super.key,
    required this.name,
    required this.email,
  });

  @override
  State<AccountDetailPage> createState() => _AccountDetailPageState();
}

class _AccountDetailPageState extends State<AccountDetailPage> {
  late String fullName;
  late String email;

  @override
  void initState() {
    super.initState();
    fullName = widget.name;
    email = widget.email;
  }

  void _saveAndBack() {
    Navigator.pop(context, {
      'name': fullName,
      'email': email,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: _saveAndBack,
        ),
        title: const Text(
          "Akun",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          TextButton(
            onPressed: _saveAndBack,
            child: const Text("Simpan"),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// FOTO PROFIL
            Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 60,
                    child: Icon(Icons.person, size: 60),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {},
                    child: const Text("Ubah Foto Profil"),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Format foto harus .jpg .jpeg .png dan ukuran file max 2mb.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            const Text(
              "Pengaturan Profil",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            _item(
              "Nama Lengkap",
              fullName,
              () => _editText(
                title: "Nama Lengkap",
                value: fullName,
                onSave: (v) => setState(() => fullName = v),
              ),
            ),

            _item(
              "Email",
              email,
              () => _editText(
                title: "Email",
                value: email,
                onSave: (v) => setState(() => email = v),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _item(String title, String value, VoidCallback onEdit) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: onEdit,
          ),
        ],
      ),
    );
  }

  void _editText({
    required String title,
    required String value,
    required Function(String) onSave,
  }) {
    final controller = TextEditingController(text: value);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text("Ubah $title"),
        content: TextField(controller: controller),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Batal"),
          ),
          ElevatedButton(
            onPressed: () {
              onSave(controller.text);
              Navigator.pop(context);
            },
            child: const Text("Simpan"),
          ),
        ],
      ),
    );
  }
}