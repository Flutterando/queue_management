import 'package:flutter_queue/src/queue/domain/entities/queue_entity.dart';

abstract class ConfigurationState {}

class EmptyConfigurationState implements ConfigurationState {}

class LoadingConfigurationState implements ConfigurationState {}

class LoadedConfigurationState implements ConfigurationState {
  final List<QueueEntity> queues;

  LoadedConfigurationState(this.queues);
}

class ExceptionConfigurationState implements ConfigurationState {
  final String message;

  ExceptionConfigurationState(this.message);
}
