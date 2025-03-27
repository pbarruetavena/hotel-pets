import 'package:flutter/material.dart';
import '../../controller/estadia_controller.dart';
import '../../controller/animal_controller.dart';
import 'package:intl/intl.dart';

class RegistrarEstadia extends StatefulWidget {
  const RegistrarEstadia({super.key});

  @override
  State<RegistrarEstadia> createState() => _RegistrarEstadiaState();
}

class _RegistrarEstadiaState extends State<RegistrarEstadia> {
  final EstadiaController controller = EstadiaController();
  final AnimalController aController = AnimalController();
  final TextEditingController entradaController = TextEditingController();
  final TextEditingController saidaController = TextEditingController();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');
  int? selectedAnimal;

  @override
  void initState() {
    super.initState();
    carregarAnimais();
  }

  void carregarAnimais() async {
    await aController.getAnimais();
    setState(() {});
  }

  Future<void> selecionarEntrada(BuildContext context) async {
    DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now().add(const Duration(days: 30)),
      locale: const Locale("pt", "BR"),
    );

    if (dataSelecionada != null) {
      setState(() {
        entradaController.text = dateFormat.format(dataSelecionada);
      });
    }
  }

  Future<void> selecionarSaida(BuildContext context) async {
    DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: entradaController.text.isEmpty
          ? DateTime.now()
          : DateTime.parse(entradaController.text),
      lastDate: DateTime(2100),
      locale: const Locale("pt", "BR"),
    );

    if (dataSelecionada != null) {
      setState(() {
        saidaController.text = dateFormat.format(dataSelecionada);
      });
    }
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
          title: const Text("Adicionar Estadia"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              TextField(
                controller: entradaController,
                decoration: const InputDecoration(
                  labelText: "Entrada",
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () {
                  selecionarEntrada(context);
                },
              ),
              TextField(
                controller: saidaController,
                decoration: const InputDecoration(
                  labelText: "Saída",
                  suffixIcon: Icon(Icons.calendar_today),
                ),
                readOnly: true,
                onTap: () {
                  selecionarSaida(context);
                },
              ),
              DropdownButtonFormField<int>(
                items: aController.animais.map((animal) {
                  return DropdownMenuItem<int>(
                    value: animal['id'],
                    child: Text(animal['nome']),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedAnimal = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    if (saidaController.text == null ||
                        saidaController.text == '') {
                      controller.createEstadia({
                        'entrada': entradaController.text,
                        'animalId': selectedAnimal,
                      });
                    } else {
                      controller.createEstadia({
                        'entrada': entradaController.text,
                        'saida': saidaController.text,
                        'animalId': selectedAnimal,
                      });
                    }

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Estadia cadastrado!"),
                        backgroundColor: Colors.green));
                    Navigator.of(context).pop();
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text("Erro ao cadastrar. ${error.toString()}")));
                  }
                },
                child: const Text("Adicionar"),
              ),
            ],
          ),
        ));
  }
}
