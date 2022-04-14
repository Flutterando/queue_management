import 'package:flutter_queue/src/queue/domain/entities/queue_entity.dart';
import 'package:flutter_queue/src/queue/domain/usecases/generate_order.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('deve gerar uma nova order.', () {
    final usecase = GenerateOrderUsecase();
    const queueEntity = QueueEntity(
      id: 'fdfsf',
      title: 'title',
      orders: [],
      abbr: 'abbr',
      priority: 1,
    );

    final result = usecase.call(queueEntity);

    expect(result.orders.length, 1);
    expect(result.orders.first.id, '0001');
    expect(result.orders.first.position, 1);
  });
}
