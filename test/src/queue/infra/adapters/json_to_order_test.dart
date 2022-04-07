import 'package:flutter_queue/src/queue/domain/value_objects/order.dart';
import 'package:flutter_queue/src/queue/infra/adapters/json_to_order.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('deve converter um map em um objeto do tipo Order', () {
    final order = JsonToOrder.fromMap({
      'id': 'dfsdfsd',
      'position': 1,
      'status': 'attending',
      'timestamp': '2022-03-31 18:37:30',
    });

    expect(order, isA<Order>());
    expect(order.status, OrderStatus.attending);
  });

  test('deve converter um Order em Map', () {
    final order = Order(
      position: 1,
      id: 'fdsfsdfsdf',
      timestamp: DateTime.now(),
      status: OrderStatus.wainting,
    );

    final map = JsonToOrder.toMap(order);

    expect(map['id'], 'fdsfsdfsdf');
    expect(map['status'], 'wainting');
    expect(map['position'], 1);
  });
}
