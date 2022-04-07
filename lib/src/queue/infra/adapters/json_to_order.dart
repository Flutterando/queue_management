import '../../domain/value_objects/order.dart';

class JsonToOrder {
  static Order fromMap(dynamic json) {
    return Order(
      id: json['id'],
      position: json['position'],
      timestamp: DateTime.parse(json['timestamp']),
      status: OrderStatus.values.firstWhere((element) {
        return element.name == json['status'];
      }),
    );
  }

  static Map<String, dynamic> toMap(Order order) {
    return {
      'id': order.id,
      'position': order.position,
      'timestamp': order.timestamp.toIso8601String(),
      'status': order.status.name,
    };
  }
}
