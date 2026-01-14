import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Keranjang/cart_page.dart';

/* ================================
   KONFIGURASI WARNA
================================ */
class AppColors {
  static const Color background = Color(0xFFF7F7F7);

  static const Color makananHeader = Color(0xFFFF8C00);
  static const Color sideDishHeader = Color.fromARGB(255, 28, 113, 123);

  static const Color harga = Color(0xFFFF8C00);
}

/* ================================
   MODEL MENU
================================ */
class MenuItem {
  final String nama;
  final int harga;
  final String imagePath;

  const MenuItem({
    required this.nama,
    required this.harga,
    required this.imagePath,
  });
}

/* ================================
   CART PROVIDER
================================ */
class CartProvider extends ChangeNotifier {
  final Map<MenuItem, int> _items = {};

  int quantity(MenuItem item) => _items[item] ?? 0;

  int get totalItem =>
      _items.values.fold(0, (sum, qty) => sum + qty);

  void add(MenuItem item) {
    _items[item] = (_items[item] ?? 0) + 1;
    notifyListeners();
  }

  void remove(MenuItem item) {
    if (!_items.containsKey(item)) return;

    if (_items[item]! > 1) {
      _items[item] = _items[item]! - 1;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }
}

/* ================================
   DATA MENU
================================ */
final makananMenu = [
  const MenuItem(
    nama: 'Mie Kuah Kacang',
    harga: 14000,
    imagePath: 'images/mie kuah kacang.png',
  ),
  const MenuItem(
    nama: 'Mie Tek',
    harga: 16000,
    imagePath: 'images/mie tek.png',
  ),
  const MenuItem(
    nama: 'Nasi',
    harga: 5000,
    imagePath: 'images/Nasi.png',
  ),
  const MenuItem(
    nama: 'Nasi Jeruk',
    harga: 8000,
    imagePath: 'images/nasi jeruk.png',
  ),
];

final sideDishMenu = [
  const MenuItem(
    nama: 'Cireng',
    harga: 5000,
    imagePath: 'images/cireng.png',
  ),
  const MenuItem(
    nama: 'Sosis',
    harga: 6000,
    imagePath: 'images/sosis.png',
  ),
  const MenuItem(
    nama: 'Tahu',
    harga: 5000,
    imagePath: 'images/tahu.png',
  ),
];

/* ================================
   APP ROOT
================================ */
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menu',
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const MenuPage(),
    );
  }
}

/* ================================
   HALAMAN MENU
================================ */
class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Color headerColor = AppColors.makananHeader;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    _tabController.addListener(() {
      setState(() {
        headerColor = switch (_tabController.index) {
          0 => AppColors.makananHeader,
          _ => AppColors.sideDishHeader,
        };
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalItem = context.watch<CartProvider>().totalItem;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: headerColor,
        title: const Text('Menu'),
        actions: [
  InkWell(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const CartPage()),
      );
    },
    child: Stack(
      alignment: Alignment.topRight,
      children: [
        const Padding(
          padding: EdgeInsets.all(12),
          child: Icon(Icons.shopping_cart, color: Colors.white),
        ),
        if (context.watch<CartProvider>().totalItem > 0)
          Positioned(
            right: 6,
            top: 6,
            child: CircleAvatar(
              radius: 8,
              backgroundColor: Colors.red,
              child: Text(
                context.watch<CartProvider>().totalItem.toString(),
                style: const TextStyle(
                  fontSize: 10,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
      ],
    ),
  ),
],


        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Makanan'),
            Tab(text: 'Side Dish'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MenuGrid(menuList: makananMenu),
          const Center(child: Text('Belum ada menu')),
          MenuGrid(menuList: sideDishMenu),
        ],
      ),
    );
  }
}

/* ================================
   GRID MENU
================================ */
class MenuGrid extends StatelessWidget {
  final List<MenuItem> menuList;

  const MenuGrid({super.key, required this.menuList});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        itemCount: menuList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (_, i) => MenuCard(item: menuList[i]),
      ),
    );
  }
}

/* ================================
   CARD MENU
================================ */
class MenuCard extends StatelessWidget {
  final MenuItem item;

  const MenuCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final jumlah = cart.quantity(item);

    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Image.asset(
                item.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
         Expanded(
  child: Padding(
    padding: const EdgeInsets.all(8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.nama,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          'Rp ${item.harga}',
          style: const TextStyle(
            color: AppColors.harga,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Spacer(),
         SizedBox(
  height: 40, // KUNCI TINGGI → mencegah overflow
  child: jumlah == 0
      ? SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () => cart.add(item),
            child: const Text('Tambah'),
          ),
        )
      : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.remove_circle_outline),
              onPressed: () => cart.remove(item),
            ),
            Text(
              jumlah.toString(),
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () => cart.add(item),
            ),
          ],
        ),
)

      ],
    ),
  ),
),

        ],
      ),
    );
  }
}
