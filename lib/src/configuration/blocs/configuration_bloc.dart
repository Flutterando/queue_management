import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_queue/src/configuration/events/conf_event.dart';
import 'package:flutter_queue/src/configuration/states/conf_state.dart';
import 'package:flutter_queue/src/queue/domain/usecases/get_all_queues.dart';

import '../../queue/domain/entities/queue_entity.dart';
import '../../queue/domain/usecases/add_new_queue.dart';
import '../../queue/domain/usecases/remove_all_orders.dart';
import '../../queue/domain/usecases/remove_queue.dart';

class ConfigurationBloc extends Bloc<ConfigurationEvent, ConfigurationState> {
  final IGetAllQueues getAllqueuesUsecase;
  final IAddNewQueue addNewQueueUsecase;
  final IRemoveQueue removeQueueUsecase;
  final IRemoveAllOrders removeAllOrders;

  ConfigurationBloc(
    this.getAllqueuesUsecase,
    this.addNewQueueUsecase,
    this.removeQueueUsecase,
    this.removeAllOrders,
  ) : super(EmptyConfigurationState()) {
    on<FetchQueues>(_fetchQueues, transformer: restartable());
    on<AddNewQueueEvent>(_addNewQueue, transformer: sequential());
    on<RemoveQueueEvent>(_removeQueueEvent, transformer: sequential());
    on<RemoveAllOrdersEvent>(_removeAllOrdersEvent, transformer: droppable());
  }

  Future<void> _removeAllOrdersEvent(RemoveAllOrdersEvent event, emit) async {
    await removeAllOrders.call();
  }

  Future<void> _addNewQueue(AddNewQueueEvent event, emit) async {
    await addNewQueueUsecase.call(event.queue);
  }

  Future<void> _removeQueueEvent(RemoveQueueEvent event, emit) async {
    await removeQueueUsecase.call(event.queue);
  }

  Future<void> _fetchQueues(event, Emitter emit) async {
    emit(LoadingConfigurationState());

    await emit.onEach<List<QueueEntity>>(getAllqueuesUsecase.call(), onData: (queues) {
      emit(LoadedConfigurationState(queues));
    }, onError: (error, st) {
      emit(ExceptionConfigurationState(error.toString()));
    });
  }
}
