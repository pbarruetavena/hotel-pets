import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/tutor_page.dart';
import 'pages/animal_page.dart';
import 'pages/historico.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hotel pets',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 15, 13, 151)),
        useMaterial3: true,
      ),
      home: const Root(),
    );
  }
}

class Root extends StatefulWidget {
  const Root({super.key});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int currentPage = 0;

  List<Widget> paginas = const [
    HomePage(),
    TutorPage(),
    AnimalPage(),
    Historico(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hotel"),
      ),
      body: paginas[currentPage],
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            ListTile(
              title: const Text('Home'),
              onTap: () => {
                setState(() {
                  currentPage = 0;
                  Navigator.pop(context);
                })
              },
            ),
            ListTile(
              title: const Text('Animais'),
              onTap: () => {
                setState(() {
                  currentPage = 2;
                  Navigator.pop(context);
                })
              },
            ),
            ListTile(
              title: const Text('Tutores'),
              onTap: () => {
                setState(() {
                  currentPage = 1;
                  Navigator.pop(context);
                })
              },
            ),
            ListTile(
              title: const Text("Histórico"),
              onTap: () => {
                setState(() {
                  currentPage = 3;
                  Navigator.pop(context);
                })
              },
            ),
          ],
        ),
      ),
    );
  }
}
