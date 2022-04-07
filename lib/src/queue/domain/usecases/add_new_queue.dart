import '../entities/queue_entity.dart';
import '../repositories/queue_repository.dart';

abstract class IAddNewQueue {
  Future<void> call(QueueEntity queue);
}

class AddNewQueue implements IAddNewQueue {
  final IQueueRepository repository;

  AddNewQueue(this.repository);

  @override
  Future<void> call(QueueEntity queue) async {
    return await repository.addQueue(queue);
  }
}
