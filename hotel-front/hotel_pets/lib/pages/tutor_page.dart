import 'package:flutter/material.dart';
import './register/registrar_tutor.dart';

class TutorPage extends StatefulWidget {
  const TutorPage({super.key});

  @override
  State<TutorPage> createState() => _TutorPageState();
}

class _TutorPageState extends State<TutorPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      child: Column(
        children: [
          const Text("Tutores"),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (BuildContext context) {
                return const RegistrarTutor();
              }));
            },
            icon: const Icon(Icons.add),
            label: const Text("Adicionar Tutor"),
          ),
        ],
      ),
    );
  }
}
