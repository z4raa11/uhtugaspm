# uhtugaspm
Deskripsi Aplikasi
Aplikasi ToDo App ini adalah aplikasi sederhana untuk mencatat aktivitas harian.
Fitur utama:
Menambahkan tugas baru.
Menandai tugas selesai/belum selesai.
Menghapus tugas.
Menampilkan riwayat tugas yang sudah selesai.

Struktur project menggunakan pendekatan modular:
models/ → berisi struktur data (contoh: ToDo.dart).
pages/ → berisi halaman utama (ToDo_page.dart) dan halaman riwayat (History_page.dart).
services/ → berisi logika/state management (ToDo_services.dart).
widgets/ → berisi komponen UI yang dapat digunakan kembali (ToDo_item.dart).
main.dart → entry point aplikasi.

Diagram Widget Tree
MaterialApp
 └── Halaman Utama (ToDoPage)
      ├── AppBar (judul aplikasi)
      ├── Kolom (menyusun elemen secara vertikal)
      │    ├── TextField (tempat menulis tugas baru)
      │    ├── Tombol (untuk menambahkan tugas)
      │    └── Expanded
      │         └── ListView (daftar tugas)
      │              └── ToDoItem (kotak tugas individual)
 └── Halaman Riwayat (HistoryPage)
      ├── AppBar (judul halaman riwayat)
      └── ListView (daftar tugas yang sudah selesai)

      Pendekatan State Management

Aplikasi ini menggunakan Provider (ChangeNotifier) melalui file ToDo_services.dart.
Alasan pemilihan:
Sederhana & reaktif → cocok untuk aplikasi kecil–menengah.
Separation of concern → logic aplikasi (services) terpisah dari UI (widgets/pages).
Mudah di-scale → ketika aplikasi berkembang, bisa tetap menggunakan Provider atau migrasi ke state management lain (misalnya Riverpod/Bloc).


# DEMO #

<img width="1548" height="833" alt="Cuplikan layar 2025-09-06 100257" src="https://github.com/user-attachments/assets/d6ec0cf1-804c-40b0-95de-b8772b75a860" />

<img width="1562" height="831" alt="Cuplikan layar 2025-09-06 100539" src="https://github.com/user-attachments/assets/10ce56af-b767-4851-9a5c-2b24976390cd" />

