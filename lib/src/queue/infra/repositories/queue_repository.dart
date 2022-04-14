import 'package:flutter_queue/src/queue/domain/entities/queue_entity.dart';
import 'package:flutter_queue/src/queue/domain/repositories/queue_repository.dart';

import '../adapters/json_to_queue.dart';
import '../datasource/queue_datasource.dart';

class QueueRepository implements IQueueRepository {
  final IQueueDatasource datasource;

  QueueRepository(this.datasource);

  @override
  Stream<List<QueueEntity>> getAllQueues() {
    final stream = datasource.getAllQueues();

    return stream.map(_convert);
  }

  List<QueueEntity> _convert(List<Map> list) {
    return list.map(JsonToQueue.fromMap).toList();
  }

  @override
  Future<void> addQueue(QueueEntity queue) async {
    final map = JsonToQueue.toMap(queue);
    await datasource.addQueue(map);
  }

  @override
  Future<void> removeQueue(String id) async {
    await datasource.removeQueue(id);
  }

  @override
  Future<void> removeAllOrders() async {
    await datasource.removeAllOrders();
  }

  @override
  Future<void> updateQueue(QueueEntity queue) async {
    final map = JsonToQueue.toMap(queue);
    await datasource.updateQueue(map);
  }
}
