import 'package:equatable/equatable.dart';
import 'cart_item.dart';
import 'restaurant.dart';

enum OrderStatus {
  pending,
  confirmed,
  preparing,
  ready,
  outForDelivery,
  delivered,
  cancelled,
}

class Order extends Equatable {
  final String id;
  final Restaurant restaurant;
  final List<CartItem> items;
  final double subtotal;
  final double deliveryFee;
  final double tax;
  final double total;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime? estimatedDeliveryTime;
  final String deliveryAddress;
  final String customerName;
  final String customerPhone;

  const Order({
    required this.id,
    required this.restaurant,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.tax,
    required this.total,
    required this.status,
    required this.createdAt,
    this.estimatedDeliveryTime,
    required this.deliveryAddress,
    required this.customerName,
    required this.customerPhone,
  });

  @override
  List<Object?> get props => [
    id,
    restaurant,
    items,
    subtotal,
    deliveryFee,
    tax,
    total,
    status,
    createdAt,
    estimatedDeliveryTime,
    deliveryAddress,
    customerName,
    customerPhone,
  ];

  Order copyWith({
    String? id,
    Restaurant? restaurant,
    List<CartItem>? items,
    double? subtotal,
    double? deliveryFee,
    double? tax,
    double? total,
    OrderStatus? status,
    DateTime? createdAt,
    DateTime? estimatedDeliveryTime,
    String? deliveryAddress,
    String? customerName,
    String? customerPhone,
  }) {
    return Order(
      id: id ?? this.id,
      restaurant: restaurant ?? this.restaurant,
      items: items ?? this.items,
      subtotal: subtotal ?? this.subtotal,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      tax: tax ?? this.tax,
      total: total ?? this.total,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      estimatedDeliveryTime:
          estimatedDeliveryTime ?? this.estimatedDeliveryTime,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      customerName: customerName ?? this.customerName,
      customerPhone: customerPhone ?? this.customerPhone,
    );
  }
}
