import 'package:flutter_queue/src/queue/domain/entities/queue_entity.dart';
import 'package:flutter_queue/src/queue/domain/value_objects/order.dart';

import 'json_to_order.dart';

class JsonToQueue {
  static QueueEntity fromMap(dynamic json) {
    return QueueEntity(
      id: json['id'],
      title: json['title'],
      priority: json['priority'],
      abbr: json['abbr'],
      orders: [
        if (json.containsKey('orders')) ...(json['orders'] as List).map(JsonToOrder.fromMap).toList(),
      ],
    );
  }

  static Map<String, dynamic> toMap(QueueEntity queue) {
    return {
      'id': queue.id,
      'title': queue.title,
      'priority': queue.priority,
      'abbr': queue.abbr,
      'orders': queue.orders.map((order) => JsonToOrder.toMap(order)).toList(),
    };
  }
}
