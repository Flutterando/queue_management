import 'package:flutter/material.dart';
import 'package:flutter_queue/src/configuration/blocs/conf_bloc.dart';
import 'package:flutter_queue/src/configuration/states/conf_state.dart';
import 'package:provider/provider.dart';

class ConfigurationPage extends StatelessWidget {
  const ConfigurationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ConfBloc>();
    final state = bloc.state;

    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: const [
                Text('FILAS'),
                Spacer(),
                Icon(
                  Icons.add,
                ),
              ],
            ),
            if (state is LoadedConfState)
              ListView.builder(
                shrinkWrap: true,
                itemCount: state.queues.length,
                itemBuilder: (context, index) {
                  final queue = state.queues[index];
                  return ListTile(
                    title: Text('${queue.title} - ${queue.abbr}'),
                    subtitle: Text('${queue.priority} de prioridade'),
                    trailing: const Icon(
                      Icons.remove,
                      color: Colors.redAccent,
                    ),
                  );
                },
              ),
            const SizedBox(height: 10),
            const Text('CONTROLE'),
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.black),
              onPressed: () {},
              child: const Text('Reiniciar filas'),
            )
          ],
        ),
      ),
    );
  }
}
