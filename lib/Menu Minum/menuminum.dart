import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

// ================== APP UTAMA ==================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuMinumanPage(),
    );
  }
}

// ================== HALAMAN MENU ==================
class MenuMinumanPage extends StatelessWidget {
  const MenuMinumanPage({super.key});

  final List<Map<String, String>> menuMinuman = const [
    {
      'nama': 'Es Jeruk',
      'harga': 'Rp 35.000',
      'deskripsi': 'Minuman segar yang dibuat dari perasan jeruk pilihan dengan rasa asam manis alami, sangat cocok dinikmati saat cuaca panas untuk menghilangkan dahaga dan menyegarkan tubuh.',
      'gambar': 'images/esjeruk.png',
    },
    {
      'nama': 'Es Teh',
      'harga': 'Rp 25.000',
      'deskripsi': 'Minuman teh dingin dengan rasa manis yang pas dan aroma teh yang khas, menjadi minuman favorit yang cocok dinikmati kapan saja dan oleh semua kalangan.',
      'gambar': 'images/esteh.png',
    },
    {
      'nama': 'Es Buah',
      'harga': 'Rp 35.000',
      'deskripsi': 'Minuman segar berisi potongan berbagai buah pilihan yang dipadukan dengan sirup dan es batu, memberikan sensasi segar, manis, dan menyehatkan.',
      'gambar': 'images/esbuah.png',
    },
    {
      'nama': 'Es Cendol',
      'harga': 'Rp 45.000',
      'deskripsi': 'Minuman tradisional khas Indonesia yang terbuat dari cendol, santan, dan gula merah, memiliki cita rasa manis dan gurih yang menyegarkan.',
      'gambar': 'images/escendol.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Minuman'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: Container(
        color: const Color(0xFFFFF8E1),
        child: GridView.builder(
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 0.75,
          ),
          itemCount: menuMinuman.length,
          itemBuilder: (context, index) {
            final item = menuMinuman[index];

            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DetailMinumanPage(
                      nama: item['nama']!,
                      harga: item['harga']!,
                      deskripsi: item['deskripsi']!,
                      gambar: item['gambar']!,
                    ),
                  ),
                );
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16),
                            ),
                            child: Image.asset(
                              item['gambar']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item['nama']!,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item['harga']!,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    // ================== TOMBOL + (HIASAN SAJA) ==================
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: () {
                            // sengaja kosong
                          },
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Icon(
                              Icons.add,
                              size: 18,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ================== HALAMAN DETAIL ==================
class DetailMinumanPage extends StatelessWidget {
  final String nama;
  final String harga;
  final String deskripsi;
  final String gambar;

  const DetailMinumanPage({
    super.key,
    required this.nama,
    required this.harga,
    required this.deskripsi,
    required this.gambar,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Minuman'),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            gambar,
            width: double.infinity,
            height: 250,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  nama,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  harga,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  deskripsi,
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
