import 'package:flutter/material.dart';
import 'package:hotel_pets/controller/tutor_controller.dart';
import '../controller/animal_controller.dart';
import './register/registrar_animal.dart';
import './register/editar_animal.dart';

class AnimalPage extends StatefulWidget {
  const AnimalPage({super.key});

  @override
  State<AnimalPage> createState() => _AnimalPageState();
}

class _AnimalPageState extends State<AnimalPage> {
  final AnimalController controller = AnimalController();
  final TutorController tutorController = TutorController();

  @override
  void initState() {
    super.initState();
    carregarAnimais();
  }

  void carregarAnimais() async {
    await controller.getAnimais();
    await tutorController.getTutores();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text("Animais"),
          ElevatedButton.icon(
            onPressed: () async {
              await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const RegistrarAnimal();
              }));
              setState(() {
                carregarAnimais();
              });
            },
            label: const Text("Adicionar animal"),
            icon: const Icon(Icons.add),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.animais.length,
              itemBuilder: (context, index) {
                final animal = controller.animais[index];

                Map<String, dynamic> tutor = tutorController.tutores.firstWhere(
                  (element) => element['id'] == animal['tutorId'],
                  orElse: () => Map(),
                );

                return ListTile(
                  title: Text(animal['nome']),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Espécie: ${animal['especie']}"),
                      Text("Raça: ${animal['raca']}"),
                      Text("Tutor: ${tutor['nome']} • ${tutor['email']}"),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          final res = await Navigator.of(context).push(
                              MaterialPageRoute(
                                  builder: (BuildContext context) {
                            return EditarAnimal(
                              id: animal['id'],
                              nome: animal['nome'],
                              especie: animal['especie'],
                              raca: animal['raca'],
                            );
                          }));

                          setState(() {
                            carregarAnimais();
                          });
                        },
                        child: const Icon(Icons.edit),
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          try {
                            await controller.deleteAnimais(animal['id']);
                            setState(() {
                              carregarAnimais();
                            });
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Animal excluído"),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ));
                          } catch (err) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(err.toString())));
                          }
                        },
                        child: const Icon(Icons.delete),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
