  import 'package:flutter/material.dart';
  import 'package:provider/provider.dart';
  import 'services/ToDo_services.dart';
  import 'pages/ToDo_page.dart';

  const kBlue = Color(0xFF577C8E);
  const kCream = Color(0xFFF2E7DD);

  void main() {
    runApp(
      ChangeNotifierProvider(
        create: (_) => ToDoServices(),
        child: const MyApp(),
      ),
    );
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        title: 'ToDo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(


          
          // Semua warna utama diatur di sini (hanya dua warna)
          scaffoldBackgroundColor: kBlue,
          appBarTheme: const AppBarTheme(
            backgroundColor: kCream,
            foregroundColor: kBlue,
            elevation: 0,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: kCream,
            foregroundColor: kBlue,
          ),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: kBlue,
            secondary: kCream,
          ),
        ),
        home: const ToDoPage(),
      );
    }
  }
