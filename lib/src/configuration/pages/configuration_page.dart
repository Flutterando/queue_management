import 'package:flutter/material.dart';
import 'package:flutter_queue/src/configuration/blocs/configuration_bloc.dart';
import 'package:flutter_queue/src/configuration/states/conf_state.dart';
import 'package:provider/provider.dart';

import '../events/conf_event.dart';
import '../models/queue_model.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({Key? key}) : super(key: key);

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> with CompleteStateMixin {
  @override
  void completeState() {
    context.read<ConfigurationBloc>().add(FetchQueues());
  }

  void _addeNewQueueDialog() {
    showDialog(
      context: context,
      builder: (context) {
        var queue = QueueModel.empty();

        return AlertDialog(
          title: const Text('Nova fila'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                onChanged: (value) {
                  queue = queue.copyWith(title: value);
                },
                decoration: const InputDecoration(
                  labelText: 'Título',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) {
                  queue = queue.copyWith(abbr: value);
                },
                decoration: const InputDecoration(
                  labelText: 'Abreviação',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onChanged: (value) {
                  queue = queue.copyWith(priority: int.tryParse(value));
                },
                decoration: const InputDecoration(
                  labelText: 'Prioridade',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                context.read<ConfigurationBloc>().add(AddNewQueueEvent(queue));
                Navigator.pop(context);
              },
              child: const Text('Adicionar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.watch<ConfigurationBloc>();
    final state = bloc.state;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(18),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text('FILAS'),
                  const Spacer(),
                  IconButton(
                    onPressed: _addeNewQueueDialog,
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              if (state is LoadedConfigurationState)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.queues.length,
                  itemBuilder: (context, index) {
                    final queue = state.queues[index];
                    return ListTile(
                      title: Text('${queue.title} - ${queue.abbr}'),
                      subtitle: Text('${queue.priority} de prioridade'),
                      trailing: IconButton(
                        onPressed: () {
                          bloc.add(RemoveQueueEvent(queue));
                        },
                        icon: const Icon(
                          Icons.remove,
                          color: Colors.redAccent,
                        ),
                      ),
                    );
                  },
                ),
              const SizedBox(height: 10),
              const Text('CONTROLE'),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(primary: Colors.black),
                onPressed: () {
                  bloc.add(RemoveAllOrdersEvent());
                },
                child: const Text('Reiniciar filas'),
              )
            ],
          ),
        ),
      ),
    );
  }
}

mixin CompleteStateMixin<T extends StatefulWidget> on State<T> {
  void completeState();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      completeState();
    });
  }
}
