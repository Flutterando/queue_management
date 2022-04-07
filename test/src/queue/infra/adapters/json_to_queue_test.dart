import 'package:flutter_queue/src/queue/domain/entities/queue_entity.dart';
import 'package:flutter_queue/src/queue/domain/value_objects/order.dart';
import 'package:flutter_queue/src/queue/infra/adapters/json_to_queue.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('deve converter um map em um objeto do tipo QueueEntity', () {
    final queue = JsonToQueue.fromMap({
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
    });

    expect(queue, isA<QueueEntity>());
    expect(queue.title, 'title');
    expect(queue.priority, 1);
    expect(queue.orders.first.status, OrderStatus.attending);
  });

  test('deve converte QueueEntity to Map', () {
    final order = Order(
      position: 1,
      id: 'fdsfsdfsdf',
      timestamp: DateTime.now(),
      status: OrderStatus.wainting,
    );

    final queue = QueueEntity(
      id: 'fasfasfasf',
      title: 'title',
      orders: [order],
      abbr: 'abbr',
      priority: 1,
    );

    final map = JsonToQueue.toMap(queue);

    expect(map['id'], 'fasfasfasf');
    expect(map['title'], 'title');
    expect(map['orders'][0]['status'], 'wainting');
  });
}
