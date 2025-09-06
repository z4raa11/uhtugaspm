    import 'package:flutter/material.dart';
    import 'package:provider/provider.dart';
    import '../services/ToDo_services.dart'; 
    import '../widgets/ToDo_item.dart';     
    import 'History_page.dart';              
    



    // Warna tema aplikasi (biar konsisten seluruh halaman)
    const kBlue = Color(0xFF577C8E);
    const kCream = Color(0xFFF2E7DD);




    // Link gambar profil (nanti ditampilkan di navbar kiri)
    const profileUrl =
        "https://media.istockphoto.com/id/2157073181/id/foto/wanita-tersenyum-dengan-tangan-di-wajah-di-kamar-mandi.jpg?s=612x612&w=0&k=20&c=f8ayYCSN9h_P3JClpLPF8_Db3UuJIA2DSeDPn11o7tQ=";






    // == HALAMAN TODO ==
    class ToDoPage extends StatefulWidget {
      const ToDoPage({super.key});

      @override
      State<ToDoPage> createState() => _ToDoPageState();
    }

    class _ToDoPageState extends State<ToDoPage> {


      // Controller untuk input text
      final _titleCtrl = TextEditingController(); // field judul
      final _descCtrl = TextEditingController();  // field deskripsi

      @override
      void dispose() {



        // Pastikan controller dibersihkan dari memori saat widget dihancurkan
        _titleCtrl.dispose();
        _descCtrl.dispose();
        super.dispose();
      }




      // Fungsi untuk menyesuaikan ukuran avatar (biar responsif di layar kecil/besar)
      double _avatarRadius(BuildContext c) {
        final w = MediaQuery.of(c).size.width; // ambil lebar layar
        return (w * 0.035).clamp(14.0, 22.0);  // scaling dengan batas min 14px max 22px
      }

      @override
      Widget build(BuildContext context) {


        // Ambil service dari Provider (tempat menyimpan & mengatur state ToDo)
        final service = Provider.of<ToDoServices>(context);

        return Scaffold(
          backgroundColor: kBlue, // warna latar belakang utama
          body: SingleChildScrollView( // biar bisa discroll ke bawah
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [








                // == NAVBAR ==
                Container(
                  width: double.infinity,
                  color: kCream, // warna background cream
                  padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 40),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [




                      // Foto Profil
                      CircleAvatar(
                        radius: _avatarRadius(context) * 1.5,
                        backgroundColor: kCream,
                        backgroundImage: const NetworkImage(profileUrl),
                      ),



                      

                      const SizedBox(width: 13),
                      // Nama + sapaan
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "Rachel Vennya",
                            style: TextStyle(
                              color: kBlue,
                              fontSize: 20,
                            ),
                          ),


                          SizedBox(height: 7),
                          Text(
                            "Hallo,",
                            style: TextStyle(color: kBlue, fontSize: 14),
                          ),
                        ],
                      ),








                      const Spacer(), // dorong tombol ke kanan
                      // Tombol Delete (hapus task yang dicentang)
                      OutlinedButton.icon(
                        onPressed: service.deleteSelected,
                        icon: const Icon(Icons.delete, color: kBlue),
                        label: const Text("Delete", style: TextStyle(color: kBlue)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: kBlue, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),








                      const SizedBox(width: 19),
                      // Tombol History (pindah ke halaman HistoryPage)
                      OutlinedButton.icon(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const HistoryPage()),
                        ),
                        icon: const Icon(Icons.history, color: kBlue),
                        label: const Text("History", style: TextStyle(color: kBlue)),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: kBlue, width: 1.5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),









                // == ISI HALAMAN ==
                Padding(
                  padding: const EdgeInsets.all(35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [




                      const SizedBox(height: 15),
                      // == FORM INPUT ==
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: kCream,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [





                            // Judul form
                            const Text(
                              "Add To Do List",
                              style: TextStyle(
                                color: kBlue,
                                fontSize: 16,
                              ),
                            ),




                            const SizedBox(height: 30),
                            // Input Title
                            _buildField(controller: _titleCtrl, hint: "Title"),


                            const SizedBox(height: 15),
                            // Input Description
                            _buildField(controller: _descCtrl, hint: "Description"),





                            const SizedBox(height: 52),
                            // Tombol Submit
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: () {
                                  // Kalau dua-duanya kosong -> return
                                  if (_titleCtrl.text.trim().isEmpty &&
                                      _descCtrl.text.trim().isEmpty) {
                                    return;
                                  }




                                  // Kalau title ada tapi deskripsi kosong -> munculkan alert
                                  if (_titleCtrl.text.trim().isNotEmpty &&
                                      _descCtrl.text.trim().isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content:
                                            Text("Deskripsi tidak boleh kosong!"),
                                        backgroundColor: Color.fromARGB(255, 231, 200, 197),
                                      ),
                                    );
                                    return;
                                  }




                                  // Tambahkan task baru
                                  service.addToDo(
                                    _titleCtrl.text,
                                    _descCtrl.text,
                                  );



                                  // Bersihkan field setelah submit
                                  _titleCtrl.clear();
                                  _descCtrl.clear();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: kBlue,
                                  foregroundColor: kCream,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: const Text(
                                  "Submit",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),









                      const SizedBox(height: 30),
                      // == LIST TASK ==
                      const Text(
                        "Your Tasks",
                        style: TextStyle(
                          color: kCream,
                          fontSize: 16,
                        ),
                      ),



                      const SizedBox(height: 10),
                      // Kalau kosong -> tampilkan teks "No tasks yet"
                      service.todos.isEmpty
                          ? const Padding(
                              padding: EdgeInsets.only(top: 60),
                              child: Center(
                                child: Text(
                                  "No tasks yet",
                                  style: TextStyle(color: kCream, fontSize: 14),
                                ),
                              ),
                            )







                          // Kalau ada isi -> tampilkan list ToDoItem
                          : ListView.separated(
                              shrinkWrap: true, // biar bisa nested di scroll
                              physics: const NeverScrollableScrollPhysics(), // nonaktifkan scroll internal
                              itemCount: service.todos.length,
                              separatorBuilder: (_, __) =>
                                  const SizedBox(height: 12),
                              itemBuilder: (context, index) {
                                final t = service.todos[index];
                                return ToDoItem(todo: t, isHistory: false);
                              },
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }














      // == FIELD INPUT BUILDER ==
      // Builder khusus untuk textfield agar konsisten
      Widget _buildField(
          {required TextEditingController controller, required String hint}) {
        return TextField(
          controller: controller,
          cursorColor: kBlue, // warna kursor
          style: const TextStyle(color: kBlue), // warna text
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: kBlue),
            filled: true,
            fillColor: kCream,
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kBlue),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: kBlue, width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    }
