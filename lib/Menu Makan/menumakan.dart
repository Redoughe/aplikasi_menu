import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

/* ================================
   KONFIGURASI WARNA
================================ */
class AppColors {
  static const Color background = Color(0xFFF7F7F7);

  static const Color makananHeader = Color(0xFFFF8C00);
  static const Color minumanHeader = Color.fromARGB(255, 68, 144, 137);
  static const Color sideDishHeader = Color.fromARGB(255, 28, 113, 123);

  static const Color tabActive = Colors.white;
  static const Color tabInactive = Colors.white70;

  static const Color card = Colors.white;
  static const Color harga = Color(0xFFFF8C00);
  static const Color buttonBorder = Color(0xFFFF8C00);
  static const Color counterIcon = Color(0xFFFF8C00);
}

/* ================================
   MODEL MENU
================================ */
class MenuItem {
  final String nama;
  final int harga;
  final String imagePath;

  MenuItem({
    required this.nama,
    required this.harga,
    required this.imagePath,
  });
}

/* ================================
   DATA MENU (EDIT DI SINI)
================================ */
final List<MenuItem> makananMenu = [
  MenuItem(
    nama: 'Mie Kuah Daging',
    harga: 15000,
    imagePath: 'assets/images/mie_kuah_daging.jpg',
  ),
  MenuItem(
    nama: 'Mie Kuah Kacang',
    harga: 14000,
    imagePath: 'assets/images/mie_kuah_kacang.jpeg',
  ),
  MenuItem(
    nama: 'Mie Tek',
    harga: 16000,
    imagePath: 'assets/images/mie_tek.webp',
  ),
  MenuItem(
    nama: 'Mie Topping Seafood',
    harga: 18000,
    imagePath: 'assets/images/mie_topping_seafood.jpg',
  ),
  MenuItem(
    nama: 'Nasi',
    harga: 6000,
    imagePath: 'assets/images/nasi.jpg',
  ),
  MenuItem(
    nama: 'Nasi Jeruk',
    harga: 7000,
    imagePath: 'assets/images/nasi_jeruk.jpg',
  ),
];

final List<MenuItem> sideDishMenu = [
  MenuItem(
    nama: 'Cireng',
    harga: 5000,
    imagePath: 'assets/images/cireng.jpg',
  ),
  MenuItem(
    nama: 'Sosis',
    harga: 6000,
    imagePath: 'assets/images/sosis.jpg',
  ),
  MenuItem(
    nama: 'Tahu',
    harga: 5000,
    imagePath: 'assets/images/tahu.jpg',
  ),
];

final List<MenuItem> minumanMenu = []; // KOSONG

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
        if (_tabController.index == 0) {
          headerColor = AppColors.makananHeader;
        } else if (_tabController.index == 1) {
          headerColor = AppColors.minumanHeader;
        } else {
          headerColor = AppColors.sideDishHeader;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: headerColor,
        title: const Text('Menu'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.tabActive,
          labelColor: AppColors.tabActive,
          unselectedLabelColor: AppColors.tabInactive,
          tabs: const [
            Tab(text: 'Makanan'),
            Tab(text: 'Minuman'),
            Tab(text: 'Side Dish'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          MenuGrid(menuList: makananMenu),
          MenuGrid(menuList: minumanMenu),
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
    if (menuList.isEmpty) {
      return const Center(
        child: Text(
          'Belum ada menu',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(12),
      child: GridView.builder(
        itemCount: menuList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.75,
        ),
        itemBuilder: (context, index) {
          return MenuCard(item: menuList[index]);
        },
      ),
    );
  }
}

/* ================================
   CARD MENU
================================ */
class MenuCard extends StatefulWidget {
  final MenuItem item;

  const MenuCard({super.key, required this.item});

  @override
  State<MenuCard> createState() => _MenuCardState();
}

class _MenuCardState extends State<MenuCard> {
  int jumlah = 0;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                widget.item.imagePath,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Center(
                  child: Text(
                    'Gambar tidak ditemukan',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.item.nama,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Rp ${widget.item.harga}',
              style: const TextStyle(
                color: AppColors.harga,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            jumlah == 0
                ? SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side:
                            const BorderSide(color: AppColors.buttonBorder),
                      ),
                      onPressed: () => setState(() => jumlah = 1),
                      child: const Text('Tambah'),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.remove_circle_outline,
                          color: AppColors.counterIcon,
                        ),
                        onPressed: () =>
                            setState(() => jumlah = jumlah > 0 ? jumlah - 1 : 0),
                      ),
                      Text(
                        jumlah.toString(),
                        style:
                            const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: AppColors.counterIcon,
                        ),
                        onPressed: () => setState(() => jumlah++),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
