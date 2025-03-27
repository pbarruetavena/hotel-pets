import 'package:flutter/material.dart';
import 'package:hotel_pets/controller/animal_controller.dart';
import 'package:hotel_pets/controller/tutor_controller.dart';
import 'package:hotel_pets/pages/register/editar_estadia.dart';
import 'package:intl/intl.dart';
import '../controller/estadia_controller.dart';
import './register/registrar_estadia.dart';

class Historico extends StatefulWidget {
  const Historico({super.key});

  @override
  State<Historico> createState() => _HistoricoState();
}

class _HistoricoState extends State<Historico> {
  final EstadiaController controller = EstadiaController();
  AnimalController animalController = AnimalController();
  TutorController tutorController = TutorController();

  @override
  void initState() {
    super.initState();
    carregarHistorico();
  }

  void carregarHistorico() async {
    await controller.getEstadias();
    await animalController.getAnimais();
    await tutorController.getTutores();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text("Histórico"),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const RegistrarEstadia();
              }));
            },
            child: const Text("Adicionar estadia"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.estadias.length,
              itemBuilder: (context, index) {
                final estadia = controller.estadias[index];

                Map<String, dynamic> animal =
                    animalController.animais.firstWhere(
                  (element) => element['id'] == estadia['animalId'],
                  orElse: () => Map(),
                );

                Map<String, dynamic> tutor = tutorController.tutores.firstWhere(
                  (element) => element['id'] == animal['tutorId'],
                  orElse: () => Map(),
                );

                return ListTile(
                  // acertar o builder para uma classe separada
                  title: Text((DateFormat('dd/MM/yyyy')
                          .format(DateTime.parse(estadia['entrada']))) +
                      " * " +
                      (estadia['saida'] != null
                          ? DateFormat('dd/MM/yyyy')
                              .format(DateTime.parse(estadia['saida']))
                          : "Não há saída prevista")),
                  subtitle: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Text(animal['nome'] + " • " + animal['especie']),
                        Text(tutor['nome'] + " • " + tutor['email']),
                      ],
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) {
                            return EditarEstadia(
                              id: estadia['id'],
                              entrada: estadia['entrada'],
                              saida: estadia['saida'] ?? "",
                            );
                          }));

                          setState(() {
                            carregarHistorico();
                          });
                        },
                        child: const Icon(Icons.edit),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            await controller.deleteEstadias(estadia['id']);
                            setState(() {
                              carregarHistorico();
                            });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Estadia excluída"),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ));
                          } catch (err) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(err.toString()),
                            ));
                          }
                        },
                        child: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
