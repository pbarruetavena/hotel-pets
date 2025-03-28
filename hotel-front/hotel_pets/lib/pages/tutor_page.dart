import 'package:flutter/material.dart';
import './register/registrar_tutor.dart';
import './register/editar_tutor.dart';
import '../controller/tutor_controller.dart';

class TutorPage extends StatefulWidget {
  const TutorPage({super.key});

  @override
  State<TutorPage> createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  final TutorController controller = TutorController();

  @override
  void initState() {
    super.initState();
    carregarTutores();
  }

  void carregarTutores() async {
    await controller.getTutores();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Column(
        children: [
          const Text("Tutores"),
          ElevatedButton.icon(
            onPressed: () async {
              await Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const RegistrarTutor();
              }));
              setState(() {
                carregarTutores();
              });
            },
            icon: const Icon(Icons.add),
            label: const Text("Adicionar Tutor"),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: controller.tutores.length,
                itemBuilder: (context, index) {
                  final tutor = controller.tutores[index];
                  // print(index);
                  // print("debugando tutores");
                  return ListTile(
                    title: Text(tutor['nome']),
                    subtitle: Text(tutor['email']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            final res = await Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (BuildContext context) {
                              return EditarTutor(
                                id: tutor['id'],
                                nome: tutor['nome'],
                                email: tutor['email'],
                              );
                            }));
                            setState(() {
                              carregarTutores();
                            });
                          },
                          child: const Icon(Icons.edit),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              await controller.deleteTutor(tutor['id']);
                              setState(() {
                                carregarTutores();
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Operação realizada com sucesso!'),
                                  backgroundColor: Colors.green,
                                  duration: Duration(seconds: 2),
                                ),
                              );
                            } catch (err) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(err.toString()),
                              ));
                            }
                          },
                          child: const Icon(Icons.delete),
                        ),
                      ],
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
