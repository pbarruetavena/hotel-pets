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
    await controller.getEstadias();
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
      initialDate: entradaController.text.isEmpty
          ? DateTime.now()
          : DateTime.parse(entradaController.text),
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

  bool verificarEstadia() {
    DateTime entrada = DateTime.parse(entradaController.text);
    if (saidaController.text == null || saidaController.text == "") {
      for (final estadia in controller.estadias) {
        print('testnado');
        if (estadia['animalId'] == selectedAnimal) {
          if (estadia['saida'] == null) {
            return false;
          } else {
            DateTime s = DateTime.parse(estadia['saida']);
            if (s.isAfter(entrada)) {
              return false;
            }
          }
        }
      }
    } else {
      DateTime saida = DateTime.parse(saidaController.text);
      for (final estadia in controller.estadias) {
        if (estadia['animalId'] == selectedAnimal) {
          print('testando');
          DateTime e = DateTime.parse(estadia['entrada']);
          if (estadia['saida'] == null) {
            if (!e.isAfter(saida)) {
              return false;
            }
          } else {
            DateTime s = DateTime.parse(estadia['saida']);
            if (e.isBefore(saida) && !entrada.isAfter(s)) {
              print("T1");
              return false;
            }
            if (s.isAfter(entrada) && !saida.isBefore(e)) {
              print("T2");
              return false;
            }
          }
        }
      }
    }
    return true;
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
                    if (!verificarEstadia()) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "A estadia gera conflito no calendário! Verifique as estadias do animal selecionado"),
                          backgroundColor: Colors.yellow));
                      return;
                    }
                    print("a");
                    print(saidaController.text);
                    if (saidaController.text == null ||
                        saidaController.text == '') {
                      print("entrou na if de cima");
                      await controller.createEstadia({
                        'entrada': entradaController.text,
                        'animalId': selectedAnimal,
                      });
                    } else {
                      print("entrou no if de baixo");
                      await controller.createEstadia({
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
