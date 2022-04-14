import 'package:flutter_queue/src/queue/domain/entities/queue_entity.dart';
import 'package:flutter_queue/src/queue/domain/value_objects/order.dart';

abstract class CheckinEvent {}

class FetchAllQueues implements CheckinEvent {}

class PrintOrder implements CheckinEvent {
  final Order order;

  PrintOrder(this.order);
}

class GenerateOrder implements CheckinEvent {
  final QueueEntity queue;

  GenerateOrder(this.queue);
}
