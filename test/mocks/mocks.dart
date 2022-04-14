import 'package:flutter_queue/src/queue/domain/entities/queue_entity.dart';
import 'package:flutter_queue/src/queue/domain/repositories/queue_repository.dart';
import 'package:flutter_queue/src/queue/domain/usecases/add_new_queue.dart';
import 'package:flutter_queue/src/queue/domain/usecases/get_all_queues.dart';
import 'package:flutter_queue/src/queue/domain/usecases/remove_all_orders.dart';
import 'package:flutter_queue/src/queue/domain/usecases/remove_queue.dart';
import 'package:flutter_queue/src/queue/infra/datasource/queue_datasource.dart';
import 'package:mocktail/mocktail.dart';

class QueueRepositoryMock extends Mock implements IQueueRepository {}

class QueueEntityMock extends Mock implements QueueEntity {}

class IQueueDatasourceMock extends Mock implements IQueueDatasource {}

class IGetAllQueuesMock extends Mock implements IGetAllQueues {}

class IRemoveQueueMock extends Mock implements IRemoveQueue {}

class IAddNewQueueMock extends Mock implements IAddNewQueue {}

class IRemoveAllOrdersMock extends Mock implements IRemoveAllOrders {}
