import 'package:equatable/equatable.dart';

class FoodItem extends Equatable {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final bool isVegetarian;
  final bool isSpicy;
  final int preparationTime; // in minutes

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isVegetarian = false,
    this.isSpicy = false,
    this.preparationTime = 15,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    imageUrl,
    category,
    isVegetarian,
    isSpicy,
    preparationTime,
  ];

  FoodItem copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? imageUrl,
    String? category,
    bool? isVegetarian,
    bool? isSpicy,
    int? preparationTime,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isVegetarian: isVegetarian ?? this.isVegetarian,
      isSpicy: isSpicy ?? this.isSpicy,
      preparationTime: preparationTime ?? this.preparationTime,
    );
  }
}
