import 'package:flutter/material.dart';

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
      home: const FoodAppWeb(),
    );
  }
}

class FoodAppWeb extends StatelessWidget {
  const FoodAppWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text('Resto yang ada Minuman', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 500), // Agar tampilan tetap seperti mobile di Web
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Filter Chips
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _buildFilterChip(Icons.tune, ""),
                    _buildFilterChip(null, "Baru", isNew: true),
                    _buildFilterChip(null, "Diantar 15 min"),
                    _buildFilterChip(null, "Terdekat"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              
              // Resto List
              _buildRestoSection(
                "Neir Coffee, M.T. Haryono",
                "4.9",
                "Diskon 49%, maks. 105rb",
                [
                  _buildFoodItem("Coffee Neir", "31.400", "33.000"),
                  _buildFoodItem("Americano", "26.650", "28.050"),
                  _buildFoodItem("Coffee Neir Brown Sugar", "31.400", "33.000"),
                ],
              ),
              const SizedBox(height: 30),
              _buildRestoSection(
                "Jus Dan Sop Buah, Pekapuran Raya",
                "4.6",
                "Diskon 50%, maks. 66rb",
                [
                  _buildFoodItem("Alpukat Susu", "22.500", "25.000"),
                  _buildFoodItem("Alpukat Kocok", "20.300", "22.500"),
                  _buildFoodItem("Teh Es Cup Jumbo", "5.400", "6.000"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk Chip Filter di bagian atas
  Widget _buildFilterChip(IconData? icon, String label, {bool isNew = false}) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          if (icon != null) Icon(icon, size: 18),
          if (isNew) ...[
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(10)),
              child: const Text("Baru", style: TextStyle(color: Colors.white, fontSize: 10)),
            ),
            const SizedBox(width: 4),
          ],
          if (label.isNotEmpty) Text(label, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }

  // Widget untuk Satu Baris Restoran
  Widget _buildRestoSection(String title, String rating, String promo, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(width: 50, height: 50, decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(8))),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Row(
                    children: [
                      const Icon(Icons.star, color: Colors.orange, size: 16),
                      Text(" $rating (100+) • \$\$\$\$"),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(height: 10),
        // Tag Promo
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(border: Border.all(color: Colors.red.shade100), borderRadius: BorderRadius.circular(4)),
          child: Text(promo, style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
        ),
        const SizedBox(height: 12),
        // Item Menu Horizontal
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: items),
        ),
      ],
    );
  }

  // Widget untuk Kotak Makanan
  Widget _buildFoodItem(String name, String price, String oldPrice) {
    return Container(
      width: 130,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 130,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          const SizedBox(height: 8),
          Text(name, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(fontSize: 13)),
          Text(oldPrice, style: const TextStyle(decoration: TextDecoration.lineThrough, color: Colors.grey, fontSize: 11)),
          Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}