import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ================= APP =================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ReviewScreen(),
    );
  }
}

// ================= SCREEN =================
class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int _rating = 0;
  final TextEditingController _reviewController = TextEditingController();

  final Color harvestGold = const Color(0xFFE1A36F);
  final Color smaltBlue = const Color(0xFF577E89);
  final Color hamptonLight = const Color(0xFFF2EBC7);

  @override
  void dispose() {
    _reviewController.dispose();
    super.dispose();
  }

  // ================= SUBMIT =================
  void _submitReview() {
    if (_rating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Mohon pilih rating bintang dulu!"),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Terima kasih! Review telah terkirim."),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );

    setState(() {
      _rating = 0;
      _reviewController.clear();
    });
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: harvestGold,
        title: const Text(
          "Review Mie Gacor Setan",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // USER
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: smaltBlue,
                  child: const Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 15),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ASUS User",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      "asus@email.com",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      "0812-3456-7890",
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),
            const Divider(),

            // PRODUK
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: hamptonLight,
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: harvestGold, width: 1.5),
              ),
              child: const ListTile(
                leading: CircleAvatar(
                  backgroundColor: Color(0xFF577E89),
                  child: Icon(Icons.restaurant, color: Colors.white),
                ),
                title: Text(
                  "Mie Gacor Setan - Lvl 8",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                subtitle: Text("ID: #GCR-99021"),
              ),
            ),

            const SizedBox(height: 30),
            const Center(
              child: Text(
                "Gimana tingkat pedas & rasanya?",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),

            // STAR
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return IconButton(
                  onPressed: () {
                    setState(() {
                      _rating = index + 1;
                    });
                  },
                  icon: Icon(
                    index < _rating
                        ? Icons.star_rounded
                        : Icons.star_outline_rounded,
                    color: harvestGold,
                    size: 45,
                  ),
                );
              }),
            ),

            const SizedBox(height: 20),
            const Text(
              "Tulis Ulasan:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            TextField(
              controller: _reviewController,
              maxLines: 4,
              decoration: InputDecoration(
                hintText: "Mienya nampol banget...",
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: _submitReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: harvestGold,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text(
                  "KIRIM REVIEW",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}