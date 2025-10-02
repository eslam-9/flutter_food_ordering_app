import 'package:equatable/equatable.dart';
import '../models/restaurant.dart';
import '../models/cart_item.dart';
import '../models/order.dart';

enum FoodOrderingStatus {
  initial,
  loading,
  loaded,
  error,
  orderPlaced,
  orderConfirmed,
}

class FoodOrderingState extends Equatable {
  final FoodOrderingStatus status;
  final List<Restaurant> restaurants;
  final List<Restaurant> filteredRestaurants;
  final Restaurant? selectedRestaurant;
  final List<CartItem> cartItems;
  final Order? currentOrder;
  final String? errorMessage;
  final String selectedCategory;

  const FoodOrderingState({
    this.status = FoodOrderingStatus.initial,
    this.restaurants = const [],
    this.filteredRestaurants = const [],
    this.selectedRestaurant,
    this.cartItems = const [],
    this.currentOrder,
    this.errorMessage,
    this.selectedCategory = 'All',
  });

  double get cartSubtotal {
    return cartItems.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  double get cartTotal {
    return cartSubtotal + deliveryFee + tax;
  }

  double get deliveryFee {
    if (selectedRestaurant != null &&
        cartSubtotal >= selectedRestaurant!.minimumOrder) {
      return selectedRestaurant!.deliveryFee;
    }
    return 0.0;
  }

  double get tax {
    return cartSubtotal * 0.08; // 8% tax
  }

  int get cartItemCount {
    return cartItems.fold(0, (sum, item) => sum + item.quantity);
  }

  bool get isCartEmpty => cartItems.isEmpty;

  bool get canPlaceOrder {
    return !isCartEmpty &&
        selectedRestaurant != null &&
        cartSubtotal >= selectedRestaurant!.minimumOrder;
  }

  @override
  List<Object?> get props => [
    status,
    restaurants,
    filteredRestaurants,
    selectedRestaurant,
    cartItems,
    currentOrder,
    errorMessage,
    selectedCategory,
  ];

  FoodOrderingState copyWith({
    FoodOrderingStatus? status,
    List<Restaurant>? restaurants,
    List<Restaurant>? filteredRestaurants,
    Restaurant? selectedRestaurant,
    List<CartItem>? cartItems,
    Order? currentOrder,
    String? errorMessage,
    String? selectedCategory,
  }) {
    return FoodOrderingState(
      status: status ?? this.status,
      restaurants: restaurants ?? this.restaurants,
      filteredRestaurants: filteredRestaurants ?? this.filteredRestaurants,
      selectedRestaurant: selectedRestaurant ?? this.selectedRestaurant,
      cartItems: cartItems ?? this.cartItems,
      currentOrder: currentOrder ?? this.currentOrder,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedCategory: selectedCategory ?? this.selectedCategory,
    );
  }
}
