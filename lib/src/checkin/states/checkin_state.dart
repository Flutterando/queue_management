import 'package:flutter_queue/src/queue/domain/entities/queue_entity.dart';

import '../../queue/domain/value_objects/order.dart';

abstract class CheckinState {}

class LoadingCheckinState implements CheckinState {}

class InitialCheckinState implements CheckinState {}

class SuccessCheckinState implements CheckinState {
  final List<QueueEntity> queues;

  SuccessCheckinState(this.queues);
}

class GeneratedOrderCheckinState implements CheckinState {
  final Order order;

  GeneratedOrderCheckinState(this.order);
}

class ExceptionCheckinState implements CheckinState {
  final String message;

  ExceptionCheckinState(this.message);
}
