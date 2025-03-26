import 'package:flutter/material.dart';
import 'package:hotel_pets/controller/tutor_controller.dart';

class EditarTutor extends StatefulWidget {
  final int id;
  final String nome;
  final String email;
  const EditarTutor(
      {super.key, required this.id, required this.nome, required this.email});

  @override
  State<EditarTutor> createState() => _EditarTutorState();
}

class _EditarTutorState extends State<EditarTutor> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TutorController controller = TutorController();

  @override
  void initState() {
    super.initState();
    nomeController.text = widget.nome;
    emailController.text = widget.email;
  }

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
                onPressed: () async {
                  try {
                    controller.updateTutor(widget.id, {
                      'nome': nomeController.text,
                      'email': emailController.text,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Dados Salvos!")));
                    Navigator.of(context).pop(true);
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Erro ao salvar.")));
                  }
                },
                child: const Text("Salvar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
