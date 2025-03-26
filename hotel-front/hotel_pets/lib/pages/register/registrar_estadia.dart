import 'package:flutter/material.dart';
import '../../controller/estadia_controller.dart';
import '../../controller/animal_controller.dart';

class RegistrarEstadia extends StatefulWidget {
  const RegistrarEstadia({super.key});

  @override
  State<RegistrarEstadia> createState() => _RegistrarEstadiaState();
}

class _RegistrarEstadiaState extends State<RegistrarEstadia> {
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
              // TextField(
              // readOnly: true,
              // decoration: InputDecoration(
              //   labelText: "Entrada",
              //   suffixIcon: IconButton(
              //     icon: const Icon(Icons.calendar_today),
              //     onPressed: () => {},
              //   ),
            ],
          ),
        ));
  }
}
