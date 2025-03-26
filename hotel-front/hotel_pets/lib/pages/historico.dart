import 'package:flutter/material.dart';
import '../controller/estadia_controller.dart';

class Historico extends StatefulWidget {
  const Historico({super.key});

  @override
  State<Historico> createState() => _HistoricoState();
}

class _HistoricoState extends State<Historico> {
  final EstadiaController controller = EstadiaController();

  @override
  void initState() {
    super.initState();
    carregarHistorico();
  }

  void carregarHistorico() async {
    await controller.getEstadias();
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
            onPressed: () {},
            child: const Text("Adicionar estadia"),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: controller.estadias.length,
              itemBuilder: (context, index) {
                final estadia = controller.estadias[index];

                return ListTile(
                  // acertar o builder para uma classe separada
                  title: Text(estadia['entrada']),
                  subtitle: Text(estadia['saida']),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        child: const Icon(Icons.edit),
                      ),
                      ElevatedButton(
                        onPressed: () {},
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
