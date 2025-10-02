import 'package:flutter/material.dart';
import '../models/restaurant.dart';
import '../screens/cart_screen.dart';
import '../screens/checkout_screen.dart';
import '../screens/order_confirmation_screen.dart';
import '../screens/restaurant_list_screen.dart';
import '../screens/restaurant_menu_screen.dart';

class RouteGenerator {
  static const String restaurantList = '/';
  static const String restaurantMenu = '/restaurant-menu';
  static const String cart = '/cart';
  static const String checkout = '/checkout';
  static const String orderConfirmation = '/order-confirmation';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case restaurantList:
        return MaterialPageRoute(builder: (_) => const RestaurantListScreen());
      case restaurantMenu:
        if (args is Restaurant) {
          return MaterialPageRoute(
            builder: (_) => RestaurantMenuScreen(restaurant: args),
          );
        }
        return _errorRoute();
      case cart:
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case checkout:
        return MaterialPageRoute(builder: (_) => const CheckoutScreen());
      case orderConfirmation:
        return MaterialPageRoute(
          builder: (_) => const OrderConfirmationScreen(),
        );
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: const Center(child: Text('ERROR: Route not found!')),
        );
      },
    );
  }
}
