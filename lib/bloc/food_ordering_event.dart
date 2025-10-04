import 'package:equatable/equatable.dart';
import '../models/food_item.dart';
import '../models/restaurant.dart';
import '../models/order.dart';
import '../bloc/food_ordering_state.dart';

abstract class FoodOrderingEvent extends Equatable {
  const FoodOrderingEvent();

  @override
  List<Object?> get props => [];
}

// Restaurant Events
class LoadRestaurants extends FoodOrderingEvent {
  const LoadRestaurants();
}

class SelectRestaurant extends FoodOrderingEvent {
  final Restaurant restaurant;

  const SelectRestaurant(this.restaurant);

  @override
  List<Object?> get props => [restaurant];
}

class FilterRestaurantsByCategory extends FoodOrderingEvent {
  final String category;

  const FilterRestaurantsByCategory(this.category);

  @override
  List<Object?> get props => [category];
}

// Cart Events
class AddToCart extends FoodOrderingEvent {
  final FoodItem foodItem;
  final int quantity;
  final List<String> specialInstructions;

  const AddToCart({
    required this.foodItem,
    required this.quantity,
    this.specialInstructions = const [],
  });

  @override
  List<Object?> get props => [foodItem, quantity, specialInstructions];
}

class RemoveFromCart extends FoodOrderingEvent {
  final String foodItemId;

  const RemoveFromCart(this.foodItemId);

  @override
  List<Object?> get props => [foodItemId];
}

class UpdateCartItemQuantity extends FoodOrderingEvent {
  final String foodItemId;
  final int quantity;

  const UpdateCartItemQuantity({
    required this.foodItemId,
    required this.quantity,
  });

  @override
  List<Object?> get props => [foodItemId, quantity];
}

class ClearCart extends FoodOrderingEvent {
  const ClearCart();
}

// Payment Events
class SelectPaymentMethod extends FoodOrderingEvent {
  final PaymentMethod paymentMethod;

  const SelectPaymentMethod(this.paymentMethod);

  @override
  List<Object?> get props => [paymentMethod];
}

// Order Events
class PlaceOrder extends FoodOrderingEvent {
  final String customerName;
  final String customerPhone;
  final String deliveryAddress;
  final PaymentMethod paymentMethod;

  const PlaceOrder({
    required this.customerName,
    required this.customerPhone,
    required this.deliveryAddress,
    required this.paymentMethod,
  });

  @override
  List<Object?> get props => [
    customerName,
    customerPhone,
    deliveryAddress,
    paymentMethod,
  ];
}

class ProcessStripePayment extends FoodOrderingEvent {
  final String cardNumber;
  final int expiryMonth;
  final int expiryYear;
  final String cvc;
  final String cardholderName;
  final String email;

  const ProcessStripePayment({
    required this.cardNumber,
    required this.expiryMonth,
    required this.expiryYear,
    required this.cvc,
    required this.cardholderName,
    required this.email,
  });

  @override
  List<Object?> get props => [
    cardNumber,
    expiryMonth,
    expiryYear,
    cvc,
    cardholderName,
    email,
  ];
}

class UpdateOrderStatus extends FoodOrderingEvent {
  final String orderId;
  final OrderStatus status;

  const UpdateOrderStatus({required this.orderId, required this.status});

  @override
  List<Object?> get props => [orderId, status];
}

// Navigation Events
class NavigateToRestaurantMenu extends FoodOrderingEvent {
  final Restaurant restaurant;

  const NavigateToRestaurantMenu(this.restaurant);

  @override
  List<Object?> get props => [restaurant];
}

class NavigateToCart extends FoodOrderingEvent {
  const NavigateToCart();
}

class NavigateToCheckout extends FoodOrderingEvent {
  const NavigateToCheckout();
}

class NavigateBack extends FoodOrderingEvent {
  const NavigateBack();
}
