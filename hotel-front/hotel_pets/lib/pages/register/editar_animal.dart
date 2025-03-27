import 'package:flutter/material.dart';
import '../../controller/animal_controller.dart';

class EditarAnimal extends StatefulWidget {
  final int id;
  final String nome;
  final String especie;
  final String raca;
  const EditarAnimal(
      {super.key,
      required this.id,
      required this.nome,
      required this.especie,
      required this.raca});

  @override
  State<EditarAnimal> createState() => _EditarAnimalState();
}

class _EditarAnimalState extends State<EditarAnimal> {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController especieController = TextEditingController();
  final TextEditingController racaController = TextEditingController();
  final AnimalController controller = AnimalController();

  @override
  void initState() {
    super.initState();
    nomeController.text = widget.nome;
    especieController.text = widget.especie;
    racaController.text = widget.raca;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop(true);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Adicionar Animal"),
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
                controller: especieController,
                decoration: const InputDecoration(label: Text("Espécie: ")),
              ),
              TextField(
                controller: racaController,
                decoration: const InputDecoration(label: Text("Raça: ")),
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    controller.updateAnimais(widget.id, {
                      'nome': nomeController.text,
                      'especie': especieController.text,
                      'raca': racaController.text,
                    });
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Dados Salvos!"),
                      backgroundColor: Colors.green,
                    ));
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
