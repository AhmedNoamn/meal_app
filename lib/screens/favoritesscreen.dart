import 'package:flutter/material.dart';
import '../widgets/category_meal.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Meal> favoritesmeal;

  FavoritesScreen(this.favoritesmeal);

  @override
  Widget build(BuildContext context) {
    if (favoritesmeal.isEmpty) {
      return Center(
        child: Text("You do not have favories yet * try adding some"),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return Mealitem(
            id: favoritesmeal[index].id,
            imageUrl: favoritesmeal[index].imageUrl,
            title: favoritesmeal[index].title,
            duration: favoritesmeal[index].duration,
            complexity: favoritesmeal[index].complexity,
            affordability: favoritesmeal[index].affordability,
          );
        },
        itemCount: favoritesmeal.length,
      );
    }
  }
}
