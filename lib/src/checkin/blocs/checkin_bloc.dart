import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_queue/src/checkin/events/checkin_event.dart';
import 'package:flutter_queue/src/checkin/states/checkin_state.dart';
import 'package:flutter_queue/src/queue/domain/usecases/generate_order.dart';
import 'package:flutter_queue/src/queue/domain/usecases/update_queue.dart';

import '../../queue/domain/entities/queue_entity.dart';
import '../../queue/domain/usecases/get_all_queues.dart';

class CheckinBloc extends Bloc<CheckinEvent, CheckinState> {
  final IGetAllQueues getAllQueues;
  final IGenerateOrderUsecase generateOrderUsecase;
  final IUpdateQueue updateQueue;

  CheckinBloc(
    this.getAllQueues,
    this.generateOrderUsecase,
    this.updateQueue,
  ) : super(InitialCheckinState()) {
    on<FetchAllQueues>(_fetchAllQueues);
    on<PrintOrder>(_printOrder);
    on<GenerateOrder>(_generateOrder);
  }

  Future<void> _fetchAllQueues(event, Emitter emit) async {
    await emit.onEach<List<QueueEntity>>(getAllQueues.call(), onData: (queues) {
      emit(SuccessCheckinState(queues));
    });
  }

  void _printOrder(PrintOrder event, emit) {}

  void _generateOrder(GenerateOrder event, emit) async {
    final queue = generateOrderUsecase.call(event.queue);
    final order = queue.orders.last;
    await updateQueue.call(queue);

    emit(GeneratedOrderCheckinState(order));
  }
}
