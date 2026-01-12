import 'package:flutter/material.dart';

class ProsesPesananScreen extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const ProsesPesananScreen({
    super.key,
    required this.cartItems,
  });

  @override
  State<ProsesPesananScreen> createState() => _ProsesPesananScreenState();
}

class _ProsesPesananScreenState extends State<ProsesPesananScreen> {
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController catatanController = TextEditingController();

  String metodePembayaran = 'Tunai';

  int get totalHarga {
    int total = 0;
    for (var item in widget.cartItems) {
      total += (item['harga'] * item['jumlah']) as int;
    }
    return total;
  }

  void konfirmasiPesanan() {
    if (alamatController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Alamat pengantaran harus diisi')),
      );
      return;
    }

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Pesanan Berhasil'),
        content: const Text('Pesanan kamu sedang diproses'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Proses Pesanan'),
        backgroundColor: Color(0xFF577E89),
        foregroundColor: Colors.white
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// RINGKASAN PESANAN
            const Text(
              'Ringkasan Pesanan',
              style: TextStyle(fontSize: 18, 
              fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            Expanded(
              child: ListView.builder(
                itemCount: widget.cartItems.length,
                itemBuilder: (context, index) {
                  final item = widget.cartItems[index];
                  return Card(
                    child: ListTile(
                      title: Text(item['nama']),
                      subtitle: Text(
                        'Rp ${item['harga']} x ${item['jumlah']}',
                      ),
                      trailing: Text(
                        'Rp ${item['harga'] * item['jumlah']}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 10),

            /// ALAMAT
            TextField(
              controller: alamatController,
              decoration: const InputDecoration(
                labelText: 'Alamat Pengantaran',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            /// CATATAN (FITUR YANG DISAMAKAN)
            TextField(
              controller: catatanController,
              decoration: const InputDecoration(
                labelText: 'Catatan (opsional)',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 10),

            /// METODE PEMBAYARAN
            DropdownButtonFormField<String>(
              value: metodePembayaran,
              decoration: const InputDecoration(
                labelText: 'Metode Pembayaran',
                border: OutlineInputBorder(),
              ),
              items: const [
                DropdownMenuItem(value: 'Tunai', child: Text('Tunai')),
                DropdownMenuItem(value: 'Transfer', child: Text('Transfer')),
                DropdownMenuItem(value: 'E-Wallet', child: Text('E-Wallet')),
              ],
              onChanged: (value) {
                setState(() {
                  metodePembayaran = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            /// TOTAL & BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total: Rp $totalHarga',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                ElevatedButton(
                  onPressed: konfirmasiPesanan,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.black,
                    backgroundColor: Color(0xFFE1A36F)
                  ),
                  child: const Text('Pesan'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(const TestProsesPesananApp());
}

class TestProsesPesananApp extends StatelessWidget {
  const TestProsesPesananApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProsesPesananScreen(
        cartItems: [
          {
            'nama': 'Mi Ayam',
            'harga': 12000,
            'jumlah': 2,
          },
          {
            'nama': 'Es Teh',
            'harga': 5000,
            'jumlah': 1,
          },
        ],
      ),
    );
  }
}
