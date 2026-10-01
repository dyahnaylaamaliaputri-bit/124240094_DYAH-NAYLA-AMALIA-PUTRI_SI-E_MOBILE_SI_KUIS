import 'package:flutter/material.dart';

import '../models/stationery_item.dart';
import 'detail_page.dart';

// saat user balik dari halaman detail
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<StationeryItem> _menuItems = StationeryItem.sampleData;

  // Getter: hitung total semua pesanan
  int get _grandTotal =>
      _menuItems.fold(0, (sum, item) => sum + item.totalPrice);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(53, 83, 255, 1),
        title: const Text(
          '🍽️ Menu Resto',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          // Banner total pesanan
          Container(
            width: double.infinity,
            color: const Color.fromRGBO(53, 83, 255, 1),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Text(
              'Total Pesanan: Rp ${formatPrice(_grandTotal)}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ),

          // ListView.builder: tampilkan daftar makanan
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _menuItems.length,
              itemBuilder: (context, index) {
                final item = _menuItems[index];
                return _buildFoodCard(item, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodCard(StationeryItem item, int index) {
    return GestureDetector(
      // Navigasi ke DetailPage saat kartu diklik
      onTap: () async {
        // await: tunggu sampai user selesai di halaman detail
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(item: item, index: index),
          ),
        );

        if (result != null && result is int) {
          setState(() {
            _menuItems[index].stock = result;
          });
        }
      },

      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.07),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // ── Gambar makanan
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Image.network(
                item.imageUrl,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 100,
                  height: 100,
                  color: Colors.grey[200],
                  child: const Icon(Icons.fastfood, color: Colors.grey),
                ),
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Nama makanan
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 3),

                    // Deskripsi
                    Text(
                      item.description,
                      style: TextStyle(color: Colors.grey[500], fontSize: 11),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),

                    // Jumlah porsi yang dipilih user
                    // Otomatis berubah saat balik dari detail
                    Text(
                      '${item.stock} pcs tersedia',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 6),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children:[
                        Text(
                           'Rp ${item.formattedPrice}/pcs',
                            style: const TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
