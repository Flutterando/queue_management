import 'package:flutter_queue/src/queue/domain/entities/queue_entity.dart';
import 'package:flutter_queue/src/queue/domain/value_objects/order.dart';

class QueueModel extends QueueEntity {
  QueueModel({
    required String id,
    required String title,
    required List<Order> orders,
    required String abbr,
    required int priority,
  }) : super(
          id: id,
          title: title,
          orders: orders,
          abbr: abbr,
          priority: priority,
        );

  factory QueueModel.empty() => QueueModel(
        abbr: '',
        id: '',
        orders: [],
        priority: 0,
        title: '',
      );

  QueueModel copyWith({
    String? id,
    String? title,
    List<Order>? orders,
    String? abbr,
    int? priority,
  }) {
    return QueueModel(
      id: id ?? this.id,
      title: title ?? this.title,
      orders: orders ?? this.orders,
      abbr: abbr ?? this.abbr,
      priority: priority ?? this.priority,
    );
  }
}
