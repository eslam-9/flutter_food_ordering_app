import 'package:equatable/equatable.dart';
import 'food_item.dart';

class Restaurant extends Equatable {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final double rating;
  final int reviewCount;
  final String cuisine;
  final int deliveryTime; // in minutes
  final double deliveryFee;
  final double minimumOrder;
  final List<FoodItem> menu;

  const Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.rating,
    required this.reviewCount,
    required this.cuisine,
    required this.deliveryTime,
    required this.deliveryFee,
    required this.minimumOrder,
    required this.menu,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    imageUrl,
    rating,
    reviewCount,
    cuisine,
    deliveryTime,
    deliveryFee,
    minimumOrder,
    menu,
  ];

  Restaurant copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    double? rating,
    int? reviewCount,
    String? cuisine,
    int? deliveryTime,
    double? deliveryFee,
    double? minimumOrder,
    List<FoodItem>? menu,
  }) {
    return Restaurant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      rating: rating ?? this.rating,
      reviewCount: reviewCount ?? this.reviewCount,
      cuisine: cuisine ?? this.cuisine,
      deliveryTime: deliveryTime ?? this.deliveryTime,
      deliveryFee: deliveryFee ?? this.deliveryFee,
      minimumOrder: minimumOrder ?? this.minimumOrder,
      menu: menu ?? this.menu,
    );
  }
}
