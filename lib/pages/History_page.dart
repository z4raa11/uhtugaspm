    import 'package:flutter/material.dart';       
    import 'package:provider/provider.dart';      
    import '../services/ToDo_services.dart';      
    import '../widgets/ToDo_item.dart';           




    // Warna konstan untuk konsistensi tema aplikasi
    const kBlue = Color(0xFF577C8E);   // Warna biru (digunakan untuk teks, ikon, border)
    const kCream = Color(0xFFF2E7DD);  // Warna cream (digunakan untuk background AppBar)




    // Halaman History
    class HistoryPage extends StatelessWidget {
      const HistoryPage({super.key});

      @override
      Widget build(BuildContext context) {



        // Mengambil instance ToDoServices lewat Provider
        // -> supaya kita bisa akses data history & fungsi delete
        final service = Provider.of<ToDoServices>(context);

        return Scaffold(
          backgroundColor: kBlue, // Latar belakang halaman biru
          appBar: AppBar(
            backgroundColor: kCream, // AppBar warna cream
            elevation: 0,           
            leading: IconButton(








              // Tombol back (panah kiri) untuk kembali ke halaman sebelumnya
              icon: const Icon(Icons.arrow_back, color: kBlue),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              "History",              
              style: TextStyle(color: kBlue),
            ),
            actions: [





            
              // TOMBOL DELETE (hapus permanen history yang dicentang)
            
              OutlinedButton.icon(
                onPressed: service.deleteHistorySelected, // Panggil fungsi hapus di ToDoServices
                icon: const Icon(Icons.delete, color: kBlue, size: 18),
                label: const Text("Delete", style: TextStyle(color: kBlue)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: kBlue, width: 1.5), // Border biru
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),        // Bentuk tombol oval
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
              ),




              
              const SizedBox(width: 14), // Jarak antar tombol
              // TOMBOL HISTORY (hiasan, tidak dipakai)

              OutlinedButton.icon(
                onPressed: () {}, // Tidak ada aksi (kosong)
                icon: const Icon(Icons.history, color: kBlue, size: 18),
                label: const Text("History", style: TextStyle(color: kBlue)),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: kBlue, width: 1.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                ),
              ),
              const SizedBox(width: 60), // Jarak sisi kanan AppBar
            ],
          ),

    









          // ISI BODY HALAMAN

          body: SafeArea(
            // Supaya konten tidak ketutupan status bar / notch HP
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: service.history.isEmpty


                  // Jika history kosong, tampilkan teks
                  ? const Center(
                      child: Text(
                        "No history yet",
                        style: TextStyle(color: kCream),
                      ),
                    )










                  // Jika ada data di history -> tampilkan dalam ListView
                  : ListView.builder(
                      itemCount: service.history.length, // Jumlah item sesuai history
                      itemBuilder: (context, index) {
                        final t = service.history[index]; // Ambil 1 data berdasarkan index
                        return ToDoItem(
                          todo: t,          // Kirim data todo ke widget ToDoItem
                          isHistory: true,  // Flag agar widget tahu kalau ini tampil di history
                        );
                      },
                    ),
            ),
          ),
        );
      }
    }
