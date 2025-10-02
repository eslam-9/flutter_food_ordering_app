import '../models/food_item.dart';
import '../models/restaurant.dart';

class MockDataService {
  static List<Restaurant> getRestaurants() {
    return [
      Restaurant(
        id: '1',
        name: 'Pizza Palace',
        description: 'Authentic Italian pizza with fresh ingredients',
        imageUrl:
            'https://images.unsplash.com/photo-1513104890138-7c749659a591?w=400',
        rating: 4.5,
        reviewCount: 1247,
        cuisine: 'Italian',
        deliveryTime: 25,
        deliveryFee: 2.99,
        minimumOrder: 15.0,
        menu: [
          FoodItem(
            id: '1',
            name: 'Margherita Pizza',
            description: 'Fresh mozzarella, tomato sauce, and basil',
            price: 12.99,
            imageUrl:
                'https://images.unsplash.com/photo-1604382354936-07c5d9983bd3?w=300',
            category: 'Pizza',
            isVegetarian: true,
            preparationTime: 20,
          ),
          FoodItem(
            id: '2',
            name: 'Pepperoni Pizza',
            description: 'Classic pepperoni with mozzarella cheese',
            price: 14.99,
            imageUrl:
                'https://images.unsplash.com/photo-1628840042765-356cda07504e?w=300',
            category: 'Pizza',
            preparationTime: 20,
          ),
          FoodItem(
            id: '3',
            name: 'Caesar Salad',
            description: 'Fresh romaine lettuce with caesar dressing',
            price: 8.99,
            imageUrl:
                'https://images.unsplash.com/photo-1546793665-c74683f339c1?w=300',
            category: 'Salad',
            isVegetarian: true,
            preparationTime: 10,
          ),
        ],
      ),
      Restaurant(
        id: '2',
        name: 'Burger Junction',
        description: 'Gourmet burgers made with premium beef',
        imageUrl:
            'https://images.unsplash.com/photo-1571091718767-18b5b1457add?w=400',
        rating: 4.3,
        reviewCount: 892,
        cuisine: 'American',
        deliveryTime: 20,
        deliveryFee: 1.99,
        minimumOrder: 12.0,
        menu: [
          FoodItem(
            id: '4',
            name: 'Classic Cheeseburger',
            description: 'Beef patty with cheese, lettuce, tomato, and onion',
            price: 9.99,
            imageUrl:
                'https://images.unsplash.com/photo-1568901346375-23c9450c58cd?w=300',
            category: 'Burger',
            preparationTime: 15,
          ),
          FoodItem(
            id: '5',
            name: 'Bacon Burger',
            description: 'Beef patty with crispy bacon and cheese',
            price: 11.99,
            imageUrl:
                'https://images.unsplash.com/photo-1553979459-d2229ba7433a?w=300',
            category: 'Burger',
            preparationTime: 15,
          ),
          FoodItem(
            id: '6',
            name: 'French Fries',
            description: 'Crispy golden french fries',
            price: 4.99,
            imageUrl:
                'https://images.unsplash.com/photo-1573080496219-bb080dd4f877?w=300',
            category: 'Sides',
            isVegetarian: true,
            preparationTime: 8,
          ),
        ],
      ),
      Restaurant(
        id: '3',
        name: 'Sushi Zen',
        description: 'Fresh sushi and Japanese cuisine',
        imageUrl:
            'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=400',
        rating: 4.7,
        reviewCount: 1563,
        cuisine: 'Japanese',
        deliveryTime: 30,
        deliveryFee: 3.99,
        minimumOrder: 20.0,
        menu: [
          FoodItem(
            id: '7',
            name: 'California Roll',
            description: 'Crab, avocado, and cucumber roll',
            price: 8.99,
            imageUrl:
                'https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=300',
            category: 'Sushi',
            preparationTime: 12,
          ),
          FoodItem(
            id: '8',
            name: 'Salmon Nigiri',
            description: 'Fresh salmon over seasoned rice',
            price: 12.99,
            imageUrl:
                'https://images.unsplash.com/photo-1563612116625-3012372fccce?w=300',
            category: 'Sushi',
            preparationTime: 10,
          ),
          FoodItem(
            id: '9',
            name: 'Miso Soup',
            description: 'Traditional Japanese miso soup',
            price: 3.99,
            imageUrl:
                'https://images.unsplash.com/photo-1546833999-b9f581a1996d?w=300',
            category: 'Soup',
            isVegetarian: true,
            preparationTime: 5,
          ),
        ],
      ),
      Restaurant(
        id: '4',
        name: 'Taco Fiesta',
        description: 'Authentic Mexican tacos and burritos',
        imageUrl:
            'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=400',
        rating: 4.2,
        reviewCount: 743,
        cuisine: 'Mexican',
        deliveryTime: 18,
        deliveryFee: 2.49,
        minimumOrder: 10.0,
        menu: [
          FoodItem(
            id: '10',
            name: 'Chicken Tacos',
            description: 'Three soft tacos with grilled chicken',
            price: 7.99,
            imageUrl:
                'https://images.unsplash.com/photo-1565299624946-b28f40a0ca4b?w=300',
            category: 'Tacos',
            preparationTime: 12,
          ),
          FoodItem(
            id: '11',
            name: 'Beef Burrito',
            description: 'Large burrito with seasoned beef and rice',
            price: 9.99,
            imageUrl:
                'https://images.unsplash.com/photo-1551504734-5ee1c4a1479b?w=300',
            category: 'Burrito',
            preparationTime: 15,
          ),
          FoodItem(
            id: '12',
            name: 'Guacamole',
            description: 'Fresh homemade guacamole',
            price: 4.99,
            imageUrl:
                'https://images.unsplash.com/photo-1551782450-17144efb9c50?w=300',
            category: 'Sides',
            isVegetarian: true,
            preparationTime: 8,
          ),
        ],
      ),
    ];
  }

  static List<String> getCategories() {
    return [
      'All',
      'Pizza',
      'Burger',
      'Sushi',
      'Tacos',
      'Salad',
      'Sides',
      'Soup',
    ];
  }
}
