import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

/// =======================
/// APP UTAMA
/// =======================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: KeranjangScreen(),
    );
  }
}

/// =======================
/// HALAMAN KERANJANG
/// =======================
class KeranjangScreen extends StatelessWidget {
  const KeranjangScreen({super.key});

  final List<Map<String, dynamic>> cartItems = const [
    {'nama': 'Mie Kuah Kacang', 'harga': 14000, 'jumlah': 2},
    {'nama': 'Mie tek', 'harga': 16000, 'jumlah': 1},
    {'nama': 'Nasi Jeruk', 'harga': 8000, 'jumlah': 1},
  ];

  int getTotalHarga() {
    int total = 0;
    for (var item in cartItems) {
      total += (item['harga'] as int) * (item['jumlah'] as int);
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      leading: IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
      Navigator.pop(context); // 🔙 kembali ke halaman sebelumnya
    },
  ),
        title: const Text('Pesanan Saya'),
        backgroundColor: const Color.fromARGB(255, 243, 171, 38),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: cartItems.length,
                itemBuilder: (context, index) {
                  final item = cartItems[index];
                  return Card(
                    child: ListTile(
                      title: Text(item['nama']),
                      subtitle:
                          Text('Rp ${item['harga']} x ${item['jumlah']}'),
                      trailing: Text(
                        'Rp ${(item['harga'] as int) * (item['jumlah'] as int)}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Total: Rp ${getTotalHarga()}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 243, 171, 38),
                foregroundColor: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const StatusPesananScreen(),
                  ),
                );
              },
              child: const Text('Next'),
            ),
          ],
        ),
      ),
    );
  }
}

/// =======================
/// HALAMAN STATUS PESANAN
/// =======================
class StatusPesananScreen extends StatefulWidget {
  const StatusPesananScreen({super.key});

  @override
  State<StatusPesananScreen> createState() => _StatusPesananScreenState();
}

class _StatusPesananScreenState extends State<StatusPesananScreen> {
  bool selesai = false;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      setState(() {
        selesai = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Status Pesanan'),
        backgroundColor: const Color.fromARGB(255, 243, 171, 38),
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: selesai
                    ? Colors.green.withOpacity(0.15)
                    : Colors.orange.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    selesai ? Icons.check_circle : Icons.access_time,
                    color: selesai ? Colors.green : Colors.orange,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    selesai
                        ? 'Pesanan Selesai'
                        : 'Pesanan Sedang Dibuat',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: selesai ? Colors.green : Colors.orange,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Text(
              selesai
                  ? 'Terima kasih, pesanan kamu sudah selesai.'
                  : 'Mohon tunggu, pesanan sedang dibuat.',
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 30),

            if (selesai)
              ElevatedButton(
                onPressed: () {
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: const Text('Kembali ke Beranda'),
              ),
          ],
        ),
      ),
    );
  }
}
