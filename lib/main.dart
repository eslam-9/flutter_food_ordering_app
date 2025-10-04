import 'package:assigment/bloc/route_generator.dart';
import 'package:assigment/services/stripe_keys.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bloc/food_ordering_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  Stripe.publishableKey = Stripekeys.publishablekey;
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
        initialRoute: RouteGenerator.restaurantList,
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
