import '../entities/queue_entity.dart';

abstract class IQueueRepository {
  Stream<List<QueueEntity>> getAllQueues();

  Future<void> addQueue(QueueEntity queue);

  Future<void> removeQueue(String id);

  Future<void> removeAllOrders();

  Future<void> updateQueue(QueueEntity queueEntity);
}
