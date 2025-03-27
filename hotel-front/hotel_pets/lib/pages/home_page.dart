import 'package:flutter/material.dart';
import 'package:hotel_pets/controller/animal_controller.dart';
import 'package:hotel_pets/controller/estadia_controller.dart';
import 'package:hotel_pets/controller/tutor_controller.dart';
import 'package:hotel_pets/pages/components/card_estadia.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AnimalController animalController = AnimalController();
  TutorController tutorController = TutorController();
  EstadiaController estadiaController = EstadiaController();

  List<Map<String, dynamic>> estadias = [];

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    await animalController.getAnimais();
    await tutorController.getTutores();
    await estadiaController.getEstadias();
    filtrarEstadias();
    setState(() {});
  }

  void filtrarEstadias() {
    print('xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    for (Map<String, dynamic> estadia in estadiaController.estadias) {
      print("-------------------");
      DateTime saida = DateTime.parse(
          estadia['saida'] != null ? estadia['saida'] : "1900-00-00");
      DateTime entrada = DateTime.parse(estadia['entrada']);
      DateTime hoje = DateTime.now();
      print(entrada);
      print(hoje);
      print(entrada.isAfter(hoje));
      print(saida);
      if (!saida.isBefore(hoje) ||
          estadia['saida'] == null ||
          entrada.isAfter(hoje)) {
        print("é antes");
        estadias.add(estadia);
      }
    }
    print(estadias.length);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text("Estadias Ativas"),
          Expanded(
            child: ListView.builder(
              itemCount: estadias.length,
              itemBuilder: (context, index) {
                final estadia = estadias[index];
                int dParcial = 0;
                int dTotal = 0;
                String status = "";
                if (DateTime.parse(estadia['entrada'])
                    .isAfter(DateTime.now())) {
                  status = 'pendente';
                  if (estadia['saida'] != null) {
                    dTotal = DateTime.parse(estadia['saida'])
                        .difference(DateTime.parse(estadia['entrada']))
                        .inDays;
                  }
                } else {
                  status = 'ativa';
                  dParcial = dTotal = DateTime.now()
                      .difference(DateTime.parse(estadia['entrada']))
                      .inDays;
                  if (estadia['saida'] != null) {
                    dTotal = DateTime.parse(estadia['saida'])
                        .difference(DateTime.parse(estadia['entrada']))
                        .inDays;
                  }
                }

                Map<String, dynamic> animal =
                    animalController.animais.firstWhere(
                  (element) => element['id'] == estadia['animalId'],
                  orElse: () => Map(),
                );

                Map<String, dynamic> tutor = tutorController.tutores.firstWhere(
                  (element) => element['id'] == animal['tutorId'],
                  orElse: () => Map(),
                );

                return CardEstadia(
                  nomeAnimal: animal['nome'],
                  especieAnimal: animal['especie'],
                  racaAnimal: animal['raca'],
                  nomeTutor: tutor['nome'],
                  emailTutor: tutor['email'],
                  entrada: DateFormat('dd/MM/yyyy')
                      .format(DateTime.parse(estadia['entrada'])),
                  saida: estadia['saida'] != null
                      ? DateFormat('dd/MM/yyyy')
                          .format(DateTime.parse(estadia['saida']))
                      : "Não há previsão de saída",
                  status: status,
                  diariasParciais: dParcial,
                  diariasTotais: dTotal,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
