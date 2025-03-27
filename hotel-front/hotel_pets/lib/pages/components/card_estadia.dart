import 'package:flutter/material.dart';

class CardEstadia extends StatefulWidget {
  final String nomeAnimal;
  final String especieAnimal;
  final String racaAnimal;
  final String nomeTutor;
  final String emailTutor;
  final String entrada;
  final String saida;
  final String status;
  final int? diariasParciais;
  final int? diariasTotais;
  const CardEstadia(
      {super.key,
      required this.nomeAnimal,
      required this.especieAnimal,
      required this.racaAnimal,
      required this.nomeTutor,
      required this.emailTutor,
      required this.entrada,
      required this.saida,
      required this.status,
      this.diariasParciais,
      this.diariasTotais});

  @override
  State<CardEstadia> createState() => _CardEstadiaState();
}

class _CardEstadiaState extends State<CardEstadia> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.pets, size: 18),
                  const SizedBox(width: 4),
                  Text(
                    widget.nomeAnimal,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(widget.nomeTutor),
                  const SizedBox(width: 4),
                  const Icon(Icons.person, size: 18),
                ],
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            "${widget.especieAnimal} • ${widget.racaAnimal}",
            style: const TextStyle(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 4),
          Text(widget.emailTutor),
          const SizedBox(height: 8),
          Text("Entrada: ${widget.entrada}",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          Text("Saída: ${widget.saida}",
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(widget.diariasParciais != 0
              ? "Diárias parciais: ${widget.diariasParciais}"
              : "Ainda não há diárias parciais"),
          Text(widget.diariasTotais != 0
              ? "Diárias totais: ${widget.diariasTotais}"
              : "Não há previsão de diárias totais"),
          Center(
            child: Text(
              widget.status == "ativa" ? "Estadia ativa" : "Estadia agendada",
              style: const TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
        ],
      ),
    );
  }
}
