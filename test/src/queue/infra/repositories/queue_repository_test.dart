import 'package:flutter_queue/src/queue/domain/entities/queue_entity.dart';
import 'package:flutter_queue/src/queue/infra/repositories/queue_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../mocks/mocks.dart';

void main() {
  test('queue repository getAllQueues', () {
    final datasource = IQueueDatasourceMock();
    when(() => datasource.getAllQueues()).thenAnswer(
      (_) => Stream.value(
        [
          {
            'id': 'dfsdfsd',
            'title': 'title',
            'priority': 1,
            'abbr': 'sd',
            'orders': [
              {
                'id': 'dfsdfsd',
                'position': 1,
                'status': 'attending',
                'timestamp': '2022-03-31 18:37:30',
              },
            ],
          }
        ],
      ),
    );

    final repository = QueueRepository(datasource);

    final result = repository.getAllQueues();
    expect(result, emits(isA<List<QueueEntity>>()));
  });

  test('deve adicionar uma nova queue', () {
    final datasource = IQueueDatasourceMock();
    const queue = QueueEntity(
      id: 'fdfs',
      abbr: 'nbg',
      orders: [],
      priority: 1,
      title: 'dsd',
    );
    when(() => datasource.addQueue(any())).thenAnswer((_) => Future.value());
    final repository = QueueRepository(datasource);

    expect(repository.addQueue(queue), completes);
  });
}
