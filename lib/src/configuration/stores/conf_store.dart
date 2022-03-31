import 'package:flutter_queue/src/configuration/states/conf_state.dart';
import 'package:flutter_queue/src/queue/domain/entities/queue_entity.dart';
import 'package:flutter_triple/flutter_triple.dart';

import '../../queue/domain/usecases/get_all_queues.dart';

class ConfStore extends StreamStore<Exception, List<QueueEntity>> {
  final IGetAllQueues getAllqueuesUsecase;

  ConfStore(this.getAllqueuesUsecase) : super([]) {
    executeStream(getAllqueuesUsecase.call());
  }
}
