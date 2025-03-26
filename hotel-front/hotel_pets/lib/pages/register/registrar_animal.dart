import 'package:flutter/material.dart';
import '../../controller/animal_controller.dart';
import '../../controller/tutor_controller.dart';

class RegistrarAnimal extends StatefulWidget {
  const RegistrarAnimal({super.key});

  @override
  State<RegistrarAnimal> createState() => _RegistrarAnimalState();
}

class _RegistrarAnimalState extends State<RegistrarAnimal> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController especieController = TextEditingController();
  final TextEditingController racaController = TextEditingController();
  int? selectedTutor;

  final TutorController tController = TutorController();
  final AnimalController controller = AnimalController();

  @override
  void initState() {
    super.initState();
    carregarTutores();
  }

  void carregarTutores() async {
    await tController.getTutores();
    setState(() {});
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
        title: const Text("Adicionar Animal"),
      ),
      body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: nomeController,
                decoration: const InputDecoration(label: Text("Nome")),
              ),
              TextField(
                controller: especieController,
                decoration: const InputDecoration(label: Text("Espécie")),
              ),
              TextField(
                controller: racaController,
                decoration: const InputDecoration(label: Text("Raça")),
              ),
              DropdownButtonFormField<int>(
                items: tController.tutores.map((tutor) {
                  return DropdownMenuItem<int>(
                    value: tutor['id'],
                    child: Text("${tutor['nome']} *  ${tutor['email']}"),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedTutor = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    controller.createAnimal({
                      'nome': nomeController.text,
                      'especie': especieController.text,
                      'raca': racaController.text,
                      'tutorId': selectedTutor,
                    });

                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Animal cadastrado!")));
                    Navigator.of(context).pop();
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Erro ao cadastrar.")));
                  }
                },
                child: const Text("Adicionar"),
              ),
            ],
          )),
    );
  }
}
