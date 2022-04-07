import 'package:flutter_queue/src/queue/domain/entities/queue_entity.dart';
import 'package:flutter_queue/src/queue/domain/repositories/queue_repository.dart';

abstract class IRemoveQueue {
  Future<void> call(QueueEntity queueEntity);
}

class RemoveQueue implements IRemoveQueue {
  final IQueueRepository repository;

  RemoveQueue(this.repository);

  @override
  Future<void> call(QueueEntity queueEntity) async {
    await repository.removeQueue(queueEntity.id);
  }
}
