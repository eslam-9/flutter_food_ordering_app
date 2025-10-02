import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bloc/food_ordering_bloc.dart';
import 'screens/restaurant_list_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/checkout_screen.dart';
import 'screens/order_confirmation_screen.dart';

void main() {
  runApp(const FoodOrderingApp());
}

class FoodOrderingApp extends StatelessWidget {
  const FoodOrderingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FoodOrderingBloc(),
      child: MaterialApp(
        title: 'Food Delivery App',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          fontFamily: GoogleFonts.poppins().fontFamily,
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.orange,
            brightness: Brightness.light,
          ),
        ),
        home: const RestaurantListScreen(),
        routes: {
          '/cart': (context) => const CartScreen(),
          '/checkout': (context) => const CheckoutScreen(),
          '/order-confirmation': (context) => const OrderConfirmationScreen(),
        },
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
