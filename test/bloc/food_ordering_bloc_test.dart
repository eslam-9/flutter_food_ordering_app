import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:assigment/bloc/food_ordering_bloc.dart';
import 'package:assigment/bloc/food_ordering_event.dart';
import 'package:assigment/bloc/food_ordering_state.dart';
import 'package:assigment/models/cart_item.dart';
import 'package:assigment/services/mock_data_service.dart';

void main() {
  group('FoodOrderingBloc', () {
    late FoodOrderingBloc foodOrderingBloc;

    setUp(() {
      foodOrderingBloc = FoodOrderingBloc();
    });

    tearDown(() {
      foodOrderingBloc.close();
    });

    test('initial state should be FoodOrderingState.initial', () {
      expect(foodOrderingBloc.state, const FoodOrderingState());
    });

    blocTest<FoodOrderingBloc, FoodOrderingState>(
      'emits [loading, loaded] when LoadRestaurants is added',
      build: () => foodOrderingBloc,
      act: (bloc) => bloc.add(const LoadRestaurants()),
      wait: const Duration(milliseconds: 600),
      expect: () => [
        const FoodOrderingState(status: FoodOrderingStatus.loading),
        FoodOrderingState(
          status: FoodOrderingStatus.loaded,
          restaurants: MockDataService.getRestaurants(),
          filteredRestaurants: MockDataService.getRestaurants(),
        ),
      ],
    );

    blocTest<FoodOrderingBloc, FoodOrderingState>(
      'emits updated state when SelectRestaurant is added',
      build: () => foodOrderingBloc,
      seed: () => FoodOrderingState(
        restaurants: MockDataService.getRestaurants(),
        filteredRestaurants: MockDataService.getRestaurants(),
      ),
      act: (bloc) =>
          bloc.add(SelectRestaurant(MockDataService.getRestaurants().first)),
      expect: () => [
        FoodOrderingState(
          restaurants: MockDataService.getRestaurants(),
          filteredRestaurants: MockDataService.getRestaurants(),
          selectedRestaurant: MockDataService.getRestaurants().first,
        ),
      ],
    );

    blocTest<FoodOrderingBloc, FoodOrderingState>(
      'emits updated state when AddToCart is added',
      build: () => foodOrderingBloc,
      seed: () => FoodOrderingState(
        restaurants: MockDataService.getRestaurants(),
        filteredRestaurants: MockDataService.getRestaurants(),
      ),
      act: (bloc) => bloc.add(
        AddToCart(
          foodItem: MockDataService.getRestaurants().first.menu.first,
          quantity: 1,
        ),
      ),
      expect: () => [
        FoodOrderingState(
          restaurants: MockDataService.getRestaurants(),
          filteredRestaurants: MockDataService.getRestaurants(),
          cartItems: [
            CartItem(
              foodItem: MockDataService.getRestaurants().first.menu.first,
              quantity: 1,
            ),
          ],
        ),
      ],
    );

    blocTest<FoodOrderingBloc, FoodOrderingState>(
      'emits updated state when RemoveFromCart is added',
      build: () => foodOrderingBloc,
      seed: () => FoodOrderingState(
        restaurants: MockDataService.getRestaurants(),
        filteredRestaurants: MockDataService.getRestaurants(),
        cartItems: [
          CartItem(
            foodItem: MockDataService.getRestaurants().first.menu.first,
            quantity: 1,
          ),
        ],
      ),
      act: (bloc) => bloc.add(
        RemoveFromCart(MockDataService.getRestaurants().first.menu.first.id),
      ),
      expect: () => [
        FoodOrderingState(
          restaurants: MockDataService.getRestaurants(),
          filteredRestaurants: MockDataService.getRestaurants(),
          cartItems: [],
        ),
      ],
    );

    blocTest<FoodOrderingBloc, FoodOrderingState>(
      'emits updated state when UpdateCartItemQuantity is added',
      build: () => foodOrderingBloc,
      seed: () => FoodOrderingState(
        restaurants: MockDataService.getRestaurants(),
        filteredRestaurants: MockDataService.getRestaurants(),
        cartItems: [
          CartItem(
            foodItem: MockDataService.getRestaurants().first.menu.first,
            quantity: 1,
          ),
        ],
      ),
      act: (bloc) => bloc.add(
        UpdateCartItemQuantity(
          foodItemId: MockDataService.getRestaurants().first.menu.first.id,
          quantity: 3,
        ),
      ),
      expect: () => [
        FoodOrderingState(
          restaurants: MockDataService.getRestaurants(),
          filteredRestaurants: MockDataService.getRestaurants(),
          cartItems: [
            CartItem(
              foodItem: MockDataService.getRestaurants().first.menu.first,
              quantity: 3,
            ),
          ],
        ),
      ],
    );

    blocTest<FoodOrderingBloc, FoodOrderingState>(
      'emits updated state when ClearCart is added',
      build: () => foodOrderingBloc,
      seed: () => FoodOrderingState(
        restaurants: MockDataService.getRestaurants(),
        filteredRestaurants: MockDataService.getRestaurants(),
        cartItems: [
          CartItem(
            foodItem: MockDataService.getRestaurants().first.menu.first,
            quantity: 1,
          ),
        ],
      ),
      act: (bloc) => bloc.add(const ClearCart()),
      expect: () => [
        FoodOrderingState(
          restaurants: MockDataService.getRestaurants(),
          filteredRestaurants: MockDataService.getRestaurants(),
          cartItems: [],
        ),
      ],
    );

    blocTest<FoodOrderingBloc, FoodOrderingState>(
      'emits updated state when FilterRestaurantsByCategory is added',
      build: () => foodOrderingBloc,
      seed: () => FoodOrderingState(
        restaurants: MockDataService.getRestaurants(),
        filteredRestaurants: MockDataService.getRestaurants(),
      ),
      act: (bloc) => bloc.add(const FilterRestaurantsByCategory('Italian')),
      expect: () => [
        FoodOrderingState(
          restaurants: MockDataService.getRestaurants(),
          filteredRestaurants: MockDataService.getRestaurants()
              .where((restaurant) => restaurant.cuisine == 'Italian')
              .toList(),
          selectedCategory: 'Italian',
        ),
      ],
    );
  });
}
