import 'package:flutter/material.dart';

class RegistrarTutor extends StatefulWidget {
  const RegistrarTutor({super.key});

  @override
  State<RegistrarTutor> createState() => _RegistrarTutorState();
}

class _RegistrarTutorState extends State<RegistrarTutor> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Adicionar Tutor"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(label: Text("Nome: ")),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(label: Text("Email: ")),
              ),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Registrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
