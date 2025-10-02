import 'package:flutter_test/flutter_test.dart';
import 'package:assigment/models/food_item.dart';

void main() {
  group('FoodItem', () {
    const testFoodItem = FoodItem(
      id: '1',
      name: 'Test Pizza',
      description: 'A delicious test pizza',
      price: 12.99,
      imageUrl: 'https://example.com/pizza.jpg',
      category: 'Pizza',
      isVegetarian: true,
      isSpicy: false,
      preparationTime: 20,
    );

    test('should be equal when all properties are the same', () {
      const foodItem1 = FoodItem(
        id: '1',
        name: 'Test Pizza',
        description: 'A delicious test pizza',
        price: 12.99,
        imageUrl: 'https://example.com/pizza.jpg',
        category: 'Pizza',
        isVegetarian: true,
        isSpicy: false,
        preparationTime: 20,
      );

      const foodItem2 = FoodItem(
        id: '1',
        name: 'Test Pizza',
        description: 'A delicious test pizza',
        price: 12.99,
        imageUrl: 'https://example.com/pizza.jpg',
        category: 'Pizza',
        isVegetarian: true,
        isSpicy: false,
        preparationTime: 20,
      );

      expect(foodItem1, equals(foodItem2));
    });

    test('should not be equal when properties differ', () {
      const foodItem1 = FoodItem(
        id: '1',
        name: 'Test Pizza',
        description: 'A delicious test pizza',
        price: 12.99,
        imageUrl: 'https://example.com/pizza.jpg',
        category: 'Pizza',
        isVegetarian: true,
        isSpicy: false,
        preparationTime: 20,
      );

      const foodItem2 = FoodItem(
        id: '2',
        name: 'Test Pizza',
        description: 'A delicious test pizza',
        price: 12.99,
        imageUrl: 'https://example.com/pizza.jpg',
        category: 'Pizza',
        isVegetarian: true,
        isSpicy: false,
        preparationTime: 20,
      );

      expect(foodItem1, isNot(equals(foodItem2)));
    });

    test('should create a copy with updated properties', () {
      final updatedFoodItem = testFoodItem.copyWith(
        name: 'Updated Pizza',
        price: 15.99,
      );

      expect(updatedFoodItem.name, equals('Updated Pizza'));
      expect(updatedFoodItem.price, equals(15.99));
      expect(updatedFoodItem.id, equals(testFoodItem.id));
      expect(updatedFoodItem.description, equals(testFoodItem.description));
    });

    test('should have correct props for equality', () {
      expect(
        testFoodItem.props,
        equals([
          '1',
          'Test Pizza',
          'A delicious test pizza',
          12.99,
          'https://example.com/pizza.jpg',
          'Pizza',
          true,
          false,
          20,
        ]),
      );
    });
  });
}
