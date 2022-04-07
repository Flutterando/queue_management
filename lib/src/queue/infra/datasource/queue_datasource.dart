import 'package:flutter_queue/src/queue/domain/entities/queue_entity.dart';

abstract class IQueueDatasource {
  Stream<List<Map>> getAllQueues();
  Future<void> addQueue(Map<String, dynamic> queueMap);
  Future<void> removeQueue(String id);
}
