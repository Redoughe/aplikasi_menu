import 'package:flutter/material.dart';
import 'review.dart';

// --- MODEL DATA ---
class ReviewData {
  final String name;
  final int rating;
  final String comment;

  ReviewData({required this.name, required this.rating, required this.comment});
}

// --- PENAMPUNG DATA GLOBAL ---
List<ReviewData> reviewList = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const ReviewScreen(),
    );
  }
}

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  int _rating = 0;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _reviewController = TextEditingController();

  void _submitReview() {
    if (_nameController.text.isEmpty ||
        _rating == 0 ||
        _reviewController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Nama, rating, dan ulasan wajib diisi")),
      );
      return;
    }

    setState(() {
      reviewList.add(
        ReviewData(
          name: _nameController.text,
          rating: _rating,
          comment: _reviewController.text,
        ),
      );
      _nameController.clear();
      _reviewController.clear();
      _rating = 0;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Berhasil menambah review!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Posisi teks ke kiri samping tombol back
        centerTitle: false,
        leading: IconButton(
          // Panah back warna hitam
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "KRITIK & SARAN",
          style: TextStyle(
            // Teks judul warna hitam
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Nama Lengkap",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Masukkan nama anda",
              ),
            ),
            const SizedBox(height: 15),
            const Text(
              "Rating Produk",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Row(
              children: List.generate(5, (index) {
                return IconButton(
                  icon: Icon(
                    index < _rating ? Icons.star : Icons.star_border,
                    color: Colors.orange,
                    size: 35,
                  ),
                  onPressed: () => setState(() => _rating = index + 1),
                );
              }),
            ),
            const SizedBox(height: 15),
            const Text("Ulasan", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: _reviewController,
              maxLines: 3,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "Ceritakan pengalamanmu...",
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _submitReview,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                child: const Text("KIRIM REVIEW"),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ReviewPage()),
                  );
                },
                child: const Text("LIHAT SEMUA REVIEW"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
