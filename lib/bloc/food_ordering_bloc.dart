import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/order.dart';
import '../models/cart_item.dart';
import '../models/restaurant.dart';
import '../services/mock_data_service.dart';
import 'food_ordering_event.dart';
import 'food_ordering_state.dart';

class FoodOrderingBloc extends Bloc<FoodOrderingEvent, FoodOrderingState> {
  FoodOrderingBloc() : super(const FoodOrderingState()) {
    on<LoadRestaurants>(_onLoadRestaurants);
    on<SelectRestaurant>(_onSelectRestaurant);
    on<FilterRestaurantsByCategory>(_onFilterRestaurantsByCategory);
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<UpdateCartItemQuantity>(_onUpdateCartItemQuantity);
    on<ClearCart>(_onClearCart);
    on<PlaceOrder>(_onPlaceOrder);
    on<UpdateOrderStatus>(_onUpdateOrderStatus);
    on<NavigateToRestaurantMenu>(_onNavigateToRestaurantMenu);
    on<NavigateToCart>(_onNavigateToCart);
    on<NavigateToCheckout>(_onNavigateToCheckout);
    on<NavigateBack>(_onNavigateBack);
  }

  Future<void> _onLoadRestaurants(
    LoadRestaurants event,
    Emitter<FoodOrderingState> emit,
  ) async {
    try {
      emit(state.copyWith(status: FoodOrderingStatus.loading));

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 500));

      final restaurants = MockDataService.getRestaurants();

      emit(
        state.copyWith(
          status: FoodOrderingStatus.loaded,
          restaurants: restaurants,
          filteredRestaurants: restaurants,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FoodOrderingStatus.error,
          errorMessage: 'Failed to load restaurants: ${e.toString()}',
        ),
      );
    }
  }

  void _onSelectRestaurant(
    SelectRestaurant event,
    Emitter<FoodOrderingState> emit,
  ) {
    emit(state.copyWith(selectedRestaurant: event.restaurant));
  }

  void _onFilterRestaurantsByCategory(
    FilterRestaurantsByCategory event,
    Emitter<FoodOrderingState> emit,
  ) {
    List<Restaurant> filtered = state.restaurants;

    if (event.category != 'All') {
      filtered = state.restaurants.where((restaurant) {
        return restaurant.cuisine == event.category;
      }).toList();
    }

    emit(
      state.copyWith(
        filteredRestaurants: filtered,
        selectedCategory: event.category,
      ),
    );
  }

  void _onAddToCart(AddToCart event, Emitter<FoodOrderingState> emit) {
    final existingItemIndex = state.cartItems.indexWhere(
      (item) => item.foodItem.id == event.foodItem.id,
    );

    List<CartItem> updatedCartItems = List.from(state.cartItems);

    if (existingItemIndex >= 0) {
      // Update existing item
      final existingItem = updatedCartItems[existingItemIndex];
      updatedCartItems[existingItemIndex] = existingItem.copyWith(
        quantity: existingItem.quantity + event.quantity,
      );
    } else {
      // Add new item
      updatedCartItems.add(
        CartItem(
          foodItem: event.foodItem,
          quantity: event.quantity,
          specialInstructions: event.specialInstructions,
        ),
      );
    }

    emit(state.copyWith(cartItems: updatedCartItems));
  }

  void _onRemoveFromCart(
    RemoveFromCart event,
    Emitter<FoodOrderingState> emit,
  ) {
    final updatedCartItems = state.cartItems
        .where((item) => item.foodItem.id != event.foodItemId)
        .toList();

    emit(state.copyWith(cartItems: updatedCartItems));
  }

  void _onUpdateCartItemQuantity(
    UpdateCartItemQuantity event,
    Emitter<FoodOrderingState> emit,
  ) {
    if (event.quantity <= 0) {
      add(RemoveFromCart(event.foodItemId));
      return;
    }

    final updatedCartItems = state.cartItems.map((item) {
      if (item.foodItem.id == event.foodItemId) {
        return item.copyWith(quantity: event.quantity);
      }
      return item;
    }).toList();

    emit(state.copyWith(cartItems: updatedCartItems));
  }

  void _onClearCart(ClearCart event, Emitter<FoodOrderingState> emit) {
    emit(state.copyWith(cartItems: []));
  }

  Future<void> _onPlaceOrder(
    PlaceOrder event,
    Emitter<FoodOrderingState> emit,
  ) async {
    if (!state.canPlaceOrder) {
      emit(
        state.copyWith(
          status: FoodOrderingStatus.error,
          errorMessage:
              'Cannot place order. Please check your cart and minimum order amount.',
        ),
      );
      return;
    }

    try {
      emit(state.copyWith(status: FoodOrderingStatus.loading));

      // Simulate API call delay
      await Future.delayed(const Duration(milliseconds: 1000));

      final order = Order(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        restaurant: state.selectedRestaurant!,
        items: state.cartItems,
        subtotal: state.cartSubtotal,
        deliveryFee: state.deliveryFee,
        tax: state.tax,
        total: state.cartTotal,
        status: OrderStatus.pending,
        createdAt: DateTime.now(),
        estimatedDeliveryTime: DateTime.now().add(
          Duration(minutes: state.selectedRestaurant!.deliveryTime),
        ),
        deliveryAddress: event.deliveryAddress,
        customerName: event.customerName,
        customerPhone: event.customerPhone,
      );

      emit(
        state.copyWith(
          status: FoodOrderingStatus.orderPlaced,
          currentOrder: order,
          cartItems: [], // Clear cart after successful order
        ),
      );

      // Simulate order confirmation after a delay
      await Future.delayed(const Duration(seconds: 2));

      emit(
        state.copyWith(
          status: FoodOrderingStatus.orderConfirmed,
          currentOrder: order.copyWith(status: OrderStatus.confirmed),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FoodOrderingStatus.error,
          errorMessage: 'Failed to place order: ${e.toString()}',
        ),
      );
    }
  }

  void _onUpdateOrderStatus(
    UpdateOrderStatus event,
    Emitter<FoodOrderingState> emit,
  ) {
    if (state.currentOrder?.id == event.orderId) {
      final updatedOrder = state.currentOrder!.copyWith(status: event.status);
      emit(state.copyWith(currentOrder: updatedOrder));
    }
  }

  void _onNavigateToRestaurantMenu(
    NavigateToRestaurantMenu event,
    Emitter<FoodOrderingState> emit,
  ) {
    emit(state.copyWith(selectedRestaurant: event.restaurant));
  }

  void _onNavigateToCart(
    NavigateToCart event,
    Emitter<FoodOrderingState> emit,
  ) {
    // Navigation is handled by the UI layer
  }

  void _onNavigateToCheckout(
    NavigateToCheckout event,
    Emitter<FoodOrderingState> emit,
  ) {
    // Navigation is handled by the UI layer
  }

  void _onNavigateBack(NavigateBack event, Emitter<FoodOrderingState> emit) {
    // Navigation is handled by the UI layer
  }
}
