import 'package:flutter/material.dart';

class SuccessPage extends StatelessWidget {
  const SuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.check_circle,
                size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              "Pembayaran Berhasil",
              style: TextStyle(
                  fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text("Terima kasih telah melakukan pembayaran"),
          ],
        ),
      ),
    );
  }
}
