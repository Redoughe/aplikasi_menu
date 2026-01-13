import 'package:flutter/material.dart';
import 'krisar.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Posisi teks ke kiri samping tombol back
        centerTitle: false,
        leading: IconButton(
          // Panah back warna hitam
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Daftar Review Pelanggan",
          style: TextStyle(
            // Teks judul warna hitam
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: reviewList.isEmpty
          ? const Center(child: Text("Belum ada review yang masuk."))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: reviewList.length,
              itemBuilder: (context, index) {
                final review = reviewList[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.only(bottom: 15),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              review.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Row(
                              children: List.generate(5, (i) {
                                return Icon(
                                  i < review.rating
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: Colors.orange,
                                  size: 18,
                                );
                              }),
                            ),
                          ],
                        ),
                        const Divider(),
                        Text(review.comment),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
