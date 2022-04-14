import 'package:flutter_queue/src/queue/domain/entities/queue_entity.dart';
import 'package:flutter_queue/src/queue/domain/value_objects/order.dart';

abstract class IGenerateOrderUsecase {
  QueueEntity call(QueueEntity queueEntity);
}

class GenerateOrderUsecase extends IGenerateOrderUsecase {
  @override
  QueueEntity call(QueueEntity queueEntity) {
    final orders = List<Order>.from(queueEntity.orders);

    final totalOrders = orders.length;
    final order = Order(
      id: _generateId(totalOrders + 1),
      position: totalOrders + 1,
      status: OrderStatus.wainting,
      timestamp: DateTime.now(),
    );

    orders.add(order);

    return QueueEntity(
      abbr: queueEntity.abbr,
      orders: orders,
      title: queueEntity.title,
      priority: queueEntity.priority,
      id: queueEntity.id,
    );
  }

  String _generateId(int id) {
    return '$id'.padLeft(4, '0');
  }
}
