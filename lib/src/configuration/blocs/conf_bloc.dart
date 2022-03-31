import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_queue/src/configuration/events/conf_event.dart';
import 'package:flutter_queue/src/configuration/states/conf_state.dart';
import 'package:flutter_queue/src/queue/domain/usecases/get_all_queues.dart';

class ConfBloc extends Bloc<ConfEvent, ConfState> {
  final IGetAllQueues getAllqueuesUsecase;
  late final StreamSubscription _sub;

  ConfBloc(this.getAllqueuesUsecase) : super(EmptyConfState()) {
    _sub = getAllqueuesUsecase.call().listen((data) {
      add(AddQueues(data));
    });

    on<AddQueues>((event, emit) => emit(LoadedConfState(event.queues)));
  }

  @override
  Future<void> close() async {
    await _sub.cancel();
    await super.close();
  }
}
