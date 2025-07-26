import 'package:flutter/foundation.dart';

@immutable
class NutritionModel {
  final String calories;
  final String carbs;
  final String protein;
  final String fat;
  const NutritionModel({
    required this.calories,
    required this.carbs,
    required this.protein,
    required this.fat,
  });

  NutritionModel copyWith({
    String? calories,
    String? carbs,
    String? protein,
    String? fat,
  }) {
    return NutritionModel(
      calories: calories ?? this.calories,
      carbs: carbs ?? this.carbs,
      protein: protein ?? this.protein,
      fat: fat ?? this.fat,
    );
  }

  factory NutritionModel.fromMap(Map<String, dynamic> map) {
    return NutritionModel(
      calories: map['calories'] as String,
      carbs: map['carbs'] as String,
      protein: map['protein'] as String,
      fat: map['fat'] as String,
    );
  }

  @override
  String toString() =>
      'NutritionModel(calories: $calories, carbs: $carbs, protein: $protein, fat: $fat)';

  @override
  bool operator ==(covariant NutritionModel other) {
    if (identical(this, other)) return true;

    return other.calories == calories &&
        other.carbs == carbs &&
        other.protein == protein &&
        other.fat == fat;
  }

  @override
  int get hashCode =>
      calories.hashCode ^ carbs.hashCode ^ protein.hashCode ^ fat.hashCode;
}
