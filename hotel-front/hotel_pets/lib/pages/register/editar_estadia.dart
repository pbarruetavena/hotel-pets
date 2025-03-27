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
    saidaController.text = widget.saida;
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
                    controller.updateEstadia(widget.id, {
                      'entrada': entradaController.text,
                      'saida': saidaController.text,
                    });
                    Navigator.of(context).pop();
                  } catch (error) {
                    print(error);
                  }
                },
                child: const Text("Adicionar"),
              ),
            ],
          ),
        ));
  }
}
