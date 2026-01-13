import 'package:flutter/material.dart';
import 'success_page.dart';

class QrisPage extends StatelessWidget {
  final int total;

  const QrisPage({super.key, required this.total});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pembayaran QRIS")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Total Pembayaran"),
            Text(
              "Rp $total",
              style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent),
            ),
            const SizedBox(height: 20),
            Image.asset(
              "assets/ternakaja.png",
              width: 220,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const SuccessPage(),
                  ),
                );
              },
              child: const Text("Bayar"),
            )
          ],
        ),
      ),
    );
  }
}
