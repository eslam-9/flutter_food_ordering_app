import 'package:equatable/equatable.dart';
import 'food_item.dart';

class CartItem extends Equatable {
  final FoodItem foodItem;
  final int quantity;
  final List<String> specialInstructions;

  const CartItem({
    required this.foodItem,
    required this.quantity,
    this.specialInstructions = const [],
  });

  double get totalPrice => foodItem.price * quantity;

  @override
  List<Object?> get props => [foodItem, quantity, specialInstructions];

  CartItem copyWith({
    FoodItem? foodItem,
    int? quantity,
    List<String>? specialInstructions,
  }) {
    return CartItem(
      foodItem: foodItem ?? this.foodItem,
      quantity: quantity ?? this.quantity,
      specialInstructions: specialInstructions ?? this.specialInstructions,
    );
  }
}
