import 'package:flutter_test/flutter_test.dart';
import 'package:assigment/models/food_item.dart';
import 'package:assigment/models/cart_item.dart';

void main() {
  group('CartItem', () {
    const testFoodItem = FoodItem(
      id: '1',
      name: 'Test Pizza',
      description: 'A delicious test pizza',
      price: 12.99,
      imageUrl: 'https://example.com/pizza.jpg',
      category: 'Pizza',
    );

    const testCartItem = CartItem(
      foodItem: testFoodItem,
      quantity: 2,
      specialInstructions: ['Extra cheese', 'No onions'],
    );

    test('should calculate total price correctly', () {
      expect(testCartItem.totalPrice, equals(25.98));
    });

    test('should be equal when all properties are the same', () {
      const cartItem1 = CartItem(
        foodItem: testFoodItem,
        quantity: 2,
        specialInstructions: ['Extra cheese', 'No onions'],
      );

      const cartItem2 = CartItem(
        foodItem: testFoodItem,
        quantity: 2,
        specialInstructions: ['Extra cheese', 'No onions'],
      );

      expect(cartItem1, equals(cartItem2));
    });

    test('should create a copy with updated properties', () {
      final updatedCartItem = testCartItem.copyWith(
        quantity: 3,
        specialInstructions: ['Extra cheese'],
      );

      expect(updatedCartItem.quantity, equals(3));
      expect(updatedCartItem.specialInstructions, equals(['Extra cheese']));
      expect(updatedCartItem.foodItem, equals(testFoodItem));
    });

    test('should have correct props for equality', () {
      expect(
        testCartItem.props,
        equals([
          testFoodItem,
          2,
          ['Extra cheese', 'No onions'],
        ]),
      );
    });
  });
}
