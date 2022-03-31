import 'package:flutter_queue/src/queue/domain/entities/queue_entity.dart';

abstract class ConfState {}

class EmptyConfState implements ConfState {}

class LoadingConfState implements ConfState {}

class LoadedConfState implements ConfState {
  final List<QueueEntity> queues;

  LoadedConfState(this.queues);
}

class ExceptionConfState implements ConfState {
  final String message;

  ExceptionConfState(this.message);
}
