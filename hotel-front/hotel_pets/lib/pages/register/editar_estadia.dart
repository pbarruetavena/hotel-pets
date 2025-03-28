import 'package:flutter/material.dart';
import 'package:hotel_pets/controller/animal_controller.dart';
import 'package:hotel_pets/controller/estadia_controller.dart';
import 'package:intl/intl.dart';

class EditarEstadia extends StatefulWidget {
  final int id;
  final String entrada;
  final String saida;
  const EditarEstadia(
      {super.key,
      required this.id,
      required this.entrada,
      required this.saida});

  @override
  State<EditarEstadia> createState() => _EditarEstadiaState();
}

class _EditarEstadiaState extends State<EditarEstadia> {
  final EstadiaController controller = EstadiaController();
  final AnimalController aController = AnimalController();
  final TextEditingController entradaController = TextEditingController();
  final TextEditingController saidaController = TextEditingController();
  final DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  @override
  void initState() {
    super.initState();
    entradaController.text = widget.entrada;
    if (widget.saida != "") saidaController.text = widget.saida;
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
        if (estadia['animalId'] == widget.id) {
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
        if (estadia['animalId'] == widget.id) {
          DateTime e = DateTime.parse(estadia['entrada']);
          if (estadia['saida'] == null) {
            if (!e.isAfter(saida)) {
              return false;
            }
          } else {
            DateTime s = DateTime.parse(estadia['saida']);
            if (e.isBefore(saida) && !entrada.isAfter(s)) {
              return false;
            }
            if (s.isAfter(entrada) && !saida.isBefore(e)) {
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
          title: const Text("Editar Estadia"),
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
                    print(saidaController.text);
                    if (saidaController.text == null ||
                        saidaController.text == "") {
                      print("entrou no de cima");
                      await controller.updateEstadia(widget.id, {
                        'entrada': entradaController.text,
                      });
                    } else {
                      print("entrou no de baixo");
                      await controller.updateEstadia(widget.id, {
                        'entrada': entradaController.text,
                        'saida': saidaController.text,
                      });
                    }

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Dados Salvos!"),
                      backgroundColor: Colors.green,
                    ));
                    Navigator.of(context).pop();
                  } catch (error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(error.toString())));
                  }
                },
                child: const Text("Salvar"),
              ),
            ],
          ),
        ));
  }
}
