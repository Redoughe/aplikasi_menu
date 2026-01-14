import 'package:flutter/material.dart';
import 'product.dart';
import 'qris_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  final List<Product> cartItems = [
    Product(name: "Nasi Jeruk", price: 8000, quantity: 0),
    Product(name: "Mie tek", price: 16000, quantity: 0),
    Product(name: "Cireng", price: 5000, quantity: 0),
  ];

  int getTotal() {
    return cartItems.fold(
      0,
      (sum, item) => sum + (item.price * item.quantity),
    );
  }

  void tambahQty(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
  }

  void kurangQty(int index) {
    setState(() {
      if (cartItems[index].quantity > 0) {
        cartItems[index].quantity--;
      }

      if (cartItems[index].quantity == 0) {
        cartItems.removeAt(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton( // 🔹 TOMBOL BACK
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Keranjang",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFF3AB26),
      ),

      body: cartItems.isEmpty
          ? const Center(
              child: Text(
                "Keranjang kosong",
                style: TextStyle(fontSize: 18),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.only(bottom: 100),
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10, vertical: 6),
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(Icons.shopping_bag),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.name,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "Rp ${item.price}",
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon:
                                  const Icon(Icons.remove_circle_outline),
                              onPressed: () => kurangQty(index),
                            ),
                            Text(
                              item.quantity.toString(),
                              style: const TextStyle(fontSize: 16),
                            ),
                            IconButton(
                              icon: const Icon(Icons.add_circle_outline),
                              onPressed: () => tambahQty(index),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text("Total"),
                Text(
                  "Rp ${getTotal()}",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFFF3AB26),
                padding: const EdgeInsets.symmetric(
                    horizontal: 30, vertical: 12),
              ),
              onPressed: getTotal() == 0
                  ? null
                  : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) =>
                              QrisPage(total: getTotal()),
                        ),
                      );
                    },
              child: const Text(
                "Checkout",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}