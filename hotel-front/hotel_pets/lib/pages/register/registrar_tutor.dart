import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hotel_pets/controller/tutor_controller.dart';

class RegistrarTutor extends StatefulWidget {
  const RegistrarTutor({super.key});

  @override
  State<RegistrarTutor> createState() => _RegistrarTutorState();
}

class _RegistrarTutorState extends State<RegistrarTutor> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TutorController controller = TutorController();

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
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(label: Text("Email: ")),
                validator: (value) {
                  if (value == null) {
                    return 'Insira um email de contato';
                  }
                  if (value.contains('@')) {
                    return 'O email deve ser válido';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    await controller.createTutor({
                      'nome': nomeController.text,
                      'email': emailController.text,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Tutor cadastrado!"),
                      backgroundColor: Colors.green,
                    ));
                    Navigator.of(context).pop();
                  } catch (error) {
                    print('======================== entrou na catch');
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error.toString())));
                  }
                },
                child: const Text("Registrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
