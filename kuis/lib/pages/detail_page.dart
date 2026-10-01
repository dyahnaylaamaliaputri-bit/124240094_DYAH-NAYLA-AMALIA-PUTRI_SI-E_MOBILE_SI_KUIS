import 'package:flutter/material.dart';

import '../models/stationery_item.dart';

// saat user tekan tombol + dan -
class DetailPage extends StatefulWidget {
  final StationeryItem item; // data alat tulis yang diklik dari beranda
  final int index; // index alat tulis di list

  const DetailPage({super.key, required this.item, required this.index});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late int _stock;
  late TextEditingController _controller2 = TextEditingController();
  late TextEditingController _controller3 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _stock = widget.item.stock;
  }

  int get _totalPrice => _stock * widget.item.price;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF7F4),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(53, 83, 255, 1),
        title: Text(
          widget.item.name,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context, _stock),
        ),
        centerTitle: true,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar makanan
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  widget.item.imageUrl,
                  width: double.infinity,
                  height: 170,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: double.infinity,
                    height: 170,
                    color: Colors.grey[200],
                    child: const Icon(
                      Icons.fastfood,
                      size: 80,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(14, 12, 14, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card detail makanan
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.06),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.item.name,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 3),

                        Text(
                          'Rp ${widget.item.formattedPrice} / pcs',
                          style: const TextStyle(
                            fontSize: 11,
                            color: Color(0xFF5FA86B),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Deskripsi
                        Text(
                          widget.item.description,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[600],
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Container(
                          width: double.infinity,
                          height: 34,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: const Color(0xFF9A7445),
                              width: 1.2,
                            ),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.format_list_numbered,
                                size: 17,
                                color: Colors.grey,
                              ),

                              const SizedBox(width: 7),

                              const Text(
                                'Stock Tersedia (pcs)',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                              ),

                              const Spacer(),

                              // Tombol kurang (-)
                              GestureDetector(
                                onTap: _stock > 0
                                    ? () {
                                        setState(() {
                                          _stock--;
                                        });
                                      }
                                    : null,
                                child: const Icon(
                                  Icons.remove,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ),

                              const SizedBox(width: 12),

                              Text(
                                '$_stock',
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(width: 12),

                              // Tombol tambah (+)
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _stock++;
                                  });
                                },
                                child: const Icon(
                                  Icons.add,
                                  size: 16,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),
                        const Text(
                          'Harga: ',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),

                        const SizedBox(height: 8),
                        TextField(
                          controller: _controller2,
                          keyboardType: TextInputType
                              .number, // Memunculkan keyboard angka di HP
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Deskripsi',
                          ),
                          onChanged: (value) {
                            setState(() {
                              // a. Terjemahkan teks ketikan ke angka bulat (kalau kosong/salah, jadikan 0)
                              int parsedValue = int.tryParse(value) ?? 0;
                              // b. Masukkan angka hasil terjemahan tadi ke dalam data jumlah porsi makanan
                            });
                          },
                        ),

                        const SizedBox(height: 8),
                        TextField(
                          controller: _controller3,
                          keyboardType: TextInputType
                              .number, // Memunculkan keyboard angka di HP
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Masukkan jumlah harga',
                          ),
                          onChanged: (value) {
                            setState(() {
                              // a. Terjemahkan teks ketikan ke angka bulat (kalau kosong/salah, jadikan 0)
                              int parsedValue = int.tryParse(value) ?? 0;
                              // b. Masukkan angka hasil terjemahan tadi ke dalam data jumlah porsi makanan
                            });
                          },
                        ),

                        const SizedBox(height: 8),

                        // Total harga
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.grey,
                              ),
                            ),

                            Text(
                              _stock > 0
                                  ? 'Rp ${formatPrice(_totalPrice)}'
                                  : 'Rp 0',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: _stock > 0
                                    ? const Color(0xFF5FA86B)
                                    : Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 14),

                  SizedBox(
                    width: double.infinity,
                    height: 34,
                    child: ElevatedButton.icon(
                      // ke HomePage
                      onPressed: () => Navigator.pop(context, _stock),
                      label: const Text(
                        'Simpan',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(53, 83, 255, 1),
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
